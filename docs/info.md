## How it works

This project is a container for four micro tiles: small, separately hardened designs with a clock, a reset,
eight inputs and eight outputs. `uio[1:0]` selects one of them. The selected micro tile gets the clock, the
reset and the inputs of the project and drives its outputs. The other micro tiles are held in reset, with
their clock and inputs low.

| `uio[1:0]` | Micro tile | Author |
| --- | --- | --- |
| 0 | [Micro tile test (GF180MCU)](tt_um_micro_test/info.md) | Tiny Tapeout |
| 1 | [Micro tile: Wokwi 457572218833202177](tt_um_wokwi_457572218833202177/info.md) | Tiny Tapeout |
| 2 | [Micro tile: Wokwi 455303592417686529](tt_um_wokwi_455303592417686529/info.md) | Tiny Tapeout |
| 3 | [Micro tile: dense generated design](tt_um_micro_sweep/info.md) | Tiny Tapeout |

## How to test

Set `uio[1:0]` to the number of the micro tile, then follow the instructions of that micro tile.

## External hardware

See the micro tiles.
