![](../../workflows/assemble/badge.svg)

# Micro tile container assembled without place and route (experimental)

Branch `assembled`: a container for four gf180mcuD micro tiles that is not hardened around them. The `assemble`
workflow takes

- the generic container (`micro_tiles/container`, built on the `generic` branch around four `tt_micro_slot`
  placeholders) and
- four hardened micro tiles (`projects/<macro>`, in the layout of a shuttle's `projects` directory),

and runs `micro_tiles.py assemble` from the `microtile-shuttle-gf` branch of
[tt-support-tools](https://github.com/ttcodebot/tt-support-tools/tree/microtile-shuttle-gf): the layout of each
micro tile is merged into its slot, the netlist gets the real module names and the netlists of the micro tiles, and
the abstract is the one of the generic container under the new name.

The assembled container is then checked like any 1x1 project:

| Job | Check |
| --- | --- |
| `assemble` | power trace on the GDS (`test/trace_power.py`) with a negative control |
| `precheck` | the standard Tiny Tapeout precheck: KLayout DRC, antenna, pins, layers |
| `gl_test` | gate level simulation of all four micro tiles against RTL reference vectors |
| `lvs` | Magic extraction from the GDS with the micro tile contents + Netgen against the stitched netlist, with a negative control (`lvs/run.sh`) |
