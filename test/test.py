# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import glob
import json
import os

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, FallingEdge


def load_micro_tiles():
    """The micro tiles in select order, with the reference vectors made by assemble.py."""
    root = os.path.join(os.path.dirname(os.path.realpath(__file__)), "..")
    with open(os.path.join(root, "subprojects.json")) as f:
        projects = json.load(f)["projects"]
    tiles = []
    for index in sorted(projects, key=int):
        macro = projects[index]["macro"]
        with open(os.path.join(root, "test", "vectors", f"{macro}.json")) as f:
            tiles.append((int(index), macro, json.load(f)["vectors"]))
    assert len(tiles) == len(glob.glob(os.path.join(root, "test", "vectors", "*.json")))
    return tiles


@cocotb.test()
async def test_micro_tiles(dut):
    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 4)

    for sel, macro, vectors in load_micro_tiles():
        dut._log.info(f"Micro tile {sel}: {macro}, {len(vectors)} vectors")
        dut.uio_in.value = sel
        dut.rst_n.value = 0
        dut.ui_in.value = 0
        await ClockCycles(dut.clk, 2)
        await FallingEdge(dut.clk)
        checked = 0
        for step, vector in enumerate(vectors):
            # Inputs change on the falling edge; the outputs are checked on the next one
            dut.rst_n.value = vector["rst_n"]
            dut.ui_in.value = vector["ui_in"]
            await FallingEdge(dut.clk)
            actual = str(dut.uo_out.value).lower()
            for bit, (expected_bit, actual_bit) in enumerate(
                zip(vector["uo_out"], actual)
            ):
                if expected_bit in "01":
                    assert (
                        actual_bit == expected_bit
                    ), f"{macro} step {step}: uo_out[{7 - bit}] is {actual_bit}, expected {expected_bit}"
                    checked += 1
        dut._log.info(f"Micro tile {sel}: {checked} output bits checked")
        assert checked >= len(vectors), f"{macro}: too few defined reference bits"
