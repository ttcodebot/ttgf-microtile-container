## How it works

This project is a container for four micro tiles: small macros with a clock, a reset, eight inputs and eight
outputs. `uio[1:0]` selects one of the four micro tiles. The selected micro tile gets the clock, the reset and the
inputs of the project, and drives its outputs. The other micro tiles are held in reset, with their clock and inputs
low.

All four micro tiles hold the same test design: while in reset, it copies the inputs to the outputs. Out of reset,
it outputs an 8-bit counter.

## How to test

Select a micro tile with `uio[1:0]`. Hold `rst_n` low and check that the outputs follow the inputs. Then release
`rst_n`, apply a clock, and watch the counter on the outputs.

## External hardware

None
