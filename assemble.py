#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""
Assembles the micro tile container from the micro tiles listed in micro_tiles.yaml.

Each micro tile is taken from the `tt_submission` artifact of the GitHub Actions run
that hardened it (downloaded with the `gh` CLI). The script then generates everything
in this repository that depends on the set of micro tiles:

  macros/<macro>/           GDS, LEF, gate level netlist, commit_id.json, pdk.json
  macros/<macro>/src/       sources (only used to generate the test vectors)
  docs/<macro>/             info.yaml and docs of the micro tile (for the datasheet)
  docs/info.md              list of the micro tiles
  subprojects.json          description of the micro tiles for the shuttle index
  src/project.v             the container: four instances and the select logic
  src/config.json           the MACROS and PDN_MACRO_CONNECTIONS entries
  test/vectors/<macro>.json reference outputs, from an RTL simulation of the micro tile

Usage: python assemble.py [--skip-download]
"""

import argparse
import json
import os
import random
import re
import shutil
import subprocess
import sys

import klayout.db as pya
import yaml

ROOT = os.path.dirname(os.path.realpath(__file__))
CACHE = os.path.join(ROOT, ".cache")

MICRO_TILE_SIZE = (151.2, 66.64)
# Lower left corner and orientation of the four slots. The slot number is the value
# on uio_in[1:0] that selects the micro tile.
SLOTS = [
    ("proj1", (0, 0), "N"),
    ("proj2", (195.44, 0), "FN"),
    ("proj3", (0, 70.56), "N"),
    ("proj4", (195.44, 70.56), "FN"),
]
MICRO_PORTS = {"clk", "rst_n", "ui_in", "uo_out", "VPWR", "VGND"}


def fail(message):
    sys.exit(f"ERROR: {message}")


def load_micro_tile(entry, skip_download):
    """Downloads the artifact of a micro tile and returns its description."""
    run_dir = os.path.join(CACHE, str(entry["run"]))
    if not skip_download or not os.path.isdir(run_dir):
        shutil.rmtree(run_dir, ignore_errors=True)
        subprocess.run(
            ["gh", "run", "download", str(entry["run"]), "-R", entry["repo"]] + ["-n", "tt_submission", "-D", run_dir],
            check=True,
        )
    with open(os.path.join(run_dir, "info.yaml")) as f:
        info = yaml.safe_load(f)
    project = info["project"]
    if project.get("tiles") != "micro":
        fail(f"{entry}: not a micro tile (tiles: {project.get('tiles')})")
    if "wokwi_id" in project:
        macro = f"tt_um_wokwi_{project['wokwi_id']}"
        sources = [f"{macro}.v", "cells.v"]
    else:
        macro = project["top_module"]
        sources = project["source_files"]
    submission = os.path.join(run_dir, "tt_submission")
    with open(os.path.join(submission, "commit_id.json")) as f:
        commit_id = json.load(f)
    with open(os.path.join(submission, "pdk.json")) as f:
        pdk = json.load(f)
    return {
        "macro": macro,
        "run_dir": run_dir,
        "submission": submission,
        "info": info,
        "project": project,
        "sources": sources,
        "commit_id": commit_id,
        "pdk": pdk,
    }


def check_micro_tile(tile):
    """Checks that the views of a micro tile fit a slot of the container."""
    macro = tile["macro"]
    with open(os.path.join(tile["submission"], f"{macro}.lef")) as f:
        lef = f.read()
    size = re.search(r"SIZE (\S+) BY (\S+) ;", lef)
    if (float(size.group(1)), float(size.group(2))) != MICRO_TILE_SIZE:
        fail(f"{macro}: LEF size {size.group(0)} is not a micro tile")
    pins = set(re.findall(r"^\s*PIN (\w+)", lef, flags=re.M))
    if pins != MICRO_PORTS:
        fail(f"{macro}: unexpected pins {sorted(pins ^ MICRO_PORTS)}")
    layout = pya.Layout()
    layout.read(os.path.join(tile["submission"], f"{macro}.gds"))
    if layout.top_cell().name != macro:
        fail(f"{macro}: GDS top cell is {layout.top_cell().name}")
    with open(os.path.join(tile["submission"], f"{macro}.v")) as f:
        modules = re.findall(r"^\s*module\s+(\S+?)\s*[(;]", f.read(), flags=re.M)
    if modules != [macro]:
        fail(f"{macro}: netlist should contain exactly one module, found {modules}")


def install_micro_tile(tile):
    macro = tile["macro"]
    macro_dir = os.path.join(ROOT, "macros", macro)
    os.makedirs(os.path.join(macro_dir, "src"))
    for ext in ("gds", "lef", "v"):
        shutil.copy(os.path.join(tile["submission"], f"{macro}.{ext}"), macro_dir)
    for name in ("commit_id.json", "pdk.json"):
        shutil.copy(os.path.join(tile["submission"], name), macro_dir)
    for source in tile["sources"]:
        shutil.copy(os.path.join(tile["run_dir"], "src", source), os.path.join(macro_dir, "src"))
    docs_dir = os.path.join(ROOT, "docs", macro)
    shutil.copytree(os.path.join(tile["run_dir"], "docs"), docs_dir)
    shutil.copy(os.path.join(tile["run_dir"], "info.yaml"), docs_dir)


def generate_project_v(container, tiles):
    lines = [
        "/*",
        " * Copyright (c) 2024 Tiny Tapeout",
        " * SPDX-License-Identifier: Apache-2.0",
        " */",
        "",
        "// Generated by assemble.py from micro_tiles.yaml. Do not edit.",
        "",
        "`default_nettype none",
        "",
        "// Micro tile container: holds four micro tiles and selects one of them with uio_in[1:0].",
        "// The clock, reset and inputs of the micro tiles that are not selected are held low.",
        f"module {container} (",
        "    input  wire [7:0] ui_in,    // Dedicated inputs",
        "    output wire [7:0] uo_out,   // Dedicated outputs",
        "    input  wire [7:0] uio_in,   // IOs: Input path",
        "    output wire [7:0] uio_out,  // IOs: Output path",
        "    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)",
        "    input  wire       ena,      // always 1 when the design is powered, so you can ignore it",
        "    input  wire       clk,      // clock",
        "    input  wire       rst_n     // reset_n - low to reset",
        ");",
        "",
        "  wire [1:0] sel = uio_in[1:0];",
        "  wire [7:0] uo_out_proj[3:0];",
        "",
        "  assign uo_out  = uo_out_proj[sel];",
        "  assign uio_out = 0;",
        "  assign uio_oe  = 0;",
        "",
    ]
    for index, (tile, (instance, _, _)) in enumerate(zip(tiles, SLOTS)):
        lines += [
            f"  {tile['macro']} {instance} (",
            f"      .rst_n (sel == {index} ? rst_n : 1'b0),",
            f"      .clk   (sel == {index} ? clk : 1'b0),",
            f"      .ui_in (sel == {index} ? ui_in : 8'h00),",
            f"      .uo_out(uo_out_proj[{index}])",
            "  );",
            "",
        ]
    lines += [
        "  // List all unused inputs to prevent warnings",
        "  wire _unused = &{ena, uio_in[7:2], 1'b0};",
        "",
        "endmodule",
        "",
    ]
    with open(os.path.join(ROOT, "src", "project.v"), "w") as f:
        f.write("\n".join(lines))


def generate_config(tiles):
    """Rewrites the MACROS and PDN_MACRO_CONNECTIONS entries of src/config.json."""
    macros = {}
    for tile, (instance, location, orientation) in zip(tiles, SLOTS):
        macro = tile["macro"]
        macros[macro] = {
            "instances": {instance: {"location": list(location), "orientation": orientation}},
            "gds": [f"dir::../macros/{macro}/{macro}.gds"],
            "lef": [f"dir::../macros/{macro}/{macro}.lef"],
            "pnl": [f"dir::../macros/{macro}/{macro}.v"],
        }
    connections = [f"{instance} VPWR VGND VPWR VGND" for instance, _, _ in SLOTS]

    def entry(key, value):
        text = json.dumps({key: value}, indent=2)
        return text[2:-2] + ","  # strip the outer braces

    path = os.path.join(ROOT, "src", "config.json")
    with open(path) as f:
        config = f.read()
    config, count = re.subn(r'^  "MACROS": \{\n.*?^  \},$', entry("MACROS", macros), config, flags=re.M | re.S)
    assert count == 1
    config, count = re.subn(
        r'^  "PDN_MACRO_CONNECTIONS": \[\n.*?^  \],$',
        entry("PDN_MACRO_CONNECTIONS", connections),
        config,
        flags=re.M | re.S,
    )
    assert count == 1
    with open(path, "w") as f:
        f.write(config)


def generate_subprojects(settings, tiles):
    projects = {}
    for index, tile in enumerate(tiles):
        project = tile["project"]
        pinout = {k: v for k, v in tile["info"]["pinout"].items() if not k.startswith("uio")}
        projects[str(index)] = {
            "macro": tile["macro"],
            "title": project["title"],
            "author": project["author"],
            "discord": project.get("discord", ""),
            "description": project["description"],
            "clock_hz": project.get("clock_hz", 0),
            "repo": tile["commit_id"]["repo"],
            "commit": tile["commit_id"]["commit"],
            "workflow_url": tile["commit_id"]["workflow_url"],
            "pinout": pinout,
        }
    with open(os.path.join(ROOT, "subprojects.json"), "w") as f:
        json.dump({"shuttle": settings["shuttle"], "index_bits": 2, "projects": projects}, f, indent=2)
        f.write("\n")


def generate_docs(tiles):
    lines = [
        "## How it works",
        "",
        "This project is a container for four micro tiles: small, separately hardened designs with a clock, a reset,",
        "eight inputs and eight outputs. `uio[1:0]` selects one of them. The selected micro tile gets the clock, the",
        "reset and the inputs of the project and drives its outputs. The other micro tiles are held in reset, with",
        "their clock and inputs low.",
        "",
        "| `uio[1:0]` | Micro tile | Author |",
        "| --- | --- | --- |",
    ]
    for index, tile in enumerate(tiles):
        project = tile["project"]
        lines.append(f"| {index} | [{project['title']}]({tile['macro']}/info.md) | {project['author']} |")
    lines += [
        "",
        "## How to test",
        "",
        "Set `uio[1:0]` to the number of the micro tile, then follow the instructions of that micro tile.",
        "",
        "## External hardware",
        "",
        "See the micro tiles.",
        "",
    ]
    with open(os.path.join(ROOT, "docs", "info.md"), "w") as f:
        f.write("\n".join(lines))


def generate_test_sources(tiles):
    """Lists the RTL sources of the micro tiles for the RTL simulation of the container."""
    sources = {}
    for tile in tiles:
        for source in tile["sources"]:
            # Files with the same name are assumed to be the same (cells.v of Wokwi projects)
            sources.setdefault(os.path.basename(source), f"$(MACROS_DIR)/{tile['macro']}/src/{source}")
    with open(os.path.join(ROOT, "test", "micro_tiles.mk"), "w") as f:
        f.write("# Generated by assemble.py. Do not edit.\n")
        f.write("MICRO_RTL_SOURCES = " + " \\\n  ".join(sources.values()) + "\n")


def generate_vectors(tile, steps=160):
    """Simulates the RTL of a micro tile and records its outputs for a fixed stimulus."""
    macro = tile["macro"]
    rng = random.Random(macro)
    # Reset (with a falling edge on rst_n, which the RTL of asynchronous resets needs),
    # then all inputs high and low (designs often reset from an input pin),
    # then random inputs, each held for one to four clock cycles
    stimulus = [(1, 0x00)] + [(0, 0x00)] * 2 + [(0, 0xFF)] * 2 + [(1, 0xFF)] * 2 + [(1, 0x00)] * 2
    while len(stimulus) < steps:
        stimulus += [(1, rng.randrange(256))] * rng.randint(1, 4)
    src_dir = os.path.join(ROOT, "macros", macro, "src")
    work = os.path.join(CACHE, f"vectors_{macro}")
    shutil.rmtree(work, ignore_errors=True)
    os.makedirs(work)
    with open(os.path.join(work, "stimulus.hex"), "w") as f:
        f.writelines(f"{(rst_n << 8) | ui_in:03x}\n" for rst_n, ui_in in stimulus)
    with open(os.path.join(work, "tb.v"), "w") as f:
        f.write(
            f"""`timescale 1ns / 1ps
module tb;
  reg clk = 0;
  reg rst_n = 1;
  reg [7:0] ui_in = 0;
  wire [7:0] uo_out;
  reg [8:0] stimulus[0:{len(stimulus) - 1}];
  integer i;
  {macro} dut (.clk(clk), .rst_n(rst_n), .ui_in(ui_in), .uo_out(uo_out));
  always #50 clk = ~clk;
  initial begin
    $readmemh("stimulus.hex", stimulus);
    // Inputs change on the falling edge of the clock. The outputs are sampled on
    // the next falling edge, just before the inputs change again.
    @(negedge clk);
    for (i = 0; i < {len(stimulus)}; i = i + 1) begin
      {{rst_n, ui_in}} = stimulus[i];
      @(negedge clk);
      $display("%b", uo_out);
    end
    $finish;
  end
endmodule
"""
        )
    sources = [os.path.join(src_dir, s) for s in tile["sources"]]
    subprocess.run(["iverilog", "-g2012", "-o", "tb.vvp", "tb.v"] + sources, cwd=work, check=True)
    result = subprocess.run(["vvp", "-n", "tb.vvp"], cwd=work, check=True, capture_output=True, text=True)
    outputs = [line.strip() for line in result.stdout.splitlines() if re.fullmatch(r"[01xz]{8}", line.strip())]
    assert len(outputs) == len(stimulus), (len(outputs), result.stdout[-500:])
    vectors = [
        {"rst_n": rst_n, "ui_in": ui_in, "uo_out": out.replace("z", "x")}
        for (rst_n, ui_in), out in zip(stimulus, outputs)
    ]
    known = sum(8 - v["uo_out"].count("x") for v in vectors)
    print(f"{macro}: {len(vectors)} vectors, {known} of {8 * len(vectors)} output bits defined")
    os.makedirs(os.path.join(ROOT, "test", "vectors"), exist_ok=True)
    with open(os.path.join(ROOT, "test", "vectors", f"{macro}.json"), "w") as f:
        json.dump({"macro": macro, "vectors": vectors}, f)
        f.write("\n")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--skip-download", action="store_true")
    args = parser.parse_args()

    with open(os.path.join(ROOT, "micro_tiles.yaml")) as f:
        settings = yaml.safe_load(f)
    if len(settings["micro_tiles"]) != len(SLOTS):
        fail(f"expected {len(SLOTS)} micro tiles")
    tiles = [load_micro_tile(entry, args.skip_download) for entry in settings["micro_tiles"]]

    macros = [tile["macro"] for tile in tiles]
    if len(set(macros)) != len(macros):
        fail(f"micro tile names must be unique: {macros}")
    pdks = {json.dumps(tile["pdk"], sort_keys=True) for tile in tiles}
    if len(pdks) != 1:
        fail(f"the micro tiles were built with different PDK or flow versions: {pdks}")
    if tiles[0]["pdk"] != settings["pdk"]:
        fail(f"PDK / flow version {tiles[0]['pdk']} does not match micro_tiles.yaml")

    for tile in tiles:
        check_micro_tile(tile)

    for generated in ["macros", "test/vectors"]:
        shutil.rmtree(os.path.join(ROOT, generated), ignore_errors=True)
    for name in os.listdir(os.path.join(ROOT, "docs")):
        if os.path.isdir(os.path.join(ROOT, "docs", name)):
            shutil.rmtree(os.path.join(ROOT, "docs", name))
    for tile in tiles:
        install_micro_tile(tile)
        generate_vectors(tile)
    generate_project_v(settings["container"], tiles)
    generate_config(tiles)
    generate_subprojects(settings, tiles)
    generate_docs(tiles)
    generate_test_sources(tiles)
    print("assembled:", ", ".join(macros))


if __name__ == "__main__":
    main()
