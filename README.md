![](../../workflows/gds/badge.svg) ![](../../workflows/test/badge.svg)

# Micro tile container for GF180MCU (experimental)

A Tiny Tapeout 1x1 project for the `gf180mcuD` PDK that holds four micro tiles: small hardened macros
(151.2 x 66.64 um) with only `clk`, `rst_n`, `ui_in[7:0]` and `uo_out[7:0]` ports. `uio_in[1:0]` selects the
micro tile that is connected to the pins of the project. The clock, reset and inputs of the other micro tiles are
held low.

The macros in `macros/` were built by [ttgf-microtile](https://github.com/ttcodebot/ttgf-microtile): `proj1`,
`proj3` and `proj4` are copies of the counter test micro tile (see `macros/rename.py`), `proj2` is a dense generated
design from its capacity sweep (`tt_um_micro_sweep`: 28 flops, 178 cells, 81 % of the micro tile core).

## Floorplan

| Instance | Location (um)   | Orientation |
| -------- | --------------- | ----------- |
| `proj1`  | (0, 0)          | N           |
| `proj2`  | (195.44, 0)     | FN          |
| `proj3`  | (0, 70.56)      | N           |
| `proj4`  | (195.44, 70.56) | FN          |

The right column is mirrored, so the signal pins of all the micro tiles face the 44.24 um wide channel in the middle
of the tile. The channel and the 23.52 um strip above the micro tiles hold the standard cells of the container.

## Power

The micro tiles use Metal1 to Metal3. Their power pins are horizontal Metal3 stripes. The container has the standard
Tiny Tapeout power grid (vertical Metal4 stripes): the stripes run over the micro tiles, and the macro grid of the
default LibreLane PDN script adds a Via3 array wherever a Metal4 stripe crosses a Metal3 stripe of the same net.
The two grids do not have to be aligned. The settings that make this work are in [src/config.json](src/config.json):
`PDN_HORIZONTAL_LAYER` (set to Metal3), `PDN_MACRO_CONNECTIONS`, the halos and `ROUTING_OBSTRUCTIONS`.

LVS extracts the final GDS, including the contents of the micro tiles (`MAGIC_EXT_USE_GDS`), so a micro tile that
is not connected to the power grid of the container fails LVS. [test/trace_power.py](test/trace_power.py) is an
independent check on the final GDS: it follows the metal and via layers from the Metal4 power pins of the container
to the standard cell rails of every micro tile.

## Tools

The micro tiles need the `microtile-gf180` branch of
[tt-support-tools](https://github.com/ttcodebot/tt-support-tools/tree/microtile-gf180). The container is an
ordinary 1x1 project.
