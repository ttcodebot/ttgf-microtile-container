# SPDX-License-Identifier: Apache-2.0
#
# Independent check of the power connections of the micro tiles, on the final GDS.
#
# Flattens the layout, then floods the metal / via stack starting from the Metal4
# power pins of the container (the shapes under the VPWR / VGND labels of the top
# cell). For every micro tile instance, it then checks that the flood reaches all
# the Metal1 shapes of that net inside the micro tile (its standard cell rails),
# and that the two nets are not shorted.
#
# Usage: python trace_power.py <container.gds> [--cut <instance cell name>]
#
# --cut removes the Via3 shapes of the container over the given micro tile before
# tracing (a negative control: the check must then fail).

import sys

import klayout.db as pya

# gf180mcuD GDS layers
METALS = {"Metal1": (34, 0), "Metal2": (36, 0), "Metal3": (42, 0), "Metal4": (46, 0)}
LABELS = {"Metal2": (36, 10), "Metal3": (42, 10), "Metal4": (46, 10)}
# via layer -> (lower metal, upper metal)
VIAS = {
    (35, 0): ("Metal1", "Metal2"),
    (38, 0): ("Metal2", "Metal3"),
    (40, 0): ("Metal3", "Metal4"),
}
NETS = ["VPWR", "VGND"]
MACRO_PREFIX = "tt_um_micro_"


def flat_region(layout, cell, layer):
    index = layout.find_layer(*layer)
    if index is None:
        return pya.Region()
    region = pya.Region(cell.begin_shapes_rec(index))
    region.merge()
    return region


def label_seeds(layout, cell, net):
    """Boxes around the texts named `net` placed directly in `cell`, per metal layer."""
    seeds = {}
    for metal, layer in LABELS.items():
        index = layout.find_layer(*layer)
        if index is None:
            continue
        region = pya.Region()
        for shape in cell.shapes(index).each():
            if shape.is_text() and shape.text.string == net:
                p = shape.text.trans.disp
                region.insert(pya.Box(p.x - 5, p.y - 5, p.x + 5, p.y + 5))
        if not region.is_empty():
            seeds[metal] = region
    return seeds


def flood(metals, vias, seeds):
    """Returns the shapes of each metal layer that are connected to the seeds."""
    net = {name: pya.Region() for name in metals}
    for metal, region in seeds.items():
        net[metal] = metals[metal].interacting(region)
    changed = True
    while changed:
        changed = False
        for lower, upper, via_cuts in vias.values():
            for a, b in ((lower, upper), (upper, lower)):
                cuts = via_cuts.interacting(net[a])
                grown = metals[b].interacting(cuts)
                new = grown - net[b]
                if not new.is_empty():
                    net[b] = (net[b] + grown).merged()
                    changed = True
    return net


def trace(layout, cell, seeds_by_net, drop_via3_in=None):
    metals = {name: flat_region(layout, cell, layer) for name, layer in METALS.items()}
    vias = {}
    for layer, (lower, upper) in VIAS.items():
        region = flat_region(layout, cell, layer)
        if layer == (40, 0) and drop_via3_in is not None:
            region = region - pya.Region(drop_via3_in)
        vias[layer] = (lower, upper, region)
    return {net: flood(metals, vias, seeds) for net, seeds in seeds_by_net.items()}


def main():
    gds = sys.argv[1]
    cut = sys.argv[sys.argv.index("--cut") + 1] if "--cut" in sys.argv else None

    layout = pya.Layout()
    layout.read(gds)
    top = layout.top_cell()
    dbu = layout.dbu

    macros = [
        inst for inst in top.each_inst() if inst.cell.name.startswith(MACRO_PREFIX)
    ]
    assert len(macros) == 4, f"expected 4 micro tiles, found {len(macros)}"

    cut_box = None
    if cut:
        (cut_box,) = [inst.bbox() for inst in macros if inst.cell.name == cut]

    top_nets = trace(
        layout, top, {net: label_seeds(layout, top, net) for net in NETS}, cut_box
    )
    for net in NETS:
        assert not top_nets[net]["Metal4"].is_empty(), f"no {net} pin on Metal4"

    errors = 0
    for metal in METALS:
        short = top_nets["VPWR"][metal] & top_nets["VGND"][metal]
        if not short.is_empty():
            print(f"ERROR: VPWR and VGND are shorted on {metal}")
            errors += 1

    for inst in sorted(macros, key=lambda i: i.cell.name):
        cell = inst.cell
        box = inst.bbox()
        # The nets of the micro tile on its own, traced from its own power pin labels
        macro_nets = trace(
            layout, cell, {net: label_seeds(layout, cell, net) for net in NETS}
        )
        for net in NETS:
            rails = macro_nets[net]["Metal1"].transformed(inst.trans)
            straps = macro_nets[net]["Metal3"].transformed(inst.trans)
            assert not rails.is_empty() and not straps.is_empty()
            missing = rails - top_nets[net]["Metal1"]
            cuts = (
                flat_region(layout, top, (40, 0))
                - (pya.Region(cut_box) if cut_box else pya.Region())
            ).interacting(straps) & top_nets[net]["Metal4"]
            status = "ok" if missing.is_empty() else "NOT CONNECTED"
            print(
                f"{cell.name} at ({box.left * dbu:.2f}, {box.bottom * dbu:.2f}) {net}: "
                f"{rails.count()} Metal1 rails, {rails.count() - missing.count()} reached "
                f"from the container pin, {cuts.count()} Via3 cuts to Metal4 - {status}"
            )
            if not missing.is_empty():
                errors += 1

    if errors:
        print(f"FAILED: {errors} error(s)")
        sys.exit(1)
    print("PASSED: all micro tiles are powered from the Metal4 pins of the container")


if __name__ == "__main__":
    main()
