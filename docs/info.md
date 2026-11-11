## How it works

This project is a container for four micro tiles: small macros with a clock, a reset, eight inputs and eight
outputs. `uio[1:0]` selects one of the four micro tiles. The selected micro tile gets the clock, the reset and the
inputs of the project, and drives its outputs. The other micro tiles are held in reset, with their clock and inputs
low.

Micro tiles 1, 3 and 4 hold the same test design: while in reset, it copies the inputs to the outputs. Out of
reset, it outputs an 8-bit counter. Micro tile 2 holds a generated design that fills most of a micro tile: a 28-bit
state register with feedback logic. Its outputs are an XOR fold of the state.

## How to test

Select micro tile 1, 3 or 4 with `uio[1:0]` (0, 2 or 3). Hold `rst_n` low and check that the outputs follow the
inputs. Then release `rst_n`, apply a clock, and watch the counter on the outputs.

For micro tile 2 (`uio[1:0]` = 1): reset with all inputs low, release `rst_n`, set a value on the inputs and apply
one clock. The outputs show that value.

## External hardware

None
