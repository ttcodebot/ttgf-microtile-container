# Negative control: removes the Via3 shapes of the container over one micro tile.
# Usage: cut_via3.py <in.gds> <out.gds> <micro tile cell name>
import sys

import klayout.db as pya

layout = pya.Layout()
layout.read(sys.argv[1])
top = layout.top_cell()
(inst,) = [i for i in top.each_inst() if i.cell.name == sys.argv[3]]
box = inst.bbox()
via3 = layout.layer(40, 0)
removed = 0
for shape in list(top.shapes(via3).each()):
    if shape.bbox().inside(box):
        shape.delete()
        removed += 1
# PDN vias may also sit in via cells placed in the top cell
for sub in list(top.each_inst()):
    if sub.cell.name.startswith(("via", "VIA")) and sub.bbox().inside(box):
        if not sub.cell.shapes(via3).is_empty():
            sub.delete()
            removed += 1
layout.write(sys.argv[2])
print("removed", removed, "Via3 shapes / via cells over", sys.argv[3])
