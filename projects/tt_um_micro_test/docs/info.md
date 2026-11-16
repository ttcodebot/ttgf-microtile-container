## How it works

This is a test design for micro tiles: small macros that are placed inside a 1x1 container project.

While `rst_n` is low, the inputs `ui_in` are copied to the outputs `uo_out`. When `rst_n` is high, the outputs show
an 8-bit counter that increments on every rising edge of `clk`.

## How to test

Hold `rst_n` low and check that `uo_out` follows `ui_in`. Then release `rst_n`, apply a clock, and watch the counter
on `uo_out`.

## External hardware

None
