## How it works

Four micro tile projects with 6 reserved uio pins each (pin plan), combined into a single Tiny Tapeout tile.

`uio_in[1:0]` selects the active micro tile. It gets `clk`, `rst_n` and `ui_in`, and drives `uo_out`; the micro tiles' uio pins are not connected. The others get no clock and are held in reset.

## How to test

Select a micro tile with `uio[1:0]`, then follow the instructions of that micro tile.

## External hardware

None
