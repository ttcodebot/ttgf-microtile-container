# SPDX-License-Identifier: Apache-2.0
# Author: Uri Shaked

# This script prepares three more copies of the tt_um_micro_test micro tile,
# so we can easily test the container with four macros.
#
# Usage: cd macros && python rename.py

import klayout.db as pya

SOURCE = "tt_um_micro_test"


def copy_text(path_template: str, name: str):
    with open(path_template.format(SOURCE), "r") as f:
        data = f.read()
    with open(path_template.format(name), "w") as f:
        f.write(data.replace(SOURCE, name))


for i in range(2, 5):
    name = f"tt_um_micro_proj{i}"

    layout = pya.Layout()
    layout.read(f"{SOURCE}.gds")
    top_cell = layout.top_cell()
    assert top_cell.name == SOURCE
    top_cell.name = name
    layout.write(f"{name}.gds")

    copy_text("{}.lef", name)  # abstract view
    copy_text("{}.v", name)  # gate level netlist with power pins
    copy_text("rtl/{}.v", name)  # RTL, for simulation only
