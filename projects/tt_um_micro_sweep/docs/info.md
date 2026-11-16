## How it works

A generated design that fills most of a micro tile: a 28-bit state register, where the next value of
each bit is the previous bit mixed with 3 gate pairs fed by other bits. `ui_in` is mixed into the first
eight bits; `uo_out` is an XOR fold of all the bits.

## How to test

Reset with all inputs low: the outputs are 0. Release `rst_n`, set a value on the inputs and apply one clock:
the outputs show that value.

## External hardware

None
