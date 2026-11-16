![](../../workflows/gds/badge.svg) ![](../../workflows/test/badge.svg)

# Micro tile group for GF180MCU (experimental)

A Tiny Tapeout 1x1 project for the `gf180mcuD` PDK that holds four micro tiles: small, separately hardened macros
(151.2 x 66.64 um) with only `clk`, `rst_n`, `ui_in[7:0]` and `uo_out[7:0]` ports. `uio_in[1:0]` selects the
micro tile that is connected to the pins of the project. The clock, reset and inputs of the other micro tiles are
held low.

## Assembly

[micro_tiles.yaml](micro_tiles.yaml) lists the four micro tiles, each as the GitHub Actions run that hardened it.
`python assemble.py` downloads the `tt_submission` artifact of each run, checks it (size, pins, names, PDK and flow
version) and generates everything that depends on the set of micro tiles:

| Generated | Content |
| --- | --- |
| `macros/<macro>/` | GDS, LEF, gate level netlist, `commit_id.json`, `pdk.json`, sources |
| `docs/<macro>/` | `info.yaml` and docs of the micro tile |
| `docs/info.md` | list of the micro tiles |
| `subprojects.json` | description of the micro tiles for the shuttle index (select value -> micro tile) |
| `src/project.v` | the container: four instances and the select logic |
| `src/config.json` | the `MACROS` and `PDN_MACRO_CONNECTIONS` entries |
| `test/vectors/<macro>.json` | reference outputs from an RTL simulation of each micro tile |
| `test/micro_tiles.mk` | RTL sources of the micro tiles for the RTL simulation of the container |

The tests replay the reference vectors through the container, for all four micro tiles.

## Floorplan

| `uio_in[1:0]` | Instance | Location (um)   | Orientation |
| ------------- | -------- | --------------- | ----------- |
| 0             | `proj1`  | (0, 0)          | N           |
| 1             | `proj2`  | (195.44, 0)     | FN          |
| 2             | `proj3`  | (0, 70.56)      | N           |
| 3             | `proj4`  | (195.44, 70.56) | FN          |

The right column is mirrored, so the signal pins of all the micro tiles face the 44.24 um wide channel in the middle
of the tile. The channel and the 23.52 um strip above the micro tiles hold the standard cells of the container.

## Power

The micro tiles use Metal1 to Metal3. Their power pins are horizontal Metal3 stripes. The container has the standard
Tiny Tapeout power grid (vertical Metal4 stripes): the stripes run over the micro tiles, and the macro grid of the
default LibreLane PDN script adds a Via3 array wherever a Metal4 stripe crosses a Metal3 stripe of the same net.
The settings that make this work are in [src/config.json](src/config.json): `PDN_HORIZONTAL_LAYER` (set to Metal3),
`PDN_MACRO_CONNECTIONS`, the halos and `ROUTING_OBSTRUCTIONS`.

LVS extracts the final GDS, including the contents of the micro tiles (`MAGIC_EXT_USE_GDS`), so a micro tile that
is not connected to the power grid of the container fails LVS. [test/trace_power.py](test/trace_power.py) is an
independent check on the final GDS: it follows the metal and via layers from the Metal4 power pins of the container
to the standard cell rails of every micro tile.

## Tools

The micro tiles are built with the `microtile` branch of
[tt-support-tools](https://github.com/ttcodebot/tt-support-tools/tree/microtile). The container is an ordinary 1x1
project; it is built with the `microtile-shuttle-gf` branch, which appends the netlists of the micro tiles to the
gate level netlist of the submission.
