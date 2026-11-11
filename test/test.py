# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, FallingEdge

# Micro tiles 1, 3 and 4 hold the counter test design. Micro tile 2 holds a dense
# generated design (28 flops, 81 % of the micro tile core).
COUNTER_TILES = [0, 2, 3]
DENSE_TILE = 1


@cocotb.test()
async def test_micro_tiles(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)

    # The counter test design mirrors the inputs while in reset and outputs a
    # counter otherwise.
    for sel in COUNTER_TILES:
        dut._log.info(f"Micro tile {sel + 1}: test input mirror in reset")
        dut.uio_in.value = sel
        dut.rst_n.value = 0
        await ClockCycles(dut.clk, 2)
        for x in range(256):
            dut.ui_in.value = x
            await ClockCycles(dut.clk, 1)
            await FallingEdge(dut.clk)
            assert dut.uo_out.value == x

        dut._log.info(f"Micro tile {sel + 1}: test counter")
        dut.rst_n.value = 1
        await ClockCycles(dut.clk, 1)
        for x in range(256):
            await FallingEdge(dut.clk)
            assert dut.uo_out.value == x
            await ClockCycles(dut.clk, 1)


@cocotb.test()
async def test_dense_micro_tile(dut):
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # The state of the generated design is all zeros after reset, and the outputs
    # are an XOR fold of the state. One clock with a value on the inputs loads
    # that value into the first eight state bits, so it shows up on the outputs.
    dut.ena.value = 1
    dut.uio_in.value = DENSE_TILE
    for value in (0xA5, 0x3C, 0xFF, 0x01):
        dut.ui_in.value = 0
        dut.rst_n.value = 0
        await ClockCycles(dut.clk, 3)
        await FallingEdge(dut.clk)
        assert dut.uo_out.value == 0
        dut.ui_in.value = value
        dut.rst_n.value = 1
        await ClockCycles(dut.clk, 1)
        await FallingEdge(dut.clk)
        assert dut.uo_out.value == value
