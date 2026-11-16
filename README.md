![](../../workflows/gds/badge.svg)

# Generic micro tile container for GF180MCU (experimental)

Branch `generic`: the micro tile container hardened around four placeholder macros (`tt_micro_slot`) instead of
real micro tiles. The placeholder has the pins and power stripes that every gf180mcuD micro tile has by
construction, and blocks Metal1 to Metal3 over its whole area (`macros/tt_micro_slot`, written by
`micro_tiles.py make-slot` of the `microtile-shuttle-gf` branch of
[tt-support-tools](https://github.com/ttcodebot/tt-support-tools/tree/microtile-shuttle-gf)).

`micro_tiles.py assemble` turns this container into a real one by swapping the placeholders for four micro
tiles: a layout merge and a netlist edit, no place and route. See the `assembled` branch.
