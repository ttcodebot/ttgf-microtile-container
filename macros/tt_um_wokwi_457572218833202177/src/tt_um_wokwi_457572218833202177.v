/* Automatically generated from https://wokwi.com/projects/457572218833202177 */

`default_nettype none

// verilator lint_off UNUSEDSIGNAL
// verilator lint_off PINCONNECTEMPTY

module tt_um_wokwi_457572218833202177(
  input  wire [7:0] ui_in,    // Dedicated inputs
  output wire [7:0] uo_out,    // Dedicated outputs
  input clk,
  input rst_n
);
  wire net1 = clk;
  wire net2 = ui_in[0];
  wire net3 = ui_in[1];
  wire net4 = ui_in[2];
  wire net5 = ui_in[3];
  wire net6 = ui_in[4];
  wire net7 = ui_in[5];
  wire net8 = ui_in[6];
  wire net9 = ui_in[7];
  wire net10;
  wire net11;
  wire net12 = 1'b0;
  wire net13 = 1'b1;
  wire net14 = 1'b1;
  wire net15 = 1'b0;
  wire net16 = 1'b1;
  wire net17;
  wire net18;
  wire net19;
  wire net20;
  wire net21;
  wire net22;
  wire net23;
  wire net24;
  wire net25;
  wire net26;
  wire net27;
  wire net28;
  wire net29;
  wire net30;
  wire net31;
  wire net32;
  wire net33;
  wire net34;
  wire net35;
  wire net36;
  wire net37;
  wire net38;
  wire net39;
  wire net40;
  wire net41;
  wire net42;
  wire net43;
  wire net44;
  wire net45;
  wire net46;
  wire net47;
  wire net48;
  wire net49;

  assign uo_out[0] = net10;
  assign uo_out[1] = net11;
  assign uo_out[2] = net11;
  assign uo_out[3] = 0;
  assign uo_out[4] = 0;
  assign uo_out[5] = 0;
  assign uo_out[6] = 0;
  assign uo_out[7] = 0;

  xor_cell xor1 (
    .a (net2),
    .b (net6),
    .out (net17)
  );
  and_cell and1 (
    .a (net2),
    .b (net6),
    .out (net18)
  );
  xor_cell xor2 (
    .a (net3),
    .b (net7),
    .out (net19)
  );
  xor_cell xor3 (
    .a (net19),
    .b (net18),
    .out (net20)
  );
  and_cell and2 (
    .a (net3),
    .b (net7),
    .out (net21)
  );
  or_cell or1 (
    .a (net21),
    .b (net22),
    .out (net23)
  );
  and_cell and3 (
    .a (net19),
    .b (net18),
    .out (net22)
  );
  xor_cell xor4 (
    .a (net4),
    .b (net8),
    .out (net24)
  );
  xor_cell xor5 (
    .a (net24),
    .b (net23),
    .out (net25)
  );
  and_cell and4 (
    .a (net4),
    .b (net8),
    .out (net26)
  );
  and_cell and5 (
    .a (net24),
    .b (net23),
    .out (net27)
  );
  or_cell or2 (
    .a (net26),
    .b (net27),
    .out (net28)
  );
  xor_cell xor6 (
    .a (net5),
    .b (net9),
    .out (net29)
  );
  xor_cell xor7 (
    .a (net29),
    .b (net28),
    .out (net30)
  );
  and_cell and6 (
    .a (net5),
    .b (net9),
    .out (net31)
  );
  and_cell and7 (
    .a (net29),
    .b (net28),
    .out (net32)
  );
  or_cell or3 (
    .a (net31),
    .b (net32),
    .out (net33)
  );
  dff_cell flop1 (
    .d (net17),
    .clk (net1),
    .q (net34),
    .notq ()
  );
  dff_cell flop2 (
    .d (net20),
    .clk (net1),
    .q (net35),
    .notq ()
  );
  dff_cell flop3 (
    .d (net25),
    .clk (net1),
    .q (net36),
    .notq ()
  );
  dff_cell flop4 (
    .d (net30),
    .clk (net1),
    .q (net37),
    .notq ()
  );
  dff_cell flop5 (
    .d (net33),
    .clk (net1),
    .q (net38),
    .notq ()
  );
  and_cell and8 (
    .a (net34),
    .b (net39),
    .out (net11)
  );
  not_cell not1 (
    .in (net35),
    .out (net40)
  );
  and_cell and9 (
    .a (net40),
    .b (net41),
    .out (net39)
  );
  not_cell not2 (
    .in (net36),
    .out (net42)
  );
  and_cell and10 (
    .a (net42),
    .b (net43),
    .out (net41)
  );
  not_cell not3 (
    .in (net37),
    .out (net44)
  );
  and_cell and11 (
    .a (net44),
    .b (net45),
    .out (net43)
  );
  not_cell not4 (
    .in (net38),
    .out (net45)
  );
  not_cell not5 (
    .in (net34),
    .out (net46)
  );
  and_cell and12 (
    .a (net35),
    .b (net47),
    .out (net10)
  );
  and_cell and13 (
    .a (net46),
    .b (net48),
    .out (net47)
  );
  and_cell and14 (
    .a (net42),
    .b (net49),
    .out (net48)
  );
  and_cell and15 (
    .a (net44),
    .b (net45),
    .out (net49)
  );
endmodule
