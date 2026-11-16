/* Automatically generated from https://wokwi.com/projects/455303592417686529 */

`default_nettype none

// verilator lint_off UNUSEDSIGNAL
// verilator lint_off PINCONNECTEMPTY

module tt_um_wokwi_455303592417686529(
  input  wire [7:0] ui_in,    // Dedicated inputs
  output wire [7:0] uo_out,    // Dedicated outputs
  input clk,
  input rst_n
);
  wire net1 = clk;
  wire net2 = rst_n;
  wire net3;
  wire net4;
  wire net5;
  wire net6;
  wire net7;
  wire net8;
  wire net9;
  wire net10 = 1'b0;
  wire net11 = 1'b1;
  wire net12 = 1'b1;
  wire net13 = 1'b0;
  wire net14 = 1'b1;
  wire net15;
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
  wire net36 = 1'b1;
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
  wire net50;
  wire net51;
  wire net52;
  wire net53;
  wire net54;
  wire net55;
  wire net56 = 1'b1;
  wire net57;
  wire net58;
  wire net59;
  wire net60;
  wire net61;
  wire net62;
  wire net63;
  wire net64;
  wire net65;
  wire net66;
  wire net67;
  wire net68;
  wire net69;
  wire net70;
  wire net71;
  wire net72;
  wire net73;
  wire net74;
  wire net75 = 1'b1;
  wire net76;
  wire net77;
  wire net78;
  wire net79;
  wire net80;
  wire net81;
  wire net82;
  wire net83;
  wire net84;
  wire net85;
  wire net86;
  wire net87;
  wire net88;
  wire net89;
  wire net90;
  wire net91;
  wire net92;
  wire net93;
  wire net94;
  wire net95;
  wire net96 = 1'b1;
  wire net97;
  wire net98;
  wire net99;
  wire net100;
  wire net101;
  wire net102;
  wire net103;
  wire net104;
  wire net105;
  wire net106;
  wire net107;
  wire net108;
  wire net109;
  wire net110;
  wire net111;
  wire net112;
  wire net113;
  wire net114 = 1'b1;
  wire net115;
  wire net116;
  wire net117;
  wire net118;
  wire net119;
  wire net120;
  wire net121;
  wire net122;
  wire net123;
  wire net124;
  wire net125;
  wire net126;
  wire net127;
  wire net128;
  wire net129;
  wire net130;
  wire net131;
  wire net132;
  wire net133 = 1'b1;
  wire net134;
  wire net135;
  wire net136;
  wire net137;
  wire net138;
  wire net139;
  wire net140;
  wire net141;
  wire net142;
  wire net143;
  wire net144;
  wire net145;
  wire net146;
  wire net147;
  wire net148;
  wire net149;
  wire net150;
  wire net151 = 1'b1;
  wire net152;
  wire net153;
  wire net154;
  wire net155;
  wire net156;
  wire net157;
  wire net158;
  wire net159;
  wire net160;
  wire net161;
  wire net162;
  wire net163;
  wire net164;
  wire net165;
  wire net166;
  wire net167;
  wire net168;
  wire net169;
  wire net170;
  wire net171;
  wire net172 = 1'b1;
  wire net173;
  wire net174;
  wire net175;
  wire net176;
  wire net177;
  wire net178;
  wire net179;
  wire net180;
  wire net181;
  wire net182;
  wire net183;
  wire net184;
  wire net185;
  wire net186;
  wire net187;
  wire net188;
  wire net189 = 1'b1;
  wire net190;
  wire net191;
  wire net192;
  wire net193;
  wire net194;
  wire net195;
  wire net196;
  wire net197;
  wire net198;
  wire net199 = 1'b0;
  wire net200;
  wire net201;
  wire net202;
  wire net203;
  wire net204;
  wire net205;
  wire net206;
  wire net207;
  wire net208;
  wire net209;
  wire net210;
  wire net211;
  wire net212;
  wire net213;
  wire net214;
  wire net215;
  wire net216;
  wire net217;
  wire net218;
  wire net219;
  wire net220;
  wire net221;
  wire net222;
  wire net223;
  wire net224;
  wire net225;
  wire net226;
  wire net227;
  wire net228;
  wire net229;
  wire net230;
  wire net231;
  wire net232;
  wire net233;
  wire net234;
  wire net235;
  wire net236;
  wire net237;
  wire net238;
  wire net239;
  wire net240;
  wire net241;
  wire net242;
  wire net243;
  wire net244;
  wire net245;
  wire net246;
  wire net247;
  wire net248;
  wire net249;
  wire net250;
  wire net251;
  wire net252;
  wire net253;
  wire net254;
  wire net255;
  wire net256;
  wire net257;
  wire net258;
  wire net259;
  wire net260;
  wire net261;
  wire net262;
  wire net263;
  wire net264 = 1'b0;
  wire net265;
  wire net266;

  assign uo_out[0] = net3;
  assign uo_out[1] = net4;
  assign uo_out[2] = net5;
  assign uo_out[3] = net6;
  assign uo_out[4] = net7;
  assign uo_out[5] = net8;
  assign uo_out[6] = net9;
  assign uo_out[7] = 0;

  and_cell and81 (
    .a (net15),
    .b (net16),
    .out (net17)
  );
  and_cell and82 (
    .a (net15),
    .b (net16),
    .out (net18)
  );
  and_cell and83 (
    .a (net15),
    .b (net16),
    .out (net19)
  );
  and_cell and84 (
    .a (net15),
    .b (net16),
    .out (net20)
  );
  and_cell and85 (
    .a (net15),
    .b (net16),
    .out (net21)
  );
  and_cell and86 (
    .a (net15),
    .b (net16),
    .out (net22)
  );
  and_cell and87 (
    .a (net15),
    .b (net23),
    .out (net24)
  );
  not_cell not9 (
    .in (net16),
    .out (net23)
  );
  and_cell and88 (
    .a (net25),
    .b (net16),
    .out (net15)
  );
  or_cell or1 (
    .a (net17),
    .b (net26),
    .out (net3)
  );
  or_cell or2 (
    .a (net18),
    .b (net27),
    .out (net4)
  );
  or_cell or3 (
    .a (net19),
    .b (net28),
    .out (net5)
  );
  or_cell or4 (
    .a (net20),
    .b (net29),
    .out (net6)
  );
  or_cell or5 (
    .a (net21),
    .b (net30),
    .out (net7)
  );
  or_cell or6 (
    .a (net22),
    .b (net31),
    .out (net8)
  );
  or_cell or7 (
    .a (net24),
    .b (net32),
    .out (net9)
  );
  and_cell and1 (
    .a (net33),
    .b (net34),
    .out (net35)
  );
  and_cell and2 (
    .a (net33),
    .b (net36),
    .out (net37)
  );
  and_cell and3 (
    .a (net33),
    .b (net36),
    .out (net38)
  );
  and_cell and4 (
    .a (net33),
    .b (net39),
    .out (net40)
  );
  and_cell and5 (
    .a (net33),
    .b (net41),
    .out (net42)
  );
  and_cell and6 (
    .a (net33),
    .b (net43),
    .out (net44)
  );
  and_cell and7 (
    .a (net33),
    .b (net45),
    .out (net46)
  );
  not_cell not1 (
    .in (net36),
    .out (net45)
  );
  and_cell and8 (
    .a (net47),
    .b (net36),
    .out (net33)
  );
  or_cell or8 (
    .a (net48),
    .b (net35),
    .out (net26)
  );
  or_cell or9 (
    .a (net49),
    .b (net37),
    .out (net27)
  );
  or_cell or10 (
    .a (net50),
    .b (net38),
    .out (net28)
  );
  or_cell or11 (
    .a (net51),
    .b (net40),
    .out (net29)
  );
  or_cell or12 (
    .a (net52),
    .b (net42),
    .out (net30)
  );
  or_cell or13 (
    .a (net53),
    .b (net44),
    .out (net31)
  );
  or_cell or14 (
    .a (net54),
    .b (net46),
    .out (net32)
  );
  not_cell not2 (
    .in (net36),
    .out (net34)
  );
  not_cell not3 (
    .in (net36),
    .out (net39)
  );
  not_cell not4 (
    .in (net36),
    .out (net41)
  );
  not_cell not5 (
    .in (net36),
    .out (net43)
  );
  and_cell and9 (
    .a (net55),
    .b (net56),
    .out (net57)
  );
  and_cell and10 (
    .a (net55),
    .b (net56),
    .out (net58)
  );
  and_cell and11 (
    .a (net55),
    .b (net59),
    .out (net60)
  );
  and_cell and12 (
    .a (net55),
    .b (net56),
    .out (net61)
  );
  and_cell and13 (
    .a (net55),
    .b (net56),
    .out (net62)
  );
  and_cell and14 (
    .a (net55),
    .b (net63),
    .out (net64)
  );
  and_cell and15 (
    .a (net55),
    .b (net56),
    .out (net65)
  );
  and_cell and16 (
    .a (net66),
    .b (net56),
    .out (net55)
  );
  or_cell or15 (
    .a (net57),
    .b (net67),
    .out (net48)
  );
  or_cell or16 (
    .a (net58),
    .b (net68),
    .out (net49)
  );
  or_cell or17 (
    .a (net60),
    .b (net69),
    .out (net50)
  );
  or_cell or18 (
    .a (net61),
    .b (net70),
    .out (net51)
  );
  or_cell or19 (
    .a (net62),
    .b (net71),
    .out (net52)
  );
  or_cell or20 (
    .a (net64),
    .b (net72),
    .out (net53)
  );
  or_cell or21 (
    .a (net65),
    .b (net73),
    .out (net54)
  );
  not_cell not11 (
    .in (net56),
    .out (net63)
  );
  and_cell and17 (
    .a (net74),
    .b (net75),
    .out (net76)
  );
  and_cell and18 (
    .a (net74),
    .b (net75),
    .out (net77)
  );
  and_cell and19 (
    .a (net74),
    .b (net75),
    .out (net78)
  );
  and_cell and20 (
    .a (net74),
    .b (net75),
    .out (net79)
  );
  and_cell and21 (
    .a (net74),
    .b (net80),
    .out (net81)
  );
  and_cell and22 (
    .a (net74),
    .b (net82),
    .out (net83)
  );
  and_cell and23 (
    .a (net74),
    .b (net75),
    .out (net84)
  );
  and_cell and24 (
    .a (net85),
    .b (net75),
    .out (net74)
  );
  or_cell or22 (
    .a (net86),
    .b (net76),
    .out (net67)
  );
  or_cell or23 (
    .a (net87),
    .b (net77),
    .out (net68)
  );
  or_cell or24 (
    .a (net88),
    .b (net78),
    .out (net69)
  );
  or_cell or25 (
    .a (net89),
    .b (net79),
    .out (net70)
  );
  or_cell or26 (
    .a (net90),
    .b (net81),
    .out (net71)
  );
  or_cell or27 (
    .a (net91),
    .b (net83),
    .out (net72)
  );
  or_cell or28 (
    .a (net92),
    .b (net84),
    .out (net73)
  );
  and_cell and25 (
    .a (net93),
    .b (net94),
    .out (net95)
  );
  and_cell and26 (
    .a (net93),
    .b (net96),
    .out (net97)
  );
  and_cell and27 (
    .a (net93),
    .b (net96),
    .out (net98)
  );
  and_cell and28 (
    .a (net93),
    .b (net99),
    .out (net100)
  );
  and_cell and29 (
    .a (net93),
    .b (net101),
    .out (net102)
  );
  and_cell and30 (
    .a (net93),
    .b (net96),
    .out (net103)
  );
  and_cell and31 (
    .a (net93),
    .b (net96),
    .out (net104)
  );
  and_cell and32 (
    .a (net105),
    .b (net96),
    .out (net93)
  );
  or_cell or29 (
    .a (net95),
    .b (net106),
    .out (net86)
  );
  or_cell or30 (
    .a (net97),
    .b (net107),
    .out (net87)
  );
  or_cell or31 (
    .a (net98),
    .b (net108),
    .out (net88)
  );
  or_cell or32 (
    .a (net100),
    .b (net109),
    .out (net89)
  );
  or_cell or33 (
    .a (net102),
    .b (net110),
    .out (net90)
  );
  or_cell or34 (
    .a (net103),
    .b (net111),
    .out (net91)
  );
  or_cell or35 (
    .a (net104),
    .b (net112),
    .out (net92)
  );
  not_cell not18 (
    .in (net96),
    .out (net94)
  );
  not_cell not19 (
    .in (net96),
    .out (net99)
  );
  not_cell not20 (
    .in (net96),
    .out (net101)
  );
  and_cell and33 (
    .a (net113),
    .b (net114),
    .out (net115)
  );
  and_cell and34 (
    .a (net113),
    .b (net116),
    .out (net117)
  );
  and_cell and35 (
    .a (net113),
    .b (net114),
    .out (net118)
  );
  and_cell and36 (
    .a (net113),
    .b (net114),
    .out (net119)
  );
  and_cell and37 (
    .a (net113),
    .b (net120),
    .out (net121)
  );
  and_cell and38 (
    .a (net113),
    .b (net114),
    .out (net122)
  );
  and_cell and39 (
    .a (net113),
    .b (net114),
    .out (net123)
  );
  and_cell and40 (
    .a (net124),
    .b (net114),
    .out (net113)
  );
  or_cell or36 (
    .a (net125),
    .b (net115),
    .out (net106)
  );
  or_cell or37 (
    .a (net126),
    .b (net117),
    .out (net107)
  );
  or_cell or38 (
    .a (net127),
    .b (net118),
    .out (net108)
  );
  or_cell or39 (
    .a (net128),
    .b (net119),
    .out (net109)
  );
  or_cell or40 (
    .a (net129),
    .b (net121),
    .out (net110)
  );
  or_cell or41 (
    .a (net130),
    .b (net122),
    .out (net111)
  );
  or_cell or42 (
    .a (net131),
    .b (net123),
    .out (net112)
  );
  not_cell not23 (
    .in (net114),
    .out (net116)
  );
  not_cell not25 (
    .in (net114),
    .out (net120)
  );
  and_cell and41 (
    .a (net132),
    .b (net133),
    .out (net134)
  );
  and_cell and42 (
    .a (net132),
    .b (net135),
    .out (net136)
  );
  and_cell and43 (
    .a (net132),
    .b (net133),
    .out (net137)
  );
  and_cell and44 (
    .a (net132),
    .b (net133),
    .out (net138)
  );
  and_cell and45 (
    .a (net132),
    .b (net133),
    .out (net139)
  );
  and_cell and46 (
    .a (net132),
    .b (net133),
    .out (net140)
  );
  and_cell and47 (
    .a (net132),
    .b (net133),
    .out (net141)
  );
  and_cell and48 (
    .a (net142),
    .b (net133),
    .out (net132)
  );
  or_cell or43 (
    .a (net134),
    .b (net143),
    .out (net125)
  );
  or_cell or44 (
    .a (net136),
    .b (net144),
    .out (net126)
  );
  or_cell or45 (
    .a (net137),
    .b (net145),
    .out (net127)
  );
  or_cell or46 (
    .a (net138),
    .b (net146),
    .out (net128)
  );
  or_cell or47 (
    .a (net139),
    .b (net147),
    .out (net129)
  );
  or_cell or48 (
    .a (net140),
    .b (net148),
    .out (net130)
  );
  or_cell or49 (
    .a (net141),
    .b (net149),
    .out (net131)
  );
  and_cell and49 (
    .a (net150),
    .b (net151),
    .out (net152)
  );
  and_cell and50 (
    .a (net150),
    .b (net151),
    .out (net153)
  );
  and_cell and51 (
    .a (net150),
    .b (net151),
    .out (net154)
  );
  and_cell and52 (
    .a (net150),
    .b (net155),
    .out (net156)
  );
  and_cell and53 (
    .a (net150),
    .b (net157),
    .out (net158)
  );
  and_cell and54 (
    .a (net150),
    .b (net159),
    .out (net160)
  );
  and_cell and55 (
    .a (net150),
    .b (net161),
    .out (net162)
  );
  and_cell and56 (
    .a (net163),
    .b (net151),
    .out (net150)
  );
  or_cell or50 (
    .a (net164),
    .b (net152),
    .out (net143)
  );
  or_cell or51 (
    .a (net165),
    .b (net153),
    .out (net144)
  );
  or_cell or52 (
    .a (net166),
    .b (net154),
    .out (net145)
  );
  or_cell or53 (
    .a (net167),
    .b (net156),
    .out (net146)
  );
  or_cell or54 (
    .a (net168),
    .b (net158),
    .out (net147)
  );
  or_cell or55 (
    .a (net169),
    .b (net160),
    .out (net148)
  );
  or_cell or56 (
    .a (net170),
    .b (net162),
    .out (net149)
  );
  not_cell not34 (
    .in (net151),
    .out (net155)
  );
  and_cell and57 (
    .a (net171),
    .b (net172),
    .out (net173)
  );
  and_cell and58 (
    .a (net171),
    .b (net172),
    .out (net174)
  );
  and_cell and59 (
    .a (net171),
    .b (net172),
    .out (net175)
  );
  and_cell and60 (
    .a (net171),
    .b (net172),
    .out (net176)
  );
  and_cell and61 (
    .a (net171),
    .b (net172),
    .out (net177)
  );
  and_cell and62 (
    .a (net171),
    .b (net172),
    .out (net178)
  );
  and_cell and63 (
    .a (net171),
    .b (net172),
    .out (net179)
  );
  and_cell and64 (
    .a (net180),
    .b (net172),
    .out (net171)
  );
  or_cell or57 (
    .a (net173),
    .b (net181),
    .out (net164)
  );
  or_cell or58 (
    .a (net174),
    .b (net182),
    .out (net165)
  );
  or_cell or59 (
    .a (net175),
    .b (net183),
    .out (net166)
  );
  or_cell or60 (
    .a (net176),
    .b (net184),
    .out (net167)
  );
  or_cell or61 (
    .a (net177),
    .b (net185),
    .out (net168)
  );
  or_cell or62 (
    .a (net178),
    .b (net186),
    .out (net169)
  );
  or_cell or63 (
    .a (net179),
    .b (net187),
    .out (net170)
  );
  and_cell and65 (
    .a (net188),
    .b (net189),
    .out (net190)
  );
  and_cell and66 (
    .a (net188),
    .b (net189),
    .out (net191)
  );
  and_cell and67 (
    .a (net188),
    .b (net189),
    .out (net192)
  );
  and_cell and68 (
    .a (net188),
    .b (net189),
    .out (net193)
  );
  and_cell and69 (
    .a (net188),
    .b (net194),
    .out (net195)
  );
  and_cell and70 (
    .a (net188),
    .b (net189),
    .out (net196)
  );
  and_cell and71 (
    .a (net188),
    .b (net189),
    .out (net197)
  );
  and_cell and72 (
    .a (net198),
    .b (net189),
    .out (net188)
  );
  or_cell or64 (
    .a (net199),
    .b (net190),
    .out (net181)
  );
  or_cell or65 (
    .a (net199),
    .b (net191),
    .out (net182)
  );
  or_cell or66 (
    .a (net199),
    .b (net192),
    .out (net183)
  );
  or_cell or67 (
    .a (net199),
    .b (net193),
    .out (net184)
  );
  or_cell or68 (
    .a (net199),
    .b (net195),
    .out (net185)
  );
  or_cell or69 (
    .a (net199),
    .b (net196),
    .out (net186)
  );
  or_cell or70 (
    .a (net199),
    .b (net197),
    .out (net187)
  );
  not_cell not45 (
    .in (net189),
    .out (net194)
  );
  not_cell not7 (
    .in (net56),
    .out (net59)
  );
  not_cell not6 (
    .in (net75),
    .out (net80)
  );
  not_cell not8 (
    .in (net75),
    .out (net82)
  );
  not_cell not10 (
    .in (net133),
    .out (net135)
  );
  not_cell not12 (
    .in (net151),
    .out (net157)
  );
  not_cell not13 (
    .in (net151),
    .out (net159)
  );
  not_cell not14 (
    .in (net151),
    .out (net161)
  );
  and_cell and73 (
    .a (net200),
    .b (net201),
    .out (net202)
  );
  and_cell and74 (
    .a (net203),
    .b (net204),
    .out (net205)
  );
  and_cell and75 (
    .a (net202),
    .b (net205),
    .out (net25)
  );
  and_cell and76 (
    .a (net206),
    .b (net207),
    .out (net208)
  );
  and_cell and77 (
    .a (net209),
    .b (net210),
    .out (net211)
  );
  and_cell and78 (
    .a (net208),
    .b (net211),
    .out (net47)
  );
  and_cell and79 (
    .a (net212),
    .b (net213),
    .out (net214)
  );
  and_cell and80 (
    .a (net215),
    .b (net216),
    .out (net217)
  );
  and_cell and89 (
    .a (net214),
    .b (net217),
    .out (net66)
  );
  and_cell and90 (
    .a (net206),
    .b (net213),
    .out (net218)
  );
  and_cell and91 (
    .a (net219),
    .b (net220),
    .out (net221)
  );
  and_cell and92 (
    .a (net218),
    .b (net221),
    .out (net85)
  );
  and_cell and93 (
    .a (net222),
    .b (net223),
    .out (net224)
  );
  and_cell and94 (
    .a (net225),
    .b (net226),
    .out (net227)
  );
  and_cell and95 (
    .a (net224),
    .b (net227),
    .out (net105)
  );
  and_cell and96 (
    .a (net206),
    .b (net228),
    .out (net229)
  );
  and_cell and97 (
    .a (net225),
    .b (net230),
    .out (net231)
  );
  and_cell and98 (
    .a (net229),
    .b (net231),
    .out (net124)
  );
  and_cell and99 (
    .a (net232),
    .b (net213),
    .out (net233)
  );
  and_cell and100 (
    .a (net225),
    .b (net234),
    .out (net235)
  );
  and_cell and101 (
    .a (net233),
    .b (net235),
    .out (net142)
  );
  and_cell and102 (
    .a (net206),
    .b (net213),
    .out (net236)
  );
  and_cell and103 (
    .a (net225),
    .b (net237),
    .out (net238)
  );
  and_cell and104 (
    .a (net236),
    .b (net238),
    .out (net163)
  );
  and_cell and105 (
    .a (net239),
    .b (net240),
    .out (net241)
  );
  and_cell and106 (
    .a (net242),
    .b (net243),
    .out (net244)
  );
  and_cell and107 (
    .a (net241),
    .b (net244),
    .out (net180)
  );
  and_cell and108 (
    .a (net206),
    .b (net245),
    .out (net246)
  );
  and_cell and109 (
    .a (net247),
    .b (net243),
    .out (net248)
  );
  and_cell and110 (
    .a (net246),
    .b (net248),
    .out (net198)
  );
  not_cell not16 (
    .in (net206),
    .out (net200)
  );
  not_cell not17 (
    .in (net213),
    .out (net201)
  );
  not_cell not21 (
    .in (net225),
    .out (net203)
  );
  not_cell not22 (
    .in (net243),
    .out (net204)
  );
  not_cell not24 (
    .in (net213),
    .out (net207)
  );
  not_cell not26 (
    .in (net225),
    .out (net209)
  );
  not_cell not27 (
    .in (net243),
    .out (net210)
  );
  not_cell not28 (
    .in (net206),
    .out (net212)
  );
  not_cell not29 (
    .in (net243),
    .out (net216)
  );
  not_cell not30 (
    .in (net225),
    .out (net215)
  );
  not_cell not32 (
    .in (net243),
    .out (net220)
  );
  not_cell not33 (
    .in (net225),
    .out (net219)
  );
  not_cell not36 (
    .in (net206),
    .out (net222)
  );
  not_cell not37 (
    .in (net243),
    .out (net226)
  );
  not_cell not39 (
    .in (net213),
    .out (net223)
  );
  not_cell not41 (
    .in (net243),
    .out (net230)
  );
  not_cell not43 (
    .in (net213),
    .out (net228)
  );
  not_cell not44 (
    .in (net206),
    .out (net232)
  );
  not_cell not46 (
    .in (net243),
    .out (net234)
  );
  not_cell not50 (
    .in (net243),
    .out (net237)
  );
  not_cell not53 (
    .in (net206),
    .out (net239)
  );
  not_cell not55 (
    .in (net225),
    .out (net242)
  );
  not_cell not56 (
    .in (net213),
    .out (net240)
  );
  not_cell not59 (
    .in (net225),
    .out (net247)
  );
  not_cell not60 (
    .in (net213),
    .out (net245)
  );
  not_cell not15 (
    .in (net249),
    .out (net206)
  );
  not_cell not31 (
    .in (net250),
    .out (net213)
  );
  not_cell not35 (
    .in (net251),
    .out (net225)
  );
  not_cell not38 (
    .in (net252),
    .out (net243)
  );
  dffr_cell flop5 (
    .d (net253),
    .clk (net1),
    .r (net254),
    .q (net249),
    .notq (net253)
  );
  dffr_cell flop6 (
    .d (net255),
    .clk (net249),
    .r (net254),
    .q (net250),
    .notq (net255)
  );
  dffr_cell flop7 (
    .d (net256),
    .clk (net250),
    .r (net254),
    .q (net251),
    .notq (net256)
  );
  dffr_cell flop8 (
    .d (net257),
    .clk (net251),
    .r (net254),
    .q (net252),
    .notq (net257)
  );
  and_cell and111 (
    .a (net258),
    .b (net213),
    .out (net259)
  );
  and_cell and112 (
    .a (net260),
    .b (net243),
    .out (net261)
  );
  and_cell and113 (
    .a (net259),
    .b (net261),
    .out ()
  );
  not_cell not42 (
    .in (net225),
    .out (net260)
  );
  not_cell not47 (
    .in (net206),
    .out (net258)
  );
  not_cell not40 (
    .in (net2),
    .out (net262)
  );
  or_cell or71 (
    .a (net262),
    .b (net263),
    .out (net254)
  );
  nor_cell nor1 (
    .a (net250),
    .b (net252),
    .out (net265)
  );
  and_cell and114 (
    .a (net249),
    .b (net251),
    .out (net266)
  );
  and_cell and115 (
    .a (net266),
    .b (net265),
    .out (net263)
  );
endmodule
