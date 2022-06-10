/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Thu Apr 28 09:38:09 2022
/////////////////////////////////////////////////////////////


module falling_edge_detect ( clk, n_rst, dplus_sync, d_edge );
  input clk, n_rst, dplus_sync;
  output d_edge;
  wire   dplus_prev, n2;

  DFFSR dplus_prev_reg ( .D(dplus_sync), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        dplus_prev) );
  NOR2X1 U5 ( .A(dplus_sync), .B(n2), .Y(d_edge) );
  INVX2 U4 ( .A(dplus_prev), .Y(n2) );
endmodule


module ahb_slave ( clk, n_rst, hsel, hwrite, htrans, hsize, haddr, hwdata, 
        rx_data, rx_data_ready, rx_transfer_active, rx_error, 
        tx_transfer_active, tx_error, rx_packet, buffer_occupancy, tx_data, 
        store_tx_data, get_rx_data, hready, hresp, tx_packet, clear, hrdata, 
        d_mode );
  input [1:0] htrans;
  input [1:0] hsize;
  input [3:0] haddr;
  input [31:0] hwdata;
  input [7:0] rx_data;
  input [3:0] rx_packet;
  input [6:0] buffer_occupancy;
  output [7:0] tx_data;
  output [3:0] tx_packet;
  output [31:0] hrdata;
  input clk, n_rst, hsel, hwrite, rx_data_ready, rx_transfer_active, rx_error,
         tx_transfer_active, tx_error;
  output store_tx_data, get_rx_data, hready, hresp, clear, d_mode;
  wire   N174, N176, hwrite_f, \mem[3][7] , \mem[3][6] , \mem[3][5] ,
         \mem[3][4] , \mem[3][3] , \mem[3][2] , \mem[3][1] , \mem[3][0] ,
         \mem[2][7] , \mem[2][6] , \mem[2][5] , \mem[2][4] , \mem[2][3] ,
         \mem[2][2] , \mem[2][1] , \mem[2][0] , \mem[1][7] , \mem[1][6] ,
         \mem[1][5] , \mem[1][4] , \mem[1][3] , \mem[1][2] , \mem[1][1] ,
         \mem[1][0] , \mem[0][7] , \mem[0][6] , \mem[0][5] , \mem[0][4] ,
         \mem[0][3] , \mem[0][2] , \mem[0][1] , \mem[0][0] , N492, N493, N494,
         N495, N496, N497, N498, N499, N502, N503, N504, N505, N506, N507,
         N508, N509, N512, N513, N514, N515, N516, N517, N518, N519, N522,
         N523, N524, N525, N526, N527, N528, N529, N787, N788, N789, N790,
         N992, N993, N994, N995, N1036, N1038, N1039, N1040,
         tx_transfer_active_falling_edge, N1450, N1453, N1457, n41, n42, n43,
         n44, n45, n46, n47, n48, n356, n357, n358, n359, n360, n361, n362,
         n363, n364, n365, n366, n367, n368, n369, n370, n371, n372, n373,
         n374, n375, n376, n377, n378, n379, n380, n381, n382, n383, n384,
         n385, n386, n387, n388, n389, n390, n391, n392, n393, n394, n395,
         n396, n397, n398, n399, n400, n401, n402, n403, n404, n405, n406,
         n407, n408, n409, n410, n411, n412, n413, n414, n415, n416, n417,
         n418, n419, n420, n421, n422, n423, n424, n425, n426, n427, n428,
         n429, n430, n431, n433, n434, n435, n436, n437, n438, n439, n440,
         n441, n442, n444, n445, n446, n447, n451, n452, n454, n455, n457,
         n458, n460, n461, n463, n464, n466, n467, n469, n470, n471, n472,
         n473, n474, n476, n477, n479, n480, n481, n482, n486, n487, n489,
         n490, n492, n493, n495, n496, n498, n499, n501, n502, n504, n505,
         n506, n507, n509, n510, n511, n512, n513, n515, n516, n517, n518,
         n519, n520, n522, n523, n524, n526, n527, n528, n530, n531, n532,
         n534, n535, n536, n538, n539, n540, n541, n542, n543, n544, n545,
         n546, n547, n548, n549, n550, n551, n552, n553, n554, n555, n557,
         n558, n559, n560, n561, n564, n565, n566, n569, n570, n571, n572,
         n573, n574, n575, n576, n577, n578, n579, n580, n581, n582, n583,
         n584, n585, n586, n587, n588, n589, n590, n591, n592, n593, n594,
         n595, n596, n597, n598, n599, n600, n601, n602, n603, n604, n605,
         n606, n607, n608, n609, n610, n611, n612, n613, n614, n615, n616,
         n617, n618, n619, n620, n621, n622, n623, n624, n625, n626, n627,
         n628, n629, n630, n631, n632, n633, n634, n635, n636, n637, n638,
         n639, n640, n641, n642, n643, n644, n645, n646, n647, n648, n649,
         n650, n651, n652, n653, n654, n655, n656, n657, n658, n659, n660,
         n661, n662, n663, n664, n665, n666, n667, n668, n669, n670, n671,
         n672, n673, n674, n675, n676, n677, n678, n679, n680, n681, n682,
         n683, n684, n685, n686, n687, n688, n689, n690, n691, n692, n693,
         n694, n695, n696, n697, n698, n699, n700, n701, n702, n703, n704,
         n705, n706, n707, n708, n709, n710, n711, n712, n713, n714, n715,
         n716, n717, n718, n719, n720, n721, n722, n723, n724, n725, n726,
         n727, n728, n729, n730, n731, n732, n733, n734, n735, n736, n737,
         n738, n739, n740, n741, n742, n743, n744, n745, n746, n747, n748,
         n749, n750, n751, n752, n753, n754, n755, n756, n757, n758, n759,
         n760, n761, n762, n763, n764, n765, n766, n767, n768, n769, n770,
         n771, n772, n773, n774, n775, n776, n777, n778, n779, n780, n781,
         n782, n783, n784, n785, n786, n787, n788, n789, n790, n791, n792,
         n793, n794, n795, n796, n797, n798, n799, n800, n801, n802, n803,
         n804, n805, n806, n807, n808, n809, n810, n811, n812, n813, n814,
         n815, n816, n817, n818, n819, n820, n821, n822, n823, n824, n825,
         n826, n827, n828, n829, n830, n831, n832, n833, n834, n835, n836,
         n837, n838, n839, n840, n841, n842, n843, n844, n845, n846, n847,
         n848, n849, n850, n851, n852, n853, n854, n855, n856, n857, n858,
         n859, n860, n861, n862, n863, n864, n865, n866, n867, n868, n869,
         n870, n871, n872, n873, n874, n875, n876, n877, n878, n879, n880,
         n881, n882, n883, n884, n885, n886, n887, n888, n889, n890, n891,
         n892, n893, n894, n895, n896, n897, n898, n899, n900, n901, n902,
         n903, n904, n905, n906, n907, n908, n909, n910, n911, n912, n913,
         n914, n915, n916, n917, n918, n919, n920, n921, n922, n923, n924,
         n925, n926, n927, n928, n929, n930, n931, n932, n933, n934, n935,
         n936, n937, n938, n939, n940, n941, n942, n943, n944, n945, n946,
         n947, n948, n949, n950, n951, n952, n953, n954, n955, n956, n957,
         n958, n959, n960, n961, n962, n963, n964, n965, n966, n967, n968,
         n969, n970, n971, n972, n973, n974, n975, n976, n977, n978, n979,
         n980, n981, n982, n983, n984, n985, n986, n987, n988, n989, n990,
         n991, n992, n993, n994, n995, n996, n997, n998, n999, n1000, n1001,
         n1002, n1003, n1004, n1005, n1006, n1007, n1008, n1009, n1010, n1011,
         n1012, n1013, n1014, n1015, n1016, n1017, n1018, n1019, n1020, n1021,
         n1022, n1023, n1024, n1025, n1026, n1027, n1028, n1029, n1030, n1031,
         n1032, n1033, n1034, n1035, n1036, n1037, n1038, n1039, n1040, n1041,
         n1042, n1043, n1044, n1045, n1046, n1047, n1048, n1049, n1050, n1051,
         n1052, n1053, n1054, n1066, n1067, n1068, n1069, \add_639_2/carry[3] ,
         \add_639/carry[2] , \add_639/carry[3] , \r426/carry[3] ,
         \r426/carry[2] , n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26,
         n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40,
         n49, n50, n51, n162, n163, n164, n165, n166, n167, n168, n169, n170,
         n171, n172, n173, n174, n175, n176, n177, n178, n179, n180, n181,
         n182, n183, n184, n185, n186, n187, n188, n189, n190, n191, n192,
         n193, n194, n195, n196, n197, n198, n199, n200, n201, n202, n203,
         n204, n205, n206, n207, n208, n209, n210, n211, n212, n213, n214,
         n215, n216, n217, n218, n219, n220, n221, n222, n223, n224, n225,
         n226, n227, n228, n229, n230, n231, n232, n233, n234, n235, n236,
         n237, n238, n239, n240, n241, n242, n243, n245, n246, n247, n248,
         n249, n250, n251, n252, n253, n254, n256, n257, n258, n259, n260,
         n261, n262, n263, n264, n265, n266, n267, n268, n269, n270, n271,
         n272, n273, n274, n275, n276, n277, n278, n279, n280, n281, n282,
         n283, n284, n285, n286, n287, n288, n289, n290, n291, n292, n293,
         n294, n295, n296, n297, n298, n299, n300, n301, n302, n303, n304,
         n305, n306, n307, n308, n309, n310, n311, n312, n313, n314, n315,
         n316, n317, n318, n319, n320, n321, n322, n323, n324, n325, n326,
         n327, n328, n329, n330, n331, n332, n333, n334, n335, n336, n337,
         n338, n339, n340, n341, n342, n343, n344, n345, n346, n347, n348,
         n349, n350, n351, n352, n353, n354, n355, n432, n443, n448, n449,
         n450, n453, n456, n459, n462, n465, n468, n475, n478, n483, n484,
         n485, n488, n491, n494, n497, n500, n503, n508, n514, n521, n525,
         n529, n533, n537, n556, n562, n563, n567, n568, n1055, n1056, n1057,
         n1058, n1059, n1060, n1061, n1062, n1063, n1064, n1065, n1070, n1071,
         n1072, n1073, n1074, n1075, n1076, n1077, n1078, n1079, n1080, n1081;
  wire   [1:0] hsize_f;
  wire   [3:0] haddr_f;
  wire   [1:0] htrans_f;
  wire   [3:0] write_select;
  wire   [31:0] stat;
  wire   [31:0] er;
  wire   [6:0] bo;
  wire   [2:0] nxt_read_rx;
  wire   [2:0] read_rx;
  wire   [2:0] read_state;
  wire   [2:0] write_data_state;
  wire   [2:0] nxt_read_state;
  wire   [2:0] nxt_write_data_state;
  wire   [2:0] write_tx;
  wire   [3:0] nxt_tx_pac;
  wire   [2:0] nxt_write_tx;

  DFFSR \htrans_f_reg[1]  ( .D(htrans[1]), .CLK(clk), .R(n213), .S(1'b1), .Q(
        htrans_f[1]) );
  DFFSR \htrans_f_reg[0]  ( .D(htrans[0]), .CLK(clk), .R(n213), .S(1'b1), .Q(
        htrans_f[0]) );
  DFFSR \hsize_f_reg[1]  ( .D(hsize[1]), .CLK(clk), .R(n213), .S(1'b1), .Q(
        hsize_f[1]) );
  DFFSR \hsize_f_reg[0]  ( .D(hsize[0]), .CLK(clk), .R(n213), .S(1'b1), .Q(
        hsize_f[0]) );
  DFFSR hwrite_f_reg ( .D(hwrite), .CLK(clk), .R(n213), .S(1'b1), .Q(hwrite_f)
         );
  DFFSR \haddr_f_reg[3]  ( .D(haddr[3]), .CLK(clk), .R(n213), .S(1'b1), .Q(
        haddr_f[3]) );
  DFFSR \haddr_f_reg[2]  ( .D(haddr[2]), .CLK(clk), .R(n213), .S(1'b1), .Q(
        haddr_f[2]) );
  DFFSR \haddr_f_reg[1]  ( .D(haddr[1]), .CLK(clk), .R(n213), .S(1'b1), .Q(
        haddr_f[1]) );
  DFFSR \haddr_f_reg[0]  ( .D(haddr[0]), .CLK(clk), .R(n213), .S(1'b1), .Q(
        haddr_f[0]) );
  DFFSR \write_select_reg[3]  ( .D(n282), .CLK(clk), .R(n213), .S(1'b1), .Q(
        write_select[3]) );
  DFFSR \write_select_reg[2]  ( .D(n1054), .CLK(clk), .R(n213), .S(1'b1), .Q(
        write_select[2]) );
  DFFSR \write_select_reg[1]  ( .D(n1053), .CLK(clk), .R(n213), .S(1'b1), .Q(
        N174) );
  DFFSR \write_select_reg[0]  ( .D(n1052), .CLK(clk), .R(n214), .S(1'b1), .Q(
        N1036) );
  DFFSR \mem_reg[3][7]  ( .D(n1020), .CLK(clk), .R(n214), .S(1'b1), .Q(
        \mem[3][7] ) );
  DFFSR \mem_reg[3][6]  ( .D(n1021), .CLK(clk), .R(n214), .S(1'b1), .Q(
        \mem[3][6] ) );
  DFFSR \mem_reg[3][5]  ( .D(n1022), .CLK(clk), .R(n214), .S(1'b1), .Q(
        \mem[3][5] ) );
  DFFSR \mem_reg[3][4]  ( .D(n1023), .CLK(clk), .R(n214), .S(1'b1), .Q(
        \mem[3][4] ) );
  DFFSR \mem_reg[3][3]  ( .D(n1024), .CLK(clk), .R(n214), .S(1'b1), .Q(
        \mem[3][3] ) );
  DFFSR \mem_reg[3][2]  ( .D(n1025), .CLK(clk), .R(n214), .S(1'b1), .Q(
        \mem[3][2] ) );
  DFFSR \mem_reg[3][1]  ( .D(n1026), .CLK(clk), .R(n214), .S(1'b1), .Q(
        \mem[3][1] ) );
  DFFSR \mem_reg[3][0]  ( .D(n1027), .CLK(clk), .R(n214), .S(1'b1), .Q(
        \mem[3][0] ) );
  DFFSR \mem_reg[2][7]  ( .D(n1028), .CLK(clk), .R(n214), .S(1'b1), .Q(
        \mem[2][7] ) );
  DFFSR \mem_reg[2][6]  ( .D(n1029), .CLK(clk), .R(n214), .S(1'b1), .Q(
        \mem[2][6] ) );
  DFFSR \mem_reg[2][5]  ( .D(n1030), .CLK(clk), .R(n214), .S(1'b1), .Q(
        \mem[2][5] ) );
  DFFSR \mem_reg[2][4]  ( .D(n1031), .CLK(clk), .R(n215), .S(1'b1), .Q(
        \mem[2][4] ) );
  DFFSR \mem_reg[2][3]  ( .D(n1032), .CLK(clk), .R(n215), .S(1'b1), .Q(
        \mem[2][3] ) );
  DFFSR \mem_reg[2][2]  ( .D(n1033), .CLK(clk), .R(n215), .S(1'b1), .Q(
        \mem[2][2] ) );
  DFFSR \mem_reg[2][1]  ( .D(n1034), .CLK(clk), .R(n215), .S(1'b1), .Q(
        \mem[2][1] ) );
  DFFSR \mem_reg[2][0]  ( .D(n1035), .CLK(clk), .R(n215), .S(1'b1), .Q(
        \mem[2][0] ) );
  DFFSR \mem_reg[1][7]  ( .D(n1036), .CLK(clk), .R(n215), .S(1'b1), .Q(
        \mem[1][7] ) );
  DFFSR \mem_reg[1][6]  ( .D(n1037), .CLK(clk), .R(n215), .S(1'b1), .Q(
        \mem[1][6] ) );
  DFFSR \mem_reg[1][5]  ( .D(n1038), .CLK(clk), .R(n215), .S(1'b1), .Q(
        \mem[1][5] ) );
  DFFSR \mem_reg[1][4]  ( .D(n1039), .CLK(clk), .R(n215), .S(1'b1), .Q(
        \mem[1][4] ) );
  DFFSR \mem_reg[1][3]  ( .D(n1040), .CLK(clk), .R(n215), .S(1'b1), .Q(
        \mem[1][3] ) );
  DFFSR \mem_reg[1][2]  ( .D(n1041), .CLK(clk), .R(n215), .S(1'b1), .Q(
        \mem[1][2] ) );
  DFFSR \mem_reg[1][1]  ( .D(n1042), .CLK(clk), .R(n215), .S(1'b1), .Q(
        \mem[1][1] ) );
  DFFSR \mem_reg[1][0]  ( .D(n1043), .CLK(clk), .R(n216), .S(1'b1), .Q(
        \mem[1][0] ) );
  DFFSR \mem_reg[0][7]  ( .D(n1044), .CLK(clk), .R(n216), .S(1'b1), .Q(
        \mem[0][7] ) );
  DFFSR \mem_reg[0][6]  ( .D(n1045), .CLK(clk), .R(n216), .S(1'b1), .Q(
        \mem[0][6] ) );
  DFFSR \mem_reg[0][5]  ( .D(n1046), .CLK(clk), .R(n216), .S(1'b1), .Q(
        \mem[0][5] ) );
  DFFSR \mem_reg[0][4]  ( .D(n1047), .CLK(clk), .R(n216), .S(1'b1), .Q(
        \mem[0][4] ) );
  DFFSR \mem_reg[0][3]  ( .D(n1048), .CLK(clk), .R(n216), .S(1'b1), .Q(
        \mem[0][3] ) );
  DFFSR \mem_reg[0][2]  ( .D(n1049), .CLK(clk), .R(n216), .S(1'b1), .Q(
        \mem[0][2] ) );
  DFFSR \mem_reg[0][1]  ( .D(n1050), .CLK(clk), .R(n216), .S(1'b1), .Q(
        \mem[0][1] ) );
  DFFSR \mem_reg[0][0]  ( .D(n1051), .CLK(clk), .R(n216), .S(1'b1), .Q(
        \mem[0][0] ) );
  DFFSR \stat_reg[9]  ( .D(tx_transfer_active), .CLK(clk), .R(n216), .S(1'b1), 
        .Q(stat[9]) );
  DFFSR \stat_reg[8]  ( .D(rx_transfer_active), .CLK(clk), .R(n216), .S(1'b1), 
        .Q(stat[8]) );
  DFFSR \stat_reg[4]  ( .D(n1069), .CLK(clk), .R(n216), .S(1'b1), .Q(stat[4])
         );
  DFFSR \stat_reg[3]  ( .D(n1067), .CLK(clk), .R(n217), .S(1'b1), .Q(stat[3])
         );
  DFFSR \stat_reg[2]  ( .D(n1066), .CLK(clk), .R(n217), .S(1'b1), .Q(stat[2])
         );
  DFFSR \stat_reg[1]  ( .D(n1068), .CLK(clk), .R(n217), .S(1'b1), .Q(stat[1])
         );
  DFFSR \stat_reg[0]  ( .D(rx_data_ready), .CLK(clk), .R(n217), .S(1'b1), .Q(
        stat[0]) );
  DFFSR \er_reg[8]  ( .D(tx_error), .CLK(clk), .R(n217), .S(1'b1), .Q(er[8])
         );
  DFFSR \er_reg[0]  ( .D(rx_error), .CLK(clk), .R(n217), .S(1'b1), .Q(er[0])
         );
  DFFSR \bo_reg[6]  ( .D(buffer_occupancy[6]), .CLK(clk), .R(n217), .S(1'b1), 
        .Q(bo[6]) );
  DFFSR \bo_reg[5]  ( .D(buffer_occupancy[5]), .CLK(clk), .R(n217), .S(1'b1), 
        .Q(bo[5]) );
  DFFSR \bo_reg[4]  ( .D(buffer_occupancy[4]), .CLK(clk), .R(n217), .S(1'b1), 
        .Q(bo[4]) );
  DFFSR \bo_reg[3]  ( .D(buffer_occupancy[3]), .CLK(clk), .R(n217), .S(1'b1), 
        .Q(bo[3]) );
  DFFSR \bo_reg[2]  ( .D(buffer_occupancy[2]), .CLK(clk), .R(n217), .S(1'b1), 
        .Q(bo[2]) );
  DFFSR \bo_reg[1]  ( .D(buffer_occupancy[1]), .CLK(clk), .R(n217), .S(1'b1), 
        .Q(bo[1]) );
  DFFSR \bo_reg[0]  ( .D(buffer_occupancy[0]), .CLK(clk), .R(n218), .S(1'b1), 
        .Q(bo[0]) );
  DFFSR \read_state_reg[2]  ( .D(nxt_read_state[2]), .CLK(clk), .R(n218), .S(
        1'b1), .Q(read_state[2]) );
  DFFSR \read_state_reg[1]  ( .D(nxt_read_state[1]), .CLK(clk), .R(n218), .S(
        1'b1), .Q(read_state[1]) );
  DFFSR \read_state_reg[0]  ( .D(nxt_read_state[0]), .CLK(clk), .R(n218), .S(
        1'b1), .Q(read_state[0]) );
  DFFSR \hrdata_reg[8]  ( .D(n1010), .CLK(clk), .R(n218), .S(1'b1), .Q(
        hrdata[8]) );
  DFFSR \hrdata_reg[9]  ( .D(n1009), .CLK(clk), .R(n218), .S(1'b1), .Q(
        hrdata[9]) );
  DFFSR \hrdata_reg[10]  ( .D(n1008), .CLK(clk), .R(n218), .S(1'b1), .Q(
        hrdata[10]) );
  DFFSR \hrdata_reg[11]  ( .D(n1007), .CLK(clk), .R(n218), .S(1'b1), .Q(
        hrdata[11]) );
  DFFSR \hrdata_reg[12]  ( .D(n1006), .CLK(clk), .R(n218), .S(1'b1), .Q(
        hrdata[12]) );
  DFFSR \hrdata_reg[13]  ( .D(n1005), .CLK(clk), .R(n218), .S(1'b1), .Q(
        hrdata[13]) );
  DFFSR \hrdata_reg[14]  ( .D(n1004), .CLK(clk), .R(n218), .S(1'b1), .Q(
        hrdata[14]) );
  DFFSR \hrdata_reg[15]  ( .D(n1003), .CLK(clk), .R(n218), .S(1'b1), .Q(
        hrdata[15]) );
  DFFSR \hrdata_reg[24]  ( .D(n994), .CLK(clk), .R(n219), .S(1'b1), .Q(
        hrdata[24]) );
  DFFSR \hrdata_reg[25]  ( .D(n993), .CLK(clk), .R(n219), .S(1'b1), .Q(
        hrdata[25]) );
  DFFSR \hrdata_reg[26]  ( .D(n992), .CLK(clk), .R(n219), .S(1'b1), .Q(
        hrdata[26]) );
  DFFSR \hrdata_reg[27]  ( .D(n991), .CLK(clk), .R(n219), .S(1'b1), .Q(
        hrdata[27]) );
  DFFSR \hrdata_reg[28]  ( .D(n990), .CLK(clk), .R(n219), .S(1'b1), .Q(
        hrdata[28]) );
  DFFSR \hrdata_reg[29]  ( .D(n989), .CLK(clk), .R(n219), .S(1'b1), .Q(
        hrdata[29]) );
  DFFSR \hrdata_reg[30]  ( .D(n988), .CLK(clk), .R(n219), .S(1'b1), .Q(
        hrdata[30]) );
  DFFSR \hrdata_reg[31]  ( .D(n987), .CLK(clk), .R(n219), .S(1'b1), .Q(
        hrdata[31]) );
  DFFSR \read_rx_reg[2]  ( .D(nxt_read_rx[2]), .CLK(clk), .R(n219), .S(1'b1), 
        .Q(read_rx[2]) );
  DFFSR \read_rx_reg[1]  ( .D(nxt_read_rx[1]), .CLK(clk), .R(n219), .S(1'b1), 
        .Q(read_rx[1]) );
  DFFSR \read_rx_reg[0]  ( .D(nxt_read_rx[0]), .CLK(clk), .R(n219), .S(1'b1), 
        .Q(read_rx[0]) );
  DFFSR \hrdata_reg[4]  ( .D(n1014), .CLK(clk), .R(n219), .S(1'b1), .Q(
        hrdata[4]) );
  DFFSR \hrdata_reg[5]  ( .D(n1013), .CLK(clk), .R(n220), .S(1'b1), .Q(
        hrdata[5]) );
  DFFSR \hrdata_reg[6]  ( .D(n1012), .CLK(clk), .R(n220), .S(1'b1), .Q(
        hrdata[6]) );
  DFFSR \hrdata_reg[7]  ( .D(n1011), .CLK(clk), .R(n220), .S(1'b1), .Q(
        hrdata[7]) );
  DFFSR \hrdata_reg[16]  ( .D(n1002), .CLK(clk), .R(n220), .S(1'b1), .Q(
        hrdata[16]) );
  DFFSR \hrdata_reg[17]  ( .D(n1001), .CLK(clk), .R(n220), .S(1'b1), .Q(
        hrdata[17]) );
  DFFSR \hrdata_reg[18]  ( .D(n1000), .CLK(clk), .R(n220), .S(1'b1), .Q(
        hrdata[18]) );
  DFFSR \hrdata_reg[19]  ( .D(n999), .CLK(clk), .R(n220), .S(1'b1), .Q(
        hrdata[19]) );
  DFFSR \hrdata_reg[20]  ( .D(n998), .CLK(clk), .R(n220), .S(1'b1), .Q(
        hrdata[20]) );
  DFFSR \hrdata_reg[21]  ( .D(n997), .CLK(clk), .R(n220), .S(1'b1), .Q(
        hrdata[21]) );
  DFFSR \hrdata_reg[22]  ( .D(n996), .CLK(clk), .R(n220), .S(1'b1), .Q(
        hrdata[22]) );
  DFFSR \hrdata_reg[23]  ( .D(n995), .CLK(clk), .R(n220), .S(1'b1), .Q(
        hrdata[23]) );
  DFFSR \write_tx_reg[0]  ( .D(nxt_write_tx[0]), .CLK(clk), .R(n220), .S(1'b1), 
        .Q(write_tx[0]) );
  DFFSR \write_data_state_reg[0]  ( .D(nxt_write_data_state[0]), .CLK(clk), 
        .R(n221), .S(1'b1), .Q(write_data_state[0]) );
  DFFSR \write_data_state_reg[1]  ( .D(nxt_write_data_state[1]), .CLK(clk), 
        .R(n221), .S(1'b1), .Q(write_data_state[1]) );
  DFFSR \write_tx_reg[2]  ( .D(nxt_write_tx[2]), .CLK(clk), .R(n221), .S(1'b1), 
        .Q(write_tx[2]) );
  DFFSR \write_tx_reg[1]  ( .D(nxt_write_tx[1]), .CLK(clk), .R(n221), .S(1'b1), 
        .Q(write_tx[1]) );
  DFFSR \write_data_state_reg[2]  ( .D(nxt_write_data_state[2]), .CLK(clk), 
        .R(n221), .S(1'b1), .Q(write_data_state[2]) );
  DFFSR \tx_pac_reg[3]  ( .D(nxt_tx_pac[3]), .CLK(clk), .R(n221), .S(1'b1), 
        .Q(tx_packet[3]) );
  DFFSR \hrdata_reg[3]  ( .D(n1015), .CLK(clk), .R(n221), .S(1'b1), .Q(
        hrdata[3]) );
  DFFSR \tx_pac_reg[2]  ( .D(nxt_tx_pac[2]), .CLK(clk), .R(n221), .S(1'b1), 
        .Q(tx_packet[2]) );
  DFFSR \hrdata_reg[2]  ( .D(n1016), .CLK(clk), .R(n221), .S(1'b1), .Q(
        hrdata[2]) );
  DFFSR \tx_pac_reg[1]  ( .D(nxt_tx_pac[1]), .CLK(clk), .R(n221), .S(1'b1), 
        .Q(tx_packet[1]) );
  DFFSR \hrdata_reg[1]  ( .D(n1017), .CLK(clk), .R(n221), .S(1'b1), .Q(
        hrdata[1]) );
  DFFSR \tx_pac_reg[0]  ( .D(nxt_tx_pac[0]), .CLK(clk), .R(n221), .S(1'b1), 
        .Q(tx_packet[0]) );
  DFFSR flush_ctrl_reg ( .D(n1019), .CLK(clk), .R(n222), .S(1'b1), .Q(clear)
         );
  DFFSR \hrdata_reg[0]  ( .D(n1018), .CLK(clk), .R(n222), .S(1'b1), .Q(
        hrdata[0]) );
  XOR2X1 U4 ( .A(read_state[2]), .B(read_state[1]), .Y(n43) );
  AOI22X1 U5 ( .A(read_state[1]), .B(N1453), .C(n330), .D(N1450), .Y(n41) );
  NAND3X1 U8 ( .A(n43), .B(n331), .C(n329), .Y(n42) );
  OAI21X1 U9 ( .A(n43), .B(n331), .C(n42), .Y(nxt_read_state[0]) );
  AOI21X1 U10 ( .A(N1453), .B(n331), .C(read_state[2]), .Y(n46) );
  NOR2X1 U11 ( .A(read_state[1]), .B(read_state[2]), .Y(n44) );
  NAND3X1 U12 ( .A(N1450), .B(n331), .C(n44), .Y(n45) );
  OAI21X1 U13 ( .A(n330), .B(n46), .C(n45), .Y(nxt_read_state[1]) );
  AOI21X1 U14 ( .A(N1457), .B(read_state[0]), .C(read_state[2]), .Y(n48) );
  NAND3X1 U15 ( .A(read_state[2]), .B(n331), .C(N1450), .Y(n47) );
  OAI21X1 U16 ( .A(n48), .B(n330), .C(n47), .Y(nxt_read_state[2]) );
  AND2X2 U186 ( .A(htrans[1]), .B(hwrite), .Y(n384) );
  AND2X2 U187 ( .A(n391), .B(n392), .Y(n390) );
  AND2X2 U188 ( .A(n392), .B(n394), .Y(n393) );
  AND2X2 U189 ( .A(n408), .B(n269), .Y(n409) );
  AND2X2 U190 ( .A(n416), .B(n417), .Y(n415) );
  AND2X2 U191 ( .A(n546), .B(n474), .Y(n517) );
  AND2X2 U192 ( .A(n548), .B(n474), .Y(n516) );
  AND2X2 U193 ( .A(n552), .B(n474), .Y(n561) );
  AND2X2 U194 ( .A(n601), .B(n549), .Y(n611) );
  AND2X2 U195 ( .A(n503), .B(n612), .Y(n613) );
  AND2X2 U196 ( .A(haddr[2]), .B(haddr[3]), .Y(n610) );
  NAND2X1 U391 ( .A(n356), .B(n357), .Y(tx_data[7]) );
  AOI22X1 U392 ( .A(N522), .B(n350), .C(N512), .D(n348), .Y(n357) );
  AOI22X1 U393 ( .A(N502), .B(n351), .C(N492), .D(n346), .Y(n356) );
  NAND2X1 U394 ( .A(n358), .B(n359), .Y(tx_data[6]) );
  AOI22X1 U395 ( .A(N523), .B(n350), .C(N513), .D(n348), .Y(n359) );
  AOI22X1 U396 ( .A(N503), .B(n351), .C(N493), .D(n346), .Y(n358) );
  NAND2X1 U397 ( .A(n360), .B(n361), .Y(tx_data[5]) );
  AOI22X1 U398 ( .A(N524), .B(n350), .C(N514), .D(n348), .Y(n361) );
  AOI22X1 U399 ( .A(N504), .B(n351), .C(N494), .D(n346), .Y(n360) );
  NAND2X1 U400 ( .A(n362), .B(n363), .Y(tx_data[4]) );
  AOI22X1 U401 ( .A(N525), .B(n350), .C(N515), .D(n348), .Y(n363) );
  AOI22X1 U402 ( .A(N505), .B(n351), .C(N495), .D(n346), .Y(n362) );
  NAND2X1 U403 ( .A(n364), .B(n365), .Y(tx_data[3]) );
  AOI22X1 U404 ( .A(N526), .B(n350), .C(N516), .D(n348), .Y(n365) );
  AOI22X1 U405 ( .A(N506), .B(n351), .C(N496), .D(n346), .Y(n364) );
  NAND2X1 U406 ( .A(n366), .B(n367), .Y(tx_data[2]) );
  AOI22X1 U407 ( .A(N527), .B(n350), .C(N517), .D(n348), .Y(n367) );
  AOI22X1 U408 ( .A(N507), .B(n351), .C(N497), .D(n346), .Y(n366) );
  NAND2X1 U409 ( .A(n368), .B(n369), .Y(tx_data[1]) );
  AOI22X1 U410 ( .A(N528), .B(n350), .C(N518), .D(n348), .Y(n369) );
  AOI22X1 U411 ( .A(N508), .B(n351), .C(N498), .D(n346), .Y(n368) );
  NAND2X1 U412 ( .A(n370), .B(n371), .Y(tx_data[0]) );
  AOI22X1 U413 ( .A(N529), .B(n350), .C(N519), .D(n348), .Y(n371) );
  AOI22X1 U414 ( .A(N509), .B(n351), .C(N499), .D(n346), .Y(n370) );
  OAI22X1 U415 ( .A(n372), .B(n353), .C(n373), .D(n374), .Y(nxt_write_tx[2])
         );
  OAI22X1 U416 ( .A(n372), .B(n354), .C(n374), .D(n375), .Y(nxt_write_tx[1])
         );
  OAI22X1 U417 ( .A(n344), .B(n372), .C(n374), .D(n376), .Y(nxt_write_tx[0])
         );
  NAND2X1 U418 ( .A(n377), .B(n465), .Y(n374) );
  OR2X1 U419 ( .A(n379), .B(n380), .Y(n372) );
  OAI22X1 U420 ( .A(n378), .B(n381), .C(n382), .D(n383), .Y(n380) );
  NAND3X1 U421 ( .A(hsel), .B(n497), .C(n384), .Y(n378) );
  OAI21X1 U422 ( .A(n385), .B(n386), .C(n387), .Y(n379) );
  OAI21X1 U423 ( .A(n388), .B(n389), .C(n390), .Y(nxt_write_data_state[2]) );
  OAI21X1 U424 ( .A(n386), .B(n354), .C(n351), .Y(n391) );
  OAI21X1 U425 ( .A(n345), .B(n382), .C(n393), .Y(nxt_write_data_state[1]) );
  OAI21X1 U426 ( .A(n395), .B(n432), .C(n396), .Y(nxt_tx_pac[3]) );
  OAI21X1 U427 ( .A(n397), .B(n398), .C(n399), .Y(n396) );
  OAI21X1 U428 ( .A(n1080), .B(n400), .C(n401), .Y(n398) );
  OR2X1 U429 ( .A(n1081), .B(n402), .Y(n400) );
  NOR2X1 U430 ( .A(n269), .B(n432), .Y(n397) );
  OAI21X1 U431 ( .A(n251), .B(n401), .C(n403), .Y(nxt_tx_pac[2]) );
  NAND2X1 U432 ( .A(tx_packet[2]), .B(n404), .Y(n403) );
  OAI21X1 U433 ( .A(n395), .B(n449), .C(n405), .Y(nxt_tx_pac[1]) );
  OAI21X1 U434 ( .A(n406), .B(n407), .C(n399), .Y(n405) );
  OAI21X1 U435 ( .A(n408), .B(n402), .C(n401), .Y(n407) );
  NAND3X1 U436 ( .A(hwdata[2]), .B(n521), .C(n409), .Y(n401) );
  NOR2X1 U437 ( .A(hwdata[1]), .B(hwdata[0]), .Y(n408) );
  NOR2X1 U438 ( .A(n269), .B(n449), .Y(n406) );
  OAI21X1 U439 ( .A(n249), .B(n453), .C(n410), .Y(nxt_tx_pac[0]) );
  NAND3X1 U440 ( .A(n399), .B(hwdata[0]), .C(n411), .Y(n410) );
  NOR2X1 U441 ( .A(hwdata[1]), .B(n402), .Y(n411) );
  NAND3X1 U442 ( .A(n269), .B(n1079), .C(n521), .Y(n402) );
  NAND3X1 U443 ( .A(n413), .B(n414), .C(n415), .Y(n412) );
  NOR2X1 U444 ( .A(n418), .B(n419), .Y(n417) );
  NAND3X1 U445 ( .A(n525), .B(n1078), .C(n420), .Y(n419) );
  NOR2X1 U446 ( .A(hwdata[5]), .B(hwdata[4]), .Y(n420) );
  NAND3X1 U447 ( .A(n1075), .B(n1074), .C(n421), .Y(n418) );
  NOR2X1 U448 ( .A(hwdata[9]), .B(hwdata[8]), .Y(n421) );
  NOR2X1 U449 ( .A(n422), .B(n423), .Y(n416) );
  NAND3X1 U450 ( .A(n563), .B(n562), .C(n567), .Y(n423) );
  NAND3X1 U451 ( .A(n556), .B(n537), .C(n424), .Y(n422) );
  NOR2X1 U452 ( .A(hwdata[30]), .B(hwdata[29]), .Y(n424) );
  NOR2X1 U453 ( .A(n425), .B(n426), .Y(n414) );
  NAND3X1 U454 ( .A(n1059), .B(n1058), .C(n1060), .Y(n426) );
  NAND3X1 U455 ( .A(n1057), .B(n1056), .C(n427), .Y(n425) );
  NOR2X1 U456 ( .A(hwdata[23]), .B(hwdata[22]), .Y(n427) );
  NOR2X1 U457 ( .A(n428), .B(n429), .Y(n413) );
  NAND3X1 U458 ( .A(n1070), .B(n1065), .C(n1071), .Y(n429) );
  NAND3X1 U459 ( .A(n1064), .B(n1063), .C(n430), .Y(n428) );
  NOR2X1 U460 ( .A(hwdata[16]), .B(hwdata[15]), .Y(n430) );
  OAI21X1 U461 ( .A(n251), .B(n269), .C(n395), .Y(n404) );
  OAI21X1 U462 ( .A(n431), .B(n211), .C(n250), .Y(n395) );
  NOR2X1 U463 ( .A(n254), .B(tx_transfer_active_falling_edge), .Y(n399) );
  OAI22X1 U464 ( .A(n373), .B(n434), .C(n435), .D(n340), .Y(nxt_read_rx[2]) );
  OAI22X1 U465 ( .A(n375), .B(n434), .C(n341), .D(n435), .Y(nxt_read_rx[1]) );
  OAI22X1 U466 ( .A(n376), .B(n434), .C(n342), .D(n435), .Y(nxt_read_rx[0]) );
  OR2X1 U467 ( .A(n436), .B(n437), .Y(n435) );
  OAI22X1 U468 ( .A(n381), .B(n438), .C(N1453), .D(n439), .Y(n437) );
  OAI21X1 U469 ( .A(n508), .B(n440), .C(n377), .Y(n381) );
  NAND2X1 U470 ( .A(hsize[1]), .B(n514), .Y(n373) );
  OAI21X1 U471 ( .A(N1457), .B(n441), .C(n442), .Y(n436) );
  NAND2X1 U472 ( .A(n468), .B(n377), .Y(n434) );
  AOI22X1 U474 ( .A(hwdata[31]), .B(n446), .C(hrdata[31]), .D(n447), .Y(n445)
         );
  NAND2X1 U475 ( .A(rx_data[7]), .B(n328), .Y(n444) );
  AOI22X1 U478 ( .A(hwdata[30]), .B(n446), .C(hrdata[30]), .D(n447), .Y(n452)
         );
  NAND2X1 U479 ( .A(rx_data[6]), .B(n328), .Y(n451) );
  AOI22X1 U482 ( .A(hwdata[29]), .B(n446), .C(hrdata[29]), .D(n447), .Y(n455)
         );
  NAND2X1 U483 ( .A(rx_data[5]), .B(n328), .Y(n454) );
  AOI22X1 U486 ( .A(hwdata[28]), .B(n446), .C(hrdata[28]), .D(n447), .Y(n458)
         );
  NAND2X1 U487 ( .A(rx_data[4]), .B(n328), .Y(n457) );
  AOI22X1 U490 ( .A(hwdata[27]), .B(n446), .C(hrdata[27]), .D(n447), .Y(n461)
         );
  NAND2X1 U491 ( .A(rx_data[3]), .B(n328), .Y(n460) );
  AOI22X1 U494 ( .A(hwdata[26]), .B(n446), .C(hrdata[26]), .D(n447), .Y(n464)
         );
  NAND2X1 U495 ( .A(rx_data[2]), .B(n328), .Y(n463) );
  AOI22X1 U498 ( .A(hwdata[25]), .B(n446), .C(hrdata[25]), .D(n447), .Y(n467)
         );
  NAND2X1 U499 ( .A(rx_data[1]), .B(n328), .Y(n466) );
  AOI22X1 U502 ( .A(hwdata[24]), .B(n446), .C(hrdata[24]), .D(n447), .Y(n470)
         );
  OAI21X1 U503 ( .A(n471), .B(n472), .C(n473), .Y(n447) );
  NOR2X1 U504 ( .A(n474), .B(n471), .Y(n446) );
  NAND2X1 U505 ( .A(rx_data[0]), .B(n328), .Y(n469) );
  NAND2X1 U510 ( .A(n473), .B(n442), .Y(n471) );
  NAND2X1 U511 ( .A(n442), .B(n477), .Y(n473) );
  AOI22X1 U513 ( .A(hwdata[23]), .B(n481), .C(hrdata[23]), .D(n482), .Y(n480)
         );
  NAND2X1 U514 ( .A(n327), .B(rx_data[7]), .Y(n479) );
  AOI22X1 U517 ( .A(hwdata[22]), .B(n481), .C(hrdata[22]), .D(n482), .Y(n487)
         );
  NAND2X1 U518 ( .A(n327), .B(rx_data[6]), .Y(n486) );
  AOI22X1 U521 ( .A(hwdata[21]), .B(n481), .C(hrdata[21]), .D(n482), .Y(n490)
         );
  NAND2X1 U522 ( .A(n327), .B(rx_data[5]), .Y(n489) );
  AOI22X1 U525 ( .A(hwdata[20]), .B(n481), .C(hrdata[20]), .D(n482), .Y(n493)
         );
  NAND2X1 U526 ( .A(n327), .B(rx_data[4]), .Y(n492) );
  AOI22X1 U529 ( .A(hwdata[19]), .B(n481), .C(hrdata[19]), .D(n482), .Y(n496)
         );
  NAND2X1 U530 ( .A(n327), .B(rx_data[3]), .Y(n495) );
  AOI22X1 U533 ( .A(hwdata[18]), .B(n481), .C(hrdata[18]), .D(n482), .Y(n499)
         );
  NAND2X1 U534 ( .A(n327), .B(rx_data[2]), .Y(n498) );
  AOI22X1 U537 ( .A(hwdata[17]), .B(n481), .C(hrdata[17]), .D(n482), .Y(n502)
         );
  NAND2X1 U538 ( .A(n327), .B(rx_data[1]), .Y(n501) );
  AOI22X1 U541 ( .A(hwdata[16]), .B(n481), .C(hrdata[16]), .D(n482), .Y(n505)
         );
  OAI21X1 U542 ( .A(n472), .B(n506), .C(n507), .Y(n482) );
  NOR2X1 U543 ( .A(n506), .B(n474), .Y(n481) );
  NAND2X1 U544 ( .A(n327), .B(rx_data[0]), .Y(n504) );
  NAND2X1 U549 ( .A(n507), .B(n509), .Y(n506) );
  NAND2X1 U550 ( .A(n509), .B(n477), .Y(n507) );
  OAI21X1 U551 ( .A(n339), .B(n510), .C(n511), .Y(n1003) );
  AOI21X1 U552 ( .A(rx_data[7]), .B(n323), .C(n512), .Y(n511) );
  AOI22X1 U555 ( .A(hrdata[15]), .B(n262), .C(hwdata[15]), .D(n260), .Y(n513)
         );
  OAI21X1 U556 ( .A(n510), .B(n338), .C(n518), .Y(n1004) );
  AOI21X1 U557 ( .A(rx_data[6]), .B(n323), .C(n519), .Y(n518) );
  AOI22X1 U560 ( .A(hrdata[14]), .B(n262), .C(hwdata[14]), .D(n260), .Y(n520)
         );
  OAI21X1 U561 ( .A(n510), .B(n337), .C(n522), .Y(n1005) );
  AOI21X1 U562 ( .A(rx_data[5]), .B(n323), .C(n523), .Y(n522) );
  AOI22X1 U565 ( .A(hrdata[13]), .B(n262), .C(hwdata[13]), .D(n260), .Y(n524)
         );
  OAI21X1 U566 ( .A(n510), .B(n336), .C(n526), .Y(n1006) );
  AOI21X1 U567 ( .A(rx_data[4]), .B(n323), .C(n527), .Y(n526) );
  AOI22X1 U570 ( .A(hrdata[12]), .B(n262), .C(hwdata[12]), .D(n260), .Y(n528)
         );
  OAI21X1 U571 ( .A(n510), .B(n335), .C(n530), .Y(n1007) );
  AOI21X1 U572 ( .A(rx_data[3]), .B(n323), .C(n531), .Y(n530) );
  AOI22X1 U575 ( .A(hrdata[11]), .B(n262), .C(hwdata[11]), .D(n260), .Y(n532)
         );
  OAI21X1 U576 ( .A(n510), .B(n334), .C(n534), .Y(n1008) );
  AOI21X1 U577 ( .A(rx_data[2]), .B(n323), .C(n535), .Y(n534) );
  AOI22X1 U580 ( .A(hrdata[10]), .B(n262), .C(hwdata[10]), .D(n260), .Y(n536)
         );
  OAI21X1 U581 ( .A(n510), .B(n333), .C(n538), .Y(n1009) );
  AOI21X1 U582 ( .A(rx_data[1]), .B(n323), .C(n539), .Y(n538) );
  AOI21X1 U583 ( .A(n540), .B(n541), .C(n515), .Y(n539) );
  AOI22X1 U585 ( .A(hrdata[9]), .B(n262), .C(hwdata[9]), .D(n260), .Y(n540) );
  OAI21X1 U586 ( .A(n510), .B(n332), .C(n542), .Y(n1010) );
  AOI21X1 U587 ( .A(rx_data[0]), .B(n323), .C(n543), .Y(n542) );
  AOI21X1 U588 ( .A(n544), .B(n545), .C(n515), .Y(n543) );
  NAND2X1 U589 ( .A(n510), .B(n441), .Y(n515) );
  AOI22X1 U590 ( .A(er[8]), .B(n516), .C(stat[8]), .D(n517), .Y(n545) );
  OAI21X1 U591 ( .A(n476), .B(n514), .C(n547), .Y(n546) );
  OAI21X1 U592 ( .A(n514), .B(n491), .C(n549), .Y(n548) );
  AOI22X1 U593 ( .A(hrdata[8]), .B(n262), .C(hwdata[8]), .D(n260), .Y(n544) );
  NAND2X1 U594 ( .A(n441), .B(n477), .Y(n510) );
  OAI21X1 U595 ( .A(n343), .B(n550), .C(n551), .Y(n1011) );
  AOI22X1 U596 ( .A(rx_data[7]), .B(n325), .C(n552), .D(n553), .Y(n551) );
  OAI21X1 U597 ( .A(n474), .B(n1074), .C(n554), .Y(n553) );
  NAND2X1 U599 ( .A(n555), .B(n474), .Y(n472) );
  NAND2X1 U601 ( .A(n559), .B(n560), .Y(n1012) );
  AOI22X1 U602 ( .A(n561), .B(n321), .C(hwdata[6]), .D(n258), .Y(n560) );
  AOI22X1 U604 ( .A(bo[6]), .B(n484), .C(hrdata[6]), .D(n555), .Y(n564) );
  AOI22X1 U606 ( .A(rx_data[6]), .B(n325), .C(hrdata[6]), .D(n261), .Y(n559)
         );
  NAND2X1 U607 ( .A(n565), .B(n566), .Y(n1013) );
  AOI22X1 U608 ( .A(n561), .B(n322), .C(hwdata[5]), .D(n258), .Y(n566) );
  AOI22X1 U610 ( .A(bo[5]), .B(n484), .C(hrdata[5]), .D(n555), .Y(n569) );
  AOI22X1 U612 ( .A(rx_data[5]), .B(n325), .C(hrdata[5]), .D(n261), .Y(n565)
         );
  NAND2X1 U613 ( .A(n570), .B(n571), .Y(n1014) );
  AOI22X1 U614 ( .A(n561), .B(n572), .C(hwdata[4]), .D(n258), .Y(n571) );
  NAND2X1 U615 ( .A(n573), .B(n574), .Y(n572) );
  AOI22X1 U616 ( .A(bo[4]), .B(n484), .C(hrdata[4]), .D(n555), .Y(n574) );
  AOI22X1 U618 ( .A(rx_data[4]), .B(n325), .C(hrdata[4]), .D(n261), .Y(n570)
         );
  NAND2X1 U619 ( .A(n575), .B(n576), .Y(n1015) );
  AOI22X1 U620 ( .A(n561), .B(n577), .C(hwdata[3]), .D(n258), .Y(n576) );
  NAND2X1 U621 ( .A(n578), .B(n579), .Y(n577) );
  AOI21X1 U622 ( .A(bo[3]), .B(n484), .C(n580), .Y(n579) );
  OAI22X1 U623 ( .A(n432), .B(n581), .C(n478), .D(n443), .Y(n580) );
  AOI22X1 U625 ( .A(rx_data[3]), .B(n325), .C(hrdata[3]), .D(n261), .Y(n575)
         );
  NAND2X1 U626 ( .A(n582), .B(n583), .Y(n1016) );
  AOI22X1 U627 ( .A(n561), .B(n584), .C(n258), .D(hwdata[2]), .Y(n583) );
  NAND2X1 U628 ( .A(n585), .B(n586), .Y(n584) );
  AOI21X1 U629 ( .A(bo[2]), .B(n484), .C(n448), .Y(n586) );
  AOI22X1 U630 ( .A(tx_packet[2]), .B(n475), .C(n555), .D(hrdata[2]), .Y(n587)
         );
  AOI22X1 U632 ( .A(rx_data[2]), .B(n325), .C(hrdata[2]), .D(n261), .Y(n582)
         );
  NAND2X1 U633 ( .A(n588), .B(n589), .Y(n1017) );
  AOI22X1 U634 ( .A(n561), .B(n590), .C(n258), .D(hwdata[1]), .Y(n589) );
  NAND2X1 U635 ( .A(n592), .B(n593), .Y(n590) );
  AOI21X1 U636 ( .A(bo[1]), .B(n484), .C(n450), .Y(n593) );
  AOI22X1 U637 ( .A(tx_packet[1]), .B(n475), .C(n555), .D(hrdata[1]), .Y(n594)
         );
  AOI22X1 U639 ( .A(rx_data[1]), .B(n325), .C(hrdata[1]), .D(n261), .Y(n588)
         );
  NAND2X1 U640 ( .A(n259), .B(n595), .Y(n1018) );
  AOI22X1 U641 ( .A(n261), .B(hrdata[0]), .C(n325), .D(rx_data[0]), .Y(n595)
         );
  OAI21X1 U642 ( .A(n1081), .B(n591), .C(n597), .Y(n596) );
  OAI21X1 U643 ( .A(n598), .B(n599), .C(n561), .Y(n597) );
  OAI21X1 U644 ( .A(n485), .B(n320), .C(n600), .Y(n599) );
  AOI22X1 U645 ( .A(bo[0]), .B(n484), .C(er[0]), .D(n557), .Y(n600) );
  OAI21X1 U646 ( .A(n514), .B(n491), .C(n601), .Y(n557) );
  OAI21X1 U647 ( .A(n476), .B(n514), .C(n603), .Y(n558) );
  NOR2X1 U648 ( .A(n604), .B(n605), .Y(n476) );
  OAI21X1 U649 ( .A(n453), .B(n581), .C(n606), .Y(n598) );
  AOI22X1 U650 ( .A(hrdata[0]), .B(n555), .C(clear), .D(n483), .Y(n606) );
  NOR2X1 U651 ( .A(n608), .B(n609), .Y(n555) );
  NAND3X1 U652 ( .A(n581), .B(n602), .C(n607), .Y(n609) );
  NAND2X1 U653 ( .A(n610), .B(n605), .Y(n607) );
  NAND3X1 U654 ( .A(haddr[3]), .B(n488), .C(n604), .Y(n602) );
  NAND3X1 U655 ( .A(n547), .B(n603), .C(n611), .Y(n608) );
  NAND3X1 U656 ( .A(haddr[0]), .B(haddr[1]), .C(n612), .Y(n549) );
  NAND3X1 U657 ( .A(haddr[1]), .B(n494), .C(n612), .Y(n601) );
  NAND2X1 U658 ( .A(n604), .B(n612), .Y(n603) );
  NAND2X1 U659 ( .A(n605), .B(n612), .Y(n547) );
  NOR2X1 U660 ( .A(n494), .B(haddr[1]), .Y(n605) );
  NAND2X1 U661 ( .A(n610), .B(n604), .Y(n581) );
  NOR2X1 U662 ( .A(haddr[0]), .B(haddr[1]), .Y(n604) );
  NAND2X1 U663 ( .A(n552), .B(n260), .Y(n591) );
  NOR2X1 U664 ( .A(n261), .B(n325), .Y(n552) );
  NAND2X1 U665 ( .A(n439), .B(n477), .Y(n550) );
  OAI21X1 U666 ( .A(n613), .B(n614), .C(n468), .Y(n477) );
  NAND3X1 U667 ( .A(htrans[1]), .B(hsel), .C(n615), .Y(n438) );
  NOR2X1 U668 ( .A(hwrite), .B(htrans[0]), .Y(n615) );
  NAND2X1 U669 ( .A(n376), .B(n474), .Y(n614) );
  NAND3X1 U670 ( .A(n616), .B(n617), .C(n618), .Y(n474) );
  NOR2X1 U671 ( .A(n619), .B(n620), .Y(n618) );
  XOR2X1 U672 ( .A(haddr_f[2]), .B(haddr[2]), .Y(n620) );
  XOR2X1 U673 ( .A(haddr_f[0]), .B(haddr[0]), .Y(n619) );
  XOR2X1 U674 ( .A(n491), .B(haddr_f[1]), .Y(n617) );
  NOR2X1 U675 ( .A(n263), .B(n621), .Y(n616) );
  XOR2X1 U676 ( .A(haddr_f[3]), .B(haddr[3]), .Y(n621) );
  NOR2X1 U677 ( .A(n488), .B(haddr[3]), .Y(n612) );
  OAI21X1 U678 ( .A(n622), .B(n456), .C(n623), .Y(n1019) );
  NAND3X1 U679 ( .A(n624), .B(n625), .C(n626), .Y(n623) );
  NOR2X1 U680 ( .A(n1081), .B(n627), .Y(n626) );
  AOI21X1 U681 ( .A(n625), .B(n627), .C(n252), .Y(n622) );
  NAND2X1 U682 ( .A(n625), .B(n254), .Y(n624) );
  NAND3X1 U683 ( .A(n629), .B(n630), .C(n631), .Y(n625) );
  NOR2X1 U684 ( .A(buffer_occupancy[0]), .B(n632), .Y(n631) );
  OR2X1 U685 ( .A(buffer_occupancy[2]), .B(buffer_occupancy[1]), .Y(n632) );
  NOR2X1 U686 ( .A(buffer_occupancy[6]), .B(buffer_occupancy[5]), .Y(n630) );
  NOR2X1 U687 ( .A(buffer_occupancy[4]), .B(buffer_occupancy[3]), .Y(n629) );
  OAI21X1 U688 ( .A(n207), .B(n288), .C(n634), .Y(n1020) );
  OAI21X1 U689 ( .A(n635), .B(n636), .C(n210), .Y(n634) );
  OAI21X1 U690 ( .A(n242), .B(n568), .C(n637), .Y(n636) );
  OAI21X1 U691 ( .A(n638), .B(n639), .C(n640), .Y(n637) );
  OAI22X1 U692 ( .A(n232), .B(n525), .C(n1062), .D(n641), .Y(n639) );
  NOR2X1 U693 ( .A(n234), .B(n288), .Y(n638) );
  OAI22X1 U694 ( .A(n1074), .B(n642), .C(n643), .D(n211), .Y(n635) );
  AOI22X1 U695 ( .A(\mem[3][7] ), .B(n644), .C(n281), .D(n645), .Y(n643) );
  OAI21X1 U696 ( .A(n206), .B(n289), .C(n646), .Y(n1021) );
  OAI21X1 U697 ( .A(n647), .B(n648), .C(n210), .Y(n646) );
  OAI21X1 U698 ( .A(n242), .B(n1055), .C(n649), .Y(n648) );
  OAI21X1 U699 ( .A(n650), .B(n651), .C(n640), .Y(n649) );
  OAI22X1 U700 ( .A(n232), .B(n529), .C(n1063), .D(n641), .Y(n651) );
  NOR2X1 U701 ( .A(n234), .B(n289), .Y(n650) );
  OAI22X1 U702 ( .A(n1075), .B(n642), .C(n652), .D(n211), .Y(n647) );
  AOI22X1 U703 ( .A(\mem[3][6] ), .B(n644), .C(n281), .D(n653), .Y(n652) );
  OAI21X1 U704 ( .A(n206), .B(n290), .C(n654), .Y(n1022) );
  OAI21X1 U705 ( .A(n655), .B(n656), .C(n210), .Y(n654) );
  OAI21X1 U706 ( .A(n242), .B(n1056), .C(n657), .Y(n656) );
  OAI21X1 U707 ( .A(n658), .B(n659), .C(n640), .Y(n657) );
  OAI22X1 U708 ( .A(n232), .B(n533), .C(n1064), .D(n641), .Y(n659) );
  NOR2X1 U709 ( .A(n234), .B(n290), .Y(n658) );
  OAI22X1 U710 ( .A(n1076), .B(n642), .C(n660), .D(n211), .Y(n655) );
  AOI22X1 U711 ( .A(\mem[3][5] ), .B(n644), .C(n281), .D(n661), .Y(n660) );
  OAI21X1 U712 ( .A(n206), .B(n291), .C(n662), .Y(n1023) );
  OAI21X1 U713 ( .A(n663), .B(n664), .C(n209), .Y(n662) );
  OAI21X1 U714 ( .A(n242), .B(n1057), .C(n665), .Y(n664) );
  OAI21X1 U715 ( .A(n666), .B(n667), .C(n640), .Y(n665) );
  OAI22X1 U716 ( .A(n232), .B(n537), .C(n1065), .D(n641), .Y(n667) );
  NOR2X1 U717 ( .A(n234), .B(n291), .Y(n666) );
  OAI22X1 U718 ( .A(n1077), .B(n642), .C(n668), .D(n211), .Y(n663) );
  AOI22X1 U719 ( .A(\mem[3][4] ), .B(n644), .C(n281), .D(n669), .Y(n668) );
  OAI21X1 U720 ( .A(n206), .B(n292), .C(n670), .Y(n1024) );
  OAI21X1 U721 ( .A(n671), .B(n672), .C(n209), .Y(n670) );
  OAI21X1 U722 ( .A(n242), .B(n1058), .C(n673), .Y(n672) );
  OAI21X1 U723 ( .A(n674), .B(n675), .C(n640), .Y(n673) );
  OAI22X1 U724 ( .A(n232), .B(n556), .C(n1070), .D(n641), .Y(n675) );
  NOR2X1 U725 ( .A(n234), .B(n292), .Y(n674) );
  OAI22X1 U726 ( .A(n1078), .B(n642), .C(n676), .D(n211), .Y(n671) );
  AOI22X1 U727 ( .A(\mem[3][3] ), .B(n644), .C(n281), .D(n677), .Y(n676) );
  OAI21X1 U728 ( .A(n206), .B(n293), .C(n678), .Y(n1025) );
  OAI21X1 U729 ( .A(n679), .B(n680), .C(n209), .Y(n678) );
  OAI21X1 U730 ( .A(n242), .B(n1059), .C(n681), .Y(n680) );
  OAI21X1 U731 ( .A(n682), .B(n683), .C(n640), .Y(n681) );
  OAI22X1 U732 ( .A(n232), .B(n562), .C(n1071), .D(n641), .Y(n683) );
  NOR2X1 U733 ( .A(n234), .B(n293), .Y(n682) );
  OAI22X1 U734 ( .A(n1079), .B(n642), .C(n684), .D(n211), .Y(n679) );
  AOI22X1 U735 ( .A(\mem[3][2] ), .B(n644), .C(n281), .D(n685), .Y(n684) );
  OAI21X1 U736 ( .A(n206), .B(n294), .C(n686), .Y(n1026) );
  OAI21X1 U737 ( .A(n687), .B(n688), .C(n209), .Y(n686) );
  OAI21X1 U738 ( .A(n242), .B(n1060), .C(n689), .Y(n688) );
  OAI21X1 U739 ( .A(n690), .B(n691), .C(n640), .Y(n689) );
  OAI22X1 U740 ( .A(n232), .B(n563), .C(n1072), .D(n641), .Y(n691) );
  NOR2X1 U741 ( .A(n234), .B(n294), .Y(n690) );
  OAI22X1 U742 ( .A(n1080), .B(n642), .C(n692), .D(n211), .Y(n687) );
  AOI22X1 U743 ( .A(\mem[3][1] ), .B(n644), .C(n281), .D(n693), .Y(n692) );
  OAI21X1 U744 ( .A(n206), .B(n295), .C(n694), .Y(n1027) );
  OAI21X1 U745 ( .A(n695), .B(n696), .C(n209), .Y(n694) );
  OAI21X1 U746 ( .A(n242), .B(n1061), .C(n697), .Y(n696) );
  OAI21X1 U747 ( .A(n698), .B(n699), .C(n640), .Y(n697) );
  OAI22X1 U748 ( .A(n232), .B(n567), .C(n1073), .D(n641), .Y(n699) );
  NAND2X1 U749 ( .A(n277), .B(n700), .Y(n641) );
  OAI21X1 U750 ( .A(n702), .B(n703), .C(n704), .Y(n701) );
  NAND3X1 U751 ( .A(n705), .B(n706), .C(n233), .Y(n704) );
  NOR2X1 U752 ( .A(n234), .B(n295), .Y(n698) );
  OAI21X1 U753 ( .A(n277), .B(n709), .C(n710), .Y(n708) );
  NAND3X1 U754 ( .A(n706), .B(n707), .C(n705), .Y(n710) );
  NAND3X1 U755 ( .A(n287), .B(n711), .C(N992), .Y(n707) );
  OAI21X1 U756 ( .A(n640), .B(n703), .C(n713), .Y(n712) );
  NAND3X1 U757 ( .A(n705), .B(n640), .C(n243), .Y(n713) );
  NAND3X1 U758 ( .A(n203), .B(n714), .C(n204), .Y(n706) );
  NOR2X1 U759 ( .A(n715), .B(n277), .Y(n705) );
  NAND3X1 U760 ( .A(n287), .B(n716), .C(N787), .Y(n702) );
  OAI22X1 U761 ( .A(n1081), .B(n642), .C(n717), .D(n212), .Y(n695) );
  AOI22X1 U762 ( .A(\mem[3][0] ), .B(n644), .C(n281), .D(n718), .Y(n717) );
  NAND2X1 U763 ( .A(n281), .B(n719), .Y(n644) );
  NAND2X1 U764 ( .A(n281), .B(n700), .Y(n642) );
  NAND3X1 U765 ( .A(n205), .B(n203), .C(n720), .Y(n640) );
  OAI21X1 U766 ( .A(n206), .B(n296), .C(n721), .Y(n1028) );
  OAI21X1 U767 ( .A(n722), .B(n723), .C(n209), .Y(n721) );
  OAI21X1 U768 ( .A(n240), .B(n568), .C(n724), .Y(n723) );
  OAI21X1 U769 ( .A(n725), .B(n726), .C(n727), .Y(n724) );
  OAI22X1 U770 ( .A(n229), .B(n525), .C(n1062), .D(n728), .Y(n726) );
  NOR2X1 U771 ( .A(n231), .B(n296), .Y(n725) );
  OAI22X1 U772 ( .A(n1074), .B(n729), .C(n730), .D(n211), .Y(n722) );
  AOI22X1 U773 ( .A(\mem[2][7] ), .B(n731), .C(n280), .D(n645), .Y(n730) );
  OAI21X1 U774 ( .A(n206), .B(n297), .C(n732), .Y(n1029) );
  OAI21X1 U775 ( .A(n733), .B(n734), .C(n209), .Y(n732) );
  OAI21X1 U776 ( .A(n240), .B(n1055), .C(n735), .Y(n734) );
  OAI21X1 U777 ( .A(n736), .B(n737), .C(n727), .Y(n735) );
  OAI22X1 U778 ( .A(n229), .B(n529), .C(n1063), .D(n728), .Y(n737) );
  NOR2X1 U779 ( .A(n231), .B(n297), .Y(n736) );
  OAI22X1 U780 ( .A(n1075), .B(n729), .C(n738), .D(n211), .Y(n733) );
  AOI22X1 U781 ( .A(\mem[2][6] ), .B(n731), .C(n280), .D(n653), .Y(n738) );
  OAI21X1 U782 ( .A(n206), .B(n298), .C(n739), .Y(n1030) );
  OAI21X1 U783 ( .A(n740), .B(n741), .C(n209), .Y(n739) );
  OAI21X1 U784 ( .A(n240), .B(n1056), .C(n742), .Y(n741) );
  OAI21X1 U785 ( .A(n743), .B(n744), .C(n727), .Y(n742) );
  OAI22X1 U786 ( .A(n229), .B(n533), .C(n1064), .D(n728), .Y(n744) );
  NOR2X1 U787 ( .A(n231), .B(n298), .Y(n743) );
  OAI22X1 U788 ( .A(n1076), .B(n729), .C(n745), .D(n211), .Y(n740) );
  AOI22X1 U789 ( .A(\mem[2][5] ), .B(n731), .C(n280), .D(n661), .Y(n745) );
  OAI21X1 U790 ( .A(n206), .B(n299), .C(n746), .Y(n1031) );
  OAI21X1 U791 ( .A(n747), .B(n748), .C(n209), .Y(n746) );
  OAI21X1 U792 ( .A(n240), .B(n1057), .C(n749), .Y(n748) );
  OAI21X1 U793 ( .A(n750), .B(n751), .C(n727), .Y(n749) );
  OAI22X1 U794 ( .A(n229), .B(n537), .C(n1065), .D(n728), .Y(n751) );
  NOR2X1 U795 ( .A(n231), .B(n299), .Y(n750) );
  OAI22X1 U796 ( .A(n1077), .B(n729), .C(n752), .D(n211), .Y(n747) );
  AOI22X1 U797 ( .A(\mem[2][4] ), .B(n731), .C(n280), .D(n669), .Y(n752) );
  OAI21X1 U798 ( .A(n206), .B(n300), .C(n753), .Y(n1032) );
  OAI21X1 U799 ( .A(n754), .B(n755), .C(n209), .Y(n753) );
  OAI21X1 U800 ( .A(n240), .B(n1058), .C(n756), .Y(n755) );
  OAI21X1 U801 ( .A(n757), .B(n758), .C(n727), .Y(n756) );
  OAI22X1 U802 ( .A(n229), .B(n556), .C(n1070), .D(n728), .Y(n758) );
  NOR2X1 U803 ( .A(n231), .B(n300), .Y(n757) );
  OAI22X1 U804 ( .A(n1078), .B(n729), .C(n759), .D(n211), .Y(n754) );
  AOI22X1 U805 ( .A(\mem[2][3] ), .B(n731), .C(n280), .D(n677), .Y(n759) );
  OAI21X1 U806 ( .A(n206), .B(n301), .C(n760), .Y(n1033) );
  OAI21X1 U807 ( .A(n761), .B(n762), .C(n209), .Y(n760) );
  OAI21X1 U808 ( .A(n240), .B(n1059), .C(n763), .Y(n762) );
  OAI21X1 U809 ( .A(n764), .B(n765), .C(n727), .Y(n763) );
  OAI22X1 U810 ( .A(n229), .B(n562), .C(n1071), .D(n728), .Y(n765) );
  NOR2X1 U811 ( .A(n231), .B(n301), .Y(n764) );
  OAI22X1 U812 ( .A(n1079), .B(n729), .C(n766), .D(n212), .Y(n761) );
  AOI22X1 U813 ( .A(\mem[2][2] ), .B(n731), .C(n280), .D(n685), .Y(n766) );
  OAI21X1 U814 ( .A(n207), .B(n302), .C(n767), .Y(n1034) );
  OAI21X1 U815 ( .A(n768), .B(n769), .C(n208), .Y(n767) );
  OAI21X1 U816 ( .A(n240), .B(n1060), .C(n770), .Y(n769) );
  OAI21X1 U817 ( .A(n771), .B(n772), .C(n727), .Y(n770) );
  OAI22X1 U818 ( .A(n229), .B(n563), .C(n1072), .D(n728), .Y(n772) );
  NOR2X1 U819 ( .A(n231), .B(n302), .Y(n771) );
  OAI22X1 U820 ( .A(n1080), .B(n729), .C(n773), .D(n212), .Y(n768) );
  AOI22X1 U821 ( .A(\mem[2][1] ), .B(n731), .C(n280), .D(n693), .Y(n773) );
  OAI21X1 U822 ( .A(n207), .B(n303), .C(n774), .Y(n1035) );
  OAI21X1 U823 ( .A(n775), .B(n776), .C(n208), .Y(n774) );
  OAI21X1 U824 ( .A(n240), .B(n1061), .C(n777), .Y(n776) );
  OAI21X1 U825 ( .A(n778), .B(n779), .C(n727), .Y(n777) );
  OAI22X1 U826 ( .A(n229), .B(n567), .C(n1073), .D(n728), .Y(n779) );
  NAND2X1 U827 ( .A(n276), .B(n700), .Y(n728) );
  OAI21X1 U828 ( .A(n703), .B(n781), .C(n782), .Y(n780) );
  NAND3X1 U829 ( .A(n783), .B(n784), .C(n230), .Y(n782) );
  NOR2X1 U830 ( .A(n231), .B(n303), .Y(n778) );
  OAI21X1 U831 ( .A(n276), .B(n709), .C(n787), .Y(n786) );
  NAND3X1 U832 ( .A(n784), .B(n785), .C(n783), .Y(n787) );
  NAND3X1 U833 ( .A(n711), .B(n203), .C(N992), .Y(n785) );
  OAI21X1 U834 ( .A(n703), .B(n727), .C(n789), .Y(n788) );
  NAND3X1 U835 ( .A(n783), .B(n727), .C(n241), .Y(n789) );
  NAND3X1 U836 ( .A(n714), .B(n287), .C(n204), .Y(n784) );
  NOR2X1 U837 ( .A(n715), .B(n276), .Y(n783) );
  NAND3X1 U838 ( .A(n716), .B(n203), .C(N787), .Y(n781) );
  OAI22X1 U839 ( .A(n1081), .B(n729), .C(n790), .D(n212), .Y(n775) );
  AOI22X1 U840 ( .A(\mem[2][0] ), .B(n731), .C(n280), .D(n718), .Y(n790) );
  NAND2X1 U841 ( .A(n280), .B(n719), .Y(n731) );
  NAND2X1 U842 ( .A(n280), .B(n700), .Y(n729) );
  NAND3X1 U843 ( .A(n205), .B(n287), .C(n720), .Y(n727) );
  OAI21X1 U844 ( .A(n207), .B(n304), .C(n791), .Y(n1036) );
  OAI21X1 U845 ( .A(n792), .B(n793), .C(n209), .Y(n791) );
  OAI21X1 U846 ( .A(n238), .B(n568), .C(n794), .Y(n793) );
  OAI21X1 U847 ( .A(n795), .B(n796), .C(n797), .Y(n794) );
  OAI22X1 U848 ( .A(n226), .B(n525), .C(n1062), .D(n798), .Y(n796) );
  NOR2X1 U849 ( .A(n228), .B(n304), .Y(n795) );
  OAI22X1 U850 ( .A(n1074), .B(n799), .C(n800), .D(n212), .Y(n792) );
  AOI22X1 U851 ( .A(\mem[1][7] ), .B(n801), .C(n279), .D(n645), .Y(n800) );
  OAI21X1 U852 ( .A(n207), .B(n305), .C(n802), .Y(n1037) );
  OAI21X1 U853 ( .A(n803), .B(n804), .C(n208), .Y(n802) );
  OAI21X1 U854 ( .A(n238), .B(n1055), .C(n805), .Y(n804) );
  OAI21X1 U855 ( .A(n806), .B(n807), .C(n797), .Y(n805) );
  OAI22X1 U856 ( .A(n226), .B(n529), .C(n1063), .D(n798), .Y(n807) );
  NOR2X1 U857 ( .A(n228), .B(n305), .Y(n806) );
  OAI22X1 U858 ( .A(n1075), .B(n799), .C(n808), .D(n212), .Y(n803) );
  AOI22X1 U859 ( .A(\mem[1][6] ), .B(n801), .C(n279), .D(n653), .Y(n808) );
  OAI21X1 U860 ( .A(n207), .B(n306), .C(n809), .Y(n1038) );
  OAI21X1 U861 ( .A(n810), .B(n811), .C(n208), .Y(n809) );
  OAI21X1 U862 ( .A(n238), .B(n1056), .C(n812), .Y(n811) );
  OAI21X1 U863 ( .A(n813), .B(n814), .C(n797), .Y(n812) );
  OAI22X1 U864 ( .A(n226), .B(n533), .C(n1064), .D(n798), .Y(n814) );
  NOR2X1 U865 ( .A(n228), .B(n306), .Y(n813) );
  OAI22X1 U866 ( .A(n1076), .B(n799), .C(n815), .D(n212), .Y(n810) );
  AOI22X1 U867 ( .A(\mem[1][5] ), .B(n801), .C(n279), .D(n661), .Y(n815) );
  OAI21X1 U868 ( .A(n207), .B(n307), .C(n816), .Y(n1039) );
  OAI21X1 U869 ( .A(n817), .B(n818), .C(n208), .Y(n816) );
  OAI21X1 U870 ( .A(n238), .B(n1057), .C(n819), .Y(n818) );
  OAI21X1 U871 ( .A(n820), .B(n821), .C(n797), .Y(n819) );
  OAI22X1 U872 ( .A(n226), .B(n537), .C(n1065), .D(n798), .Y(n821) );
  NOR2X1 U873 ( .A(n228), .B(n307), .Y(n820) );
  OAI22X1 U874 ( .A(n1077), .B(n799), .C(n822), .D(n212), .Y(n817) );
  AOI22X1 U875 ( .A(\mem[1][4] ), .B(n801), .C(n279), .D(n669), .Y(n822) );
  OAI21X1 U876 ( .A(n207), .B(n308), .C(n823), .Y(n1040) );
  OAI21X1 U877 ( .A(n824), .B(n825), .C(n208), .Y(n823) );
  OAI21X1 U878 ( .A(n238), .B(n1058), .C(n826), .Y(n825) );
  OAI21X1 U879 ( .A(n827), .B(n828), .C(n797), .Y(n826) );
  OAI22X1 U880 ( .A(n226), .B(n556), .C(n1070), .D(n798), .Y(n828) );
  NOR2X1 U881 ( .A(n228), .B(n308), .Y(n827) );
  OAI22X1 U882 ( .A(n1078), .B(n799), .C(n829), .D(n212), .Y(n824) );
  AOI22X1 U883 ( .A(\mem[1][3] ), .B(n801), .C(n279), .D(n677), .Y(n829) );
  OAI21X1 U884 ( .A(n207), .B(n309), .C(n830), .Y(n1041) );
  OAI21X1 U885 ( .A(n831), .B(n832), .C(n208), .Y(n830) );
  OAI21X1 U886 ( .A(n238), .B(n1059), .C(n833), .Y(n832) );
  OAI21X1 U887 ( .A(n834), .B(n835), .C(n797), .Y(n833) );
  OAI22X1 U888 ( .A(n226), .B(n562), .C(n1071), .D(n798), .Y(n835) );
  NOR2X1 U889 ( .A(n228), .B(n309), .Y(n834) );
  OAI22X1 U890 ( .A(n1079), .B(n799), .C(n836), .D(n212), .Y(n831) );
  AOI22X1 U891 ( .A(\mem[1][2] ), .B(n801), .C(n279), .D(n685), .Y(n836) );
  OAI21X1 U892 ( .A(n207), .B(n310), .C(n837), .Y(n1042) );
  OAI21X1 U893 ( .A(n838), .B(n839), .C(n209), .Y(n837) );
  OAI21X1 U894 ( .A(n238), .B(n1060), .C(n840), .Y(n839) );
  OAI21X1 U895 ( .A(n841), .B(n842), .C(n797), .Y(n840) );
  OAI22X1 U896 ( .A(n226), .B(n563), .C(n1072), .D(n798), .Y(n842) );
  NOR2X1 U897 ( .A(n228), .B(n310), .Y(n841) );
  OAI22X1 U898 ( .A(n1080), .B(n799), .C(n843), .D(n212), .Y(n838) );
  AOI22X1 U899 ( .A(\mem[1][1] ), .B(n801), .C(n279), .D(n693), .Y(n843) );
  OAI21X1 U900 ( .A(n207), .B(n311), .C(n844), .Y(n1043) );
  OAI21X1 U901 ( .A(n845), .B(n846), .C(n208), .Y(n844) );
  OAI21X1 U902 ( .A(n238), .B(n1061), .C(n847), .Y(n846) );
  OAI21X1 U903 ( .A(n848), .B(n849), .C(n797), .Y(n847) );
  OAI22X1 U904 ( .A(n226), .B(n567), .C(n1073), .D(n798), .Y(n849) );
  NAND2X1 U905 ( .A(n275), .B(n700), .Y(n798) );
  OAI21X1 U906 ( .A(n703), .B(n851), .C(n852), .Y(n850) );
  NAND3X1 U907 ( .A(n853), .B(n854), .C(n227), .Y(n852) );
  NOR2X1 U908 ( .A(n228), .B(n311), .Y(n848) );
  OAI21X1 U909 ( .A(n275), .B(n709), .C(n857), .Y(n856) );
  NAND3X1 U910 ( .A(n854), .B(n855), .C(n853), .Y(n857) );
  NAND3X1 U911 ( .A(n711), .B(n235), .C(n287), .Y(n855) );
  OAI21X1 U912 ( .A(n703), .B(n797), .C(n859), .Y(n858) );
  NAND3X1 U913 ( .A(n853), .B(n797), .C(n239), .Y(n859) );
  NAND3X1 U914 ( .A(n714), .B(n205), .C(n203), .Y(n854) );
  NOR2X1 U915 ( .A(n715), .B(n275), .Y(n853) );
  NAND3X1 U916 ( .A(n716), .B(n284), .C(n287), .Y(n851) );
  OAI22X1 U917 ( .A(n1081), .B(n799), .C(n860), .D(n212), .Y(n845) );
  AOI22X1 U918 ( .A(\mem[1][0] ), .B(n801), .C(n279), .D(n718), .Y(n860) );
  NAND2X1 U919 ( .A(n279), .B(n719), .Y(n801) );
  NAND2X1 U920 ( .A(n279), .B(n700), .Y(n799) );
  NAND3X1 U921 ( .A(n203), .B(n286), .C(n720), .Y(n797) );
  OAI21X1 U922 ( .A(n207), .B(n312), .C(n861), .Y(n1044) );
  OAI21X1 U923 ( .A(n862), .B(n863), .C(n208), .Y(n861) );
  OAI21X1 U924 ( .A(n236), .B(n568), .C(n864), .Y(n863) );
  OAI21X1 U925 ( .A(n865), .B(n866), .C(n867), .Y(n864) );
  OAI22X1 U926 ( .A(n223), .B(n525), .C(n1062), .D(n868), .Y(n866) );
  NOR2X1 U927 ( .A(n225), .B(n312), .Y(n865) );
  OAI22X1 U928 ( .A(n1074), .B(n869), .C(n870), .D(n211), .Y(n862) );
  AOI22X1 U929 ( .A(\mem[0][7] ), .B(n871), .C(n278), .D(n645), .Y(n870) );
  NAND2X1 U930 ( .A(n872), .B(n873), .Y(n645) );
  AOI22X1 U931 ( .A(n267), .B(hwdata[31]), .C(n266), .D(hwdata[23]), .Y(n873)
         );
  AOI22X1 U932 ( .A(n264), .B(hwdata[15]), .C(n265), .D(hwdata[7]), .Y(n872)
         );
  OAI21X1 U933 ( .A(n208), .B(n313), .C(n874), .Y(n1045) );
  OAI21X1 U934 ( .A(n875), .B(n876), .C(n209), .Y(n874) );
  OAI21X1 U935 ( .A(n236), .B(n1055), .C(n877), .Y(n876) );
  OAI21X1 U936 ( .A(n878), .B(n879), .C(n867), .Y(n877) );
  OAI22X1 U937 ( .A(n223), .B(n529), .C(n1063), .D(n868), .Y(n879) );
  NOR2X1 U938 ( .A(n225), .B(n313), .Y(n878) );
  OAI22X1 U939 ( .A(n1075), .B(n869), .C(n880), .D(n211), .Y(n875) );
  AOI22X1 U940 ( .A(\mem[0][6] ), .B(n871), .C(n278), .D(n653), .Y(n880) );
  NAND2X1 U941 ( .A(n881), .B(n882), .Y(n653) );
  AOI22X1 U942 ( .A(n267), .B(hwdata[30]), .C(n266), .D(hwdata[22]), .Y(n882)
         );
  AOI22X1 U943 ( .A(n264), .B(hwdata[14]), .C(n265), .D(hwdata[6]), .Y(n881)
         );
  OAI21X1 U944 ( .A(n208), .B(n314), .C(n883), .Y(n1046) );
  OAI21X1 U945 ( .A(n884), .B(n885), .C(n209), .Y(n883) );
  OAI21X1 U946 ( .A(n236), .B(n1056), .C(n886), .Y(n885) );
  OAI21X1 U947 ( .A(n887), .B(n888), .C(n867), .Y(n886) );
  OAI22X1 U948 ( .A(n223), .B(n533), .C(n1064), .D(n868), .Y(n888) );
  NOR2X1 U949 ( .A(n225), .B(n314), .Y(n887) );
  OAI22X1 U950 ( .A(n1076), .B(n869), .C(n889), .D(n211), .Y(n884) );
  AOI22X1 U951 ( .A(\mem[0][5] ), .B(n871), .C(n278), .D(n661), .Y(n889) );
  NAND2X1 U952 ( .A(n890), .B(n891), .Y(n661) );
  AOI22X1 U953 ( .A(n267), .B(hwdata[29]), .C(n266), .D(hwdata[21]), .Y(n891)
         );
  AOI22X1 U954 ( .A(n264), .B(hwdata[13]), .C(n265), .D(hwdata[5]), .Y(n890)
         );
  OAI21X1 U955 ( .A(n207), .B(n315), .C(n892), .Y(n1047) );
  OAI21X1 U956 ( .A(n893), .B(n894), .C(n209), .Y(n892) );
  OAI21X1 U957 ( .A(n236), .B(n1057), .C(n895), .Y(n894) );
  OAI21X1 U958 ( .A(n896), .B(n897), .C(n867), .Y(n895) );
  OAI22X1 U959 ( .A(n223), .B(n537), .C(n1065), .D(n868), .Y(n897) );
  NOR2X1 U960 ( .A(n225), .B(n315), .Y(n896) );
  OAI22X1 U961 ( .A(n1077), .B(n869), .C(n898), .D(n211), .Y(n893) );
  AOI22X1 U962 ( .A(\mem[0][4] ), .B(n871), .C(n278), .D(n669), .Y(n898) );
  NAND2X1 U963 ( .A(n899), .B(n900), .Y(n669) );
  AOI22X1 U964 ( .A(n267), .B(hwdata[28]), .C(n266), .D(hwdata[20]), .Y(n900)
         );
  AOI22X1 U965 ( .A(n264), .B(hwdata[12]), .C(n265), .D(hwdata[4]), .Y(n899)
         );
  OAI21X1 U966 ( .A(n208), .B(n316), .C(n901), .Y(n1048) );
  OAI21X1 U967 ( .A(n902), .B(n903), .C(n209), .Y(n901) );
  OAI21X1 U968 ( .A(n236), .B(n1058), .C(n904), .Y(n903) );
  OAI21X1 U969 ( .A(n905), .B(n906), .C(n867), .Y(n904) );
  OAI22X1 U970 ( .A(n223), .B(n556), .C(n1070), .D(n868), .Y(n906) );
  NOR2X1 U971 ( .A(n225), .B(n316), .Y(n905) );
  OAI22X1 U972 ( .A(n1078), .B(n869), .C(n907), .D(n211), .Y(n902) );
  AOI22X1 U973 ( .A(\mem[0][3] ), .B(n871), .C(n278), .D(n677), .Y(n907) );
  NAND2X1 U974 ( .A(n908), .B(n909), .Y(n677) );
  AOI22X1 U975 ( .A(n267), .B(hwdata[27]), .C(n266), .D(hwdata[19]), .Y(n909)
         );
  AOI22X1 U976 ( .A(n264), .B(hwdata[11]), .C(n265), .D(hwdata[3]), .Y(n908)
         );
  OAI21X1 U977 ( .A(n208), .B(n317), .C(n910), .Y(n1049) );
  OAI21X1 U978 ( .A(n911), .B(n912), .C(n209), .Y(n910) );
  OAI21X1 U979 ( .A(n236), .B(n1059), .C(n913), .Y(n912) );
  OAI21X1 U980 ( .A(n914), .B(n915), .C(n867), .Y(n913) );
  OAI22X1 U981 ( .A(n223), .B(n562), .C(n1071), .D(n868), .Y(n915) );
  NOR2X1 U982 ( .A(n225), .B(n317), .Y(n914) );
  OAI22X1 U983 ( .A(n1079), .B(n869), .C(n916), .D(n211), .Y(n911) );
  AOI22X1 U984 ( .A(\mem[0][2] ), .B(n871), .C(n278), .D(n685), .Y(n916) );
  NAND2X1 U985 ( .A(n917), .B(n918), .Y(n685) );
  AOI22X1 U986 ( .A(n267), .B(hwdata[26]), .C(n266), .D(hwdata[18]), .Y(n918)
         );
  AOI22X1 U987 ( .A(n264), .B(hwdata[10]), .C(n265), .D(hwdata[2]), .Y(n917)
         );
  OAI21X1 U988 ( .A(n208), .B(n318), .C(n919), .Y(n1050) );
  OAI21X1 U989 ( .A(n920), .B(n921), .C(n210), .Y(n919) );
  OAI21X1 U990 ( .A(n236), .B(n1060), .C(n922), .Y(n921) );
  OAI21X1 U991 ( .A(n923), .B(n924), .C(n867), .Y(n922) );
  OAI22X1 U992 ( .A(n223), .B(n563), .C(n1072), .D(n868), .Y(n924) );
  NOR2X1 U993 ( .A(n225), .B(n318), .Y(n923) );
  OAI22X1 U994 ( .A(n1080), .B(n869), .C(n925), .D(n211), .Y(n920) );
  AOI22X1 U995 ( .A(\mem[0][1] ), .B(n871), .C(n278), .D(n693), .Y(n925) );
  NAND2X1 U996 ( .A(n926), .B(n927), .Y(n693) );
  AOI22X1 U997 ( .A(n267), .B(hwdata[25]), .C(n266), .D(hwdata[17]), .Y(n927)
         );
  AOI22X1 U998 ( .A(n264), .B(hwdata[9]), .C(n265), .D(hwdata[1]), .Y(n926) );
  OAI21X1 U999 ( .A(n208), .B(n319), .C(n928), .Y(n1051) );
  OAI21X1 U1000 ( .A(n929), .B(n930), .C(n210), .Y(n928) );
  OAI21X1 U1001 ( .A(n236), .B(n1061), .C(n931), .Y(n930) );
  OAI21X1 U1002 ( .A(n932), .B(n933), .C(n867), .Y(n931) );
  OAI22X1 U1003 ( .A(n223), .B(n567), .C(n1073), .D(n868), .Y(n933) );
  NAND2X1 U1004 ( .A(n274), .B(n700), .Y(n868) );
  OAI21X1 U1005 ( .A(n703), .B(n935), .C(n936), .Y(n934) );
  NAND3X1 U1006 ( .A(n937), .B(n938), .C(n224), .Y(n936) );
  NOR2X1 U1007 ( .A(n225), .B(n319), .Y(n932) );
  OAI21X1 U1008 ( .A(n274), .B(n709), .C(n941), .Y(n940) );
  NAND3X1 U1009 ( .A(n938), .B(n939), .C(n937), .Y(n941) );
  NAND3X1 U1010 ( .A(n203), .B(n235), .C(n711), .Y(n939) );
  NOR2X1 U1011 ( .A(N993), .B(n942), .Y(n711) );
  OR2X1 U1012 ( .A(N995), .B(N994), .Y(n942) );
  OAI21X1 U1013 ( .A(n703), .B(n867), .C(n944), .Y(n943) );
  NAND3X1 U1014 ( .A(n937), .B(n867), .C(n237), .Y(n944) );
  NAND3X1 U1015 ( .A(n287), .B(n205), .C(n714), .Y(n938) );
  NOR2X1 U1016 ( .A(N1038), .B(n945), .Y(n714) );
  OR2X1 U1017 ( .A(N1040), .B(N1039), .Y(n945) );
  NOR2X1 U1018 ( .A(n715), .B(n274), .Y(n937) );
  NAND3X1 U1019 ( .A(n203), .B(n284), .C(n716), .Y(n935) );
  NOR2X1 U1020 ( .A(N788), .B(n946), .Y(n716) );
  OR2X1 U1021 ( .A(N790), .B(N789), .Y(n946) );
  OR2X1 U1022 ( .A(n709), .B(n272), .Y(n703) );
  OAI22X1 U1023 ( .A(n1081), .B(n869), .C(n947), .D(n211), .Y(n929) );
  AOI22X1 U1024 ( .A(\mem[0][0] ), .B(n871), .C(n278), .D(n718), .Y(n947) );
  NAND2X1 U1025 ( .A(n948), .B(n949), .Y(n718) );
  AOI22X1 U1026 ( .A(n267), .B(hwdata[24]), .C(n266), .D(hwdata[16]), .Y(n949)
         );
  AOI22X1 U1027 ( .A(n264), .B(hwdata[8]), .C(n265), .D(hwdata[0]), .Y(n948)
         );
  NAND2X1 U1028 ( .A(n278), .B(n719), .Y(n871) );
  NAND3X1 U1029 ( .A(n951), .B(n950), .C(n952), .Y(n719) );
  NOR2X1 U1030 ( .A(n266), .B(n267), .Y(n952) );
  NAND3X1 U1031 ( .A(haddr_f[0]), .B(haddr_f[1]), .C(n268), .Y(n953) );
  NAND3X1 U1032 ( .A(haddr_f[1]), .B(n273), .C(n268), .Y(n954) );
  NAND3X1 U1033 ( .A(n273), .B(n272), .C(n268), .Y(n950) );
  NAND3X1 U1034 ( .A(haddr_f[0]), .B(n272), .C(n268), .Y(n951) );
  NAND2X1 U1035 ( .A(n278), .B(n700), .Y(n869) );
  OAI21X1 U1036 ( .A(haddr_f[1]), .B(n709), .C(n715), .Y(n700) );
  NAND3X1 U1037 ( .A(n287), .B(n286), .C(n720), .Y(n867) );
  NOR2X1 U1038 ( .A(write_select[2]), .B(write_select[3]), .Y(n720) );
  OAI21X1 U1039 ( .A(n955), .B(n253), .C(n956), .Y(n633) );
  NAND3X1 U1040 ( .A(n627), .B(n433), .C(n628), .Y(n956) );
  NOR2X1 U1041 ( .A(n212), .B(n431), .Y(n628) );
  NAND3X1 U1043 ( .A(n273), .B(n272), .C(n957), .Y(n433) );
  NAND3X1 U1044 ( .A(n957), .B(n272), .C(haddr_f[0]), .Y(n627) );
  AOI21X1 U1045 ( .A(n715), .B(n709), .C(n431), .Y(n958) );
  NAND3X1 U1046 ( .A(hwrite_f), .B(htrans_f[1]), .C(n959), .Y(n431) );
  NOR2X1 U1047 ( .A(htrans_f[0]), .B(n462), .Y(n959) );
  NAND2X1 U1048 ( .A(hsize_f[0]), .B(n256), .Y(n709) );
  NAND2X1 U1049 ( .A(hsize_f[1]), .B(n257), .Y(n715) );
  OAI21X1 U1050 ( .A(n287), .B(n960), .C(n961), .Y(n1052) );
  NAND3X1 U1051 ( .A(haddr[0]), .B(n500), .C(n960), .Y(n961) );
  OAI21X1 U1052 ( .A(n286), .B(n960), .C(n962), .Y(n1053) );
  NAND3X1 U1053 ( .A(haddr[1]), .B(n440), .C(n960), .Y(n962) );
  NAND2X1 U1054 ( .A(n375), .B(n376), .Y(n440) );
  NAND2X1 U1055 ( .A(n514), .B(n503), .Y(n376) );
  NAND2X1 U1056 ( .A(hsize[0]), .B(n503), .Y(n375) );
  OAI22X1 U1057 ( .A(n488), .B(n459), .C(n960), .D(n283), .Y(n1054) );
  AOI22X1 U1058 ( .A(haddr[3]), .B(n960), .C(n459), .D(write_select[3]), .Y(
        n963) );
  NOR2X1 U1059 ( .A(n964), .B(n462), .Y(n960) );
  NOR2X1 U1060 ( .A(rx_packet[3]), .B(n965), .Y(n1066) );
  NOR2X1 U1061 ( .A(rx_packet[3]), .B(n966), .Y(n1067) );
  NOR2X1 U1062 ( .A(n965), .B(n248), .Y(n1068) );
  NAND3X1 U1063 ( .A(n246), .B(n247), .C(rx_packet[0]), .Y(n965) );
  NOR2X1 U1064 ( .A(n966), .B(n248), .Y(n1069) );
  NAND3X1 U1065 ( .A(n245), .B(n247), .C(rx_packet[1]), .Y(n966) );
  OAI21X1 U1066 ( .A(n968), .B(n964), .C(hsel), .Y(n967) );
  NOR2X1 U1067 ( .A(n969), .B(n970), .Y(hready) );
  OAI21X1 U1068 ( .A(n968), .B(n971), .C(n972), .Y(n970) );
  OAI21X1 U1069 ( .A(nxt_write_data_state[0]), .B(n973), .C(n392), .Y(n972) );
  OAI21X1 U1070 ( .A(n349), .B(n392), .C(n974), .Y(nxt_write_data_state[0]) );
  AOI21X1 U1071 ( .A(n346), .B(n383), .C(n975), .Y(n974) );
  AOI21X1 U1072 ( .A(n389), .B(n973), .C(n388), .Y(n975) );
  NOR2X1 U1073 ( .A(n386), .B(write_tx[1]), .Y(n388) );
  NAND2X1 U1074 ( .A(n353), .B(n344), .Y(n386) );
  NAND3X1 U1075 ( .A(n354), .B(n353), .C(write_tx[0]), .Y(n383) );
  NAND3X1 U1076 ( .A(n394), .B(n347), .C(n973), .Y(n392) );
  NAND3X1 U1077 ( .A(n352), .B(n355), .C(n349), .Y(n973) );
  NAND3X1 U1078 ( .A(n385), .B(n382), .C(n976), .Y(store_tx_data) );
  NOR2X1 U1079 ( .A(n348), .B(n350), .Y(n976) );
  NAND3X1 U1080 ( .A(write_data_state[0]), .B(n352), .C(write_data_state[2]), 
        .Y(n387) );
  NAND3X1 U1081 ( .A(n349), .B(n352), .C(write_data_state[2]), .Y(n389) );
  NAND3X1 U1082 ( .A(n349), .B(n355), .C(write_data_state[1]), .Y(n382) );
  NAND3X1 U1083 ( .A(write_data_state[0]), .B(n355), .C(write_data_state[1]), 
        .Y(n385) );
  NAND3X1 U1084 ( .A(n352), .B(n355), .C(write_data_state[0]), .Y(n394) );
  NAND2X1 U1085 ( .A(hsel), .B(n964), .Y(n971) );
  OAI21X1 U1086 ( .A(n503), .B(n514), .C(n977), .Y(n964) );
  AOI22X1 U1087 ( .A(n978), .B(hwrite), .C(haddr[3]), .D(n979), .Y(n977) );
  OAI21X1 U1088 ( .A(haddr[2]), .B(n494), .C(n491), .Y(n979) );
  NOR2X1 U1089 ( .A(n377), .B(n610), .Y(n978) );
  NOR2X1 U1090 ( .A(haddr[2]), .B(haddr[3]), .Y(n377) );
  OAI21X1 U1091 ( .A(n256), .B(n257), .C(n980), .Y(n968) );
  AOI22X1 U1092 ( .A(n981), .B(hwrite_f), .C(haddr_f[3]), .D(n982), .Y(n980)
         );
  OAI21X1 U1093 ( .A(haddr_f[2]), .B(n273), .C(n272), .Y(n982) );
  NOR2X1 U1094 ( .A(n268), .B(n957), .Y(n981) );
  NOR2X1 U1095 ( .A(n270), .B(n271), .Y(n957) );
  NAND2X1 U1096 ( .A(n271), .B(n270), .Y(n955) );
  AOI21X1 U1097 ( .A(n983), .B(n324), .C(n984), .Y(n969) );
  AOI21X1 U1098 ( .A(n985), .B(nxt_read_state[1]), .C(n983), .Y(n984) );
  NOR2X1 U1099 ( .A(nxt_read_state[2]), .B(nxt_read_state[0]), .Y(n985) );
  NAND3X1 U1100 ( .A(n330), .B(n326), .C(n331), .Y(n983) );
  NAND3X1 U1101 ( .A(n441), .B(n439), .C(n986), .Y(get_rx_data) );
  NOR2X1 U1102 ( .A(n328), .B(n327), .Y(n986) );
  NAND3X1 U1103 ( .A(n331), .B(n330), .C(read_state[2]), .Y(n509) );
  NAND3X1 U1104 ( .A(read_state[0]), .B(n330), .C(read_state[2]), .Y(n442) );
  NAND3X1 U1105 ( .A(n331), .B(n326), .C(read_state[1]), .Y(n439) );
  NAND3X1 U1106 ( .A(read_state[0]), .B(n326), .C(read_state[1]), .Y(n441) );
  XNOR2X1 U1107 ( .A(n286), .B(n202), .Y(N176) );
  NAND3X1 U1108 ( .A(n342), .B(n340), .C(read_rx[1]), .Y(N1457) );
  NAND3X1 U1109 ( .A(n341), .B(n340), .C(read_rx[0]), .Y(N1453) );
  NAND3X1 U1110 ( .A(n341), .B(n340), .C(n342), .Y(N1450) );
  falling_edge_detect falling_edge_detect_tx_transfer_active ( .clk(clk), 
        .n_rst(n222), .dplus_sync(tx_transfer_active), .d_edge(
        tx_transfer_active_falling_edge) );
  HAX1 \r426/U1_1_1  ( .A(n205), .B(n202), .YC(\r426/carry[2] ), .YS(N787) );
  HAX1 \r426/U1_1_2  ( .A(write_select[2]), .B(\r426/carry[2] ), .YC(
        \r426/carry[3] ), .YS(N788) );
  HAX1 \r426/U1_1_3  ( .A(write_select[3]), .B(\r426/carry[3] ), .YC(N790), 
        .YS(N789) );
  INVX2 U6 ( .A(n472), .Y(n262) );
  INVX2 U7 ( .A(n867), .Y(n278) );
  INVX2 U17 ( .A(n797), .Y(n279) );
  INVX2 U18 ( .A(n727), .Y(n280) );
  INVX2 U19 ( .A(n640), .Y(n281) );
  BUFX2 U24 ( .A(n633), .Y(n206) );
  BUFX2 U78 ( .A(n633), .Y(n207) );
  BUFX2 U79 ( .A(n633), .Y(n209) );
  BUFX2 U80 ( .A(n633), .Y(n208) );
  BUFX2 U81 ( .A(n633), .Y(n210) );
  INVX2 U82 ( .A(n1), .Y(n212) );
  INVX2 U83 ( .A(n1), .Y(n211) );
  INVX2 U84 ( .A(n389), .Y(n348) );
  INVX2 U86 ( .A(n387), .Y(n350) );
  INVX2 U87 ( .A(n442), .Y(n328) );
  INVX2 U88 ( .A(n509), .Y(n327) );
  INVX2 U89 ( .A(n201), .Y(n203) );
  INVX2 U90 ( .A(n201), .Y(n202) );
  INVX2 U91 ( .A(n204), .Y(n205) );
  INVX2 U92 ( .A(n382), .Y(n346) );
  INVX2 U93 ( .A(n474), .Y(n260) );
  INVX2 U94 ( .A(n439), .Y(n325) );
  INVX2 U95 ( .A(n385), .Y(n351) );
  AND2X2 U96 ( .A(n257), .B(n256), .Y(n1) );
  INVX2 U97 ( .A(N1036), .Y(n201) );
  INVX2 U98 ( .A(N174), .Y(n204) );
  INVX2 U99 ( .A(n954), .Y(n266) );
  INVX2 U100 ( .A(n953), .Y(n267) );
  BUFX2 U101 ( .A(n_rst), .Y(n221) );
  BUFX2 U102 ( .A(n_rst), .Y(n220) );
  BUFX2 U103 ( .A(n_rst), .Y(n219) );
  BUFX2 U104 ( .A(n_rst), .Y(n218) );
  BUFX2 U105 ( .A(n_rst), .Y(n217) );
  BUFX2 U106 ( .A(n_rst), .Y(n216) );
  BUFX2 U107 ( .A(n_rst), .Y(n215) );
  BUFX2 U108 ( .A(n_rst), .Y(n214) );
  BUFX2 U114 ( .A(n_rst), .Y(n213) );
  BUFX2 U115 ( .A(n_rst), .Y(n222) );
  NOR2X1 U116 ( .A(n286), .B(n202), .Y(n17) );
  NOR2X1 U119 ( .A(n204), .B(n287), .Y(n16) );
  AOI22X1 U120 ( .A(\mem[2][0] ), .B(n17), .C(\mem[3][0] ), .D(n16), .Y(n3) );
  NOR2X1 U121 ( .A(n202), .B(N174), .Y(n19) );
  NOR2X1 U122 ( .A(n287), .B(N174), .Y(n18) );
  AOI22X1 U123 ( .A(\mem[0][0] ), .B(n19), .C(\mem[1][0] ), .D(n18), .Y(n2) );
  NAND2X1 U124 ( .A(n3), .B(n2), .Y(N499) );
  AOI22X1 U125 ( .A(\mem[2][1] ), .B(n17), .C(\mem[3][1] ), .D(n16), .Y(n5) );
  AOI22X1 U126 ( .A(\mem[0][1] ), .B(n19), .C(\mem[1][1] ), .D(n18), .Y(n4) );
  NAND2X1 U127 ( .A(n5), .B(n4), .Y(N498) );
  AOI22X1 U128 ( .A(\mem[2][2] ), .B(n17), .C(\mem[3][2] ), .D(n16), .Y(n7) );
  AOI22X1 U129 ( .A(\mem[0][2] ), .B(n19), .C(\mem[1][2] ), .D(n18), .Y(n6) );
  NAND2X1 U130 ( .A(n7), .B(n6), .Y(N497) );
  AOI22X1 U131 ( .A(\mem[2][3] ), .B(n17), .C(\mem[3][3] ), .D(n16), .Y(n9) );
  AOI22X1 U132 ( .A(\mem[0][3] ), .B(n19), .C(\mem[1][3] ), .D(n18), .Y(n8) );
  NAND2X1 U133 ( .A(n9), .B(n8), .Y(N496) );
  AOI22X1 U134 ( .A(\mem[2][4] ), .B(n17), .C(\mem[3][4] ), .D(n16), .Y(n11)
         );
  AOI22X1 U135 ( .A(\mem[0][4] ), .B(n19), .C(\mem[1][4] ), .D(n18), .Y(n10)
         );
  NAND2X1 U136 ( .A(n11), .B(n10), .Y(N495) );
  AOI22X1 U137 ( .A(\mem[2][5] ), .B(n17), .C(\mem[3][5] ), .D(n16), .Y(n13)
         );
  AOI22X1 U138 ( .A(\mem[0][5] ), .B(n19), .C(\mem[1][5] ), .D(n18), .Y(n12)
         );
  NAND2X1 U139 ( .A(n13), .B(n12), .Y(N494) );
  AOI22X1 U140 ( .A(\mem[2][6] ), .B(n17), .C(\mem[3][6] ), .D(n16), .Y(n15)
         );
  AOI22X1 U197 ( .A(\mem[0][6] ), .B(n19), .C(\mem[1][6] ), .D(n18), .Y(n14)
         );
  NAND2X1 U198 ( .A(n15), .B(n14), .Y(N493) );
  AOI22X1 U199 ( .A(\mem[2][7] ), .B(n17), .C(\mem[3][7] ), .D(n16), .Y(n21)
         );
  AOI22X1 U200 ( .A(\mem[0][7] ), .B(n19), .C(\mem[1][7] ), .D(n18), .Y(n20)
         );
  NAND2X1 U201 ( .A(n21), .B(n20), .Y(N492) );
  NOR2X1 U202 ( .A(n285), .B(n287), .Y(n37) );
  NOR2X1 U203 ( .A(n285), .B(n50), .Y(n36) );
  AOI22X1 U204 ( .A(\mem[2][0] ), .B(n37), .C(\mem[3][0] ), .D(n36), .Y(n23)
         );
  NOR2X1 U205 ( .A(n287), .B(N176), .Y(n39) );
  NOR2X1 U206 ( .A(n50), .B(N176), .Y(n38) );
  AOI22X1 U207 ( .A(\mem[0][0] ), .B(n39), .C(\mem[1][0] ), .D(n38), .Y(n22)
         );
  NAND2X1 U208 ( .A(n23), .B(n22), .Y(N509) );
  AOI22X1 U209 ( .A(\mem[2][1] ), .B(n37), .C(\mem[3][1] ), .D(n36), .Y(n25)
         );
  AOI22X1 U210 ( .A(\mem[0][1] ), .B(n39), .C(\mem[1][1] ), .D(n38), .Y(n24)
         );
  NAND2X1 U211 ( .A(n25), .B(n24), .Y(N508) );
  AOI22X1 U212 ( .A(\mem[2][2] ), .B(n37), .C(\mem[3][2] ), .D(n36), .Y(n27)
         );
  AOI22X1 U213 ( .A(\mem[0][2] ), .B(n39), .C(\mem[1][2] ), .D(n38), .Y(n26)
         );
  NAND2X1 U214 ( .A(n27), .B(n26), .Y(N507) );
  AOI22X1 U215 ( .A(\mem[2][3] ), .B(n37), .C(\mem[3][3] ), .D(n36), .Y(n29)
         );
  AOI22X1 U216 ( .A(\mem[0][3] ), .B(n39), .C(\mem[1][3] ), .D(n38), .Y(n28)
         );
  NAND2X1 U217 ( .A(n29), .B(n28), .Y(N506) );
  AOI22X1 U218 ( .A(\mem[2][4] ), .B(n37), .C(\mem[3][4] ), .D(n36), .Y(n31)
         );
  AOI22X1 U219 ( .A(\mem[0][4] ), .B(n39), .C(\mem[1][4] ), .D(n38), .Y(n30)
         );
  NAND2X1 U220 ( .A(n31), .B(n30), .Y(N505) );
  AOI22X1 U221 ( .A(\mem[2][5] ), .B(n37), .C(\mem[3][5] ), .D(n36), .Y(n33)
         );
  AOI22X1 U222 ( .A(\mem[0][5] ), .B(n39), .C(\mem[1][5] ), .D(n38), .Y(n32)
         );
  NAND2X1 U223 ( .A(n33), .B(n32), .Y(N504) );
  AOI22X1 U224 ( .A(\mem[2][6] ), .B(n37), .C(\mem[3][6] ), .D(n36), .Y(n35)
         );
  AOI22X1 U225 ( .A(\mem[0][6] ), .B(n39), .C(\mem[1][6] ), .D(n38), .Y(n34)
         );
  NAND2X1 U226 ( .A(n35), .B(n34), .Y(N503) );
  AOI22X1 U227 ( .A(\mem[2][7] ), .B(n37), .C(\mem[3][7] ), .D(n36), .Y(n49)
         );
  AOI22X1 U228 ( .A(\mem[0][7] ), .B(n39), .C(\mem[1][7] ), .D(n38), .Y(n40)
         );
  NAND2X1 U229 ( .A(n49), .B(n40), .Y(N502) );
  INVX2 U230 ( .A(n287), .Y(n50) );
  NOR2X1 U231 ( .A(n205), .B(n202), .Y(n176) );
  NOR2X1 U232 ( .A(n205), .B(n287), .Y(n175) );
  AOI22X1 U233 ( .A(\mem[2][0] ), .B(n176), .C(\mem[3][0] ), .D(n175), .Y(n162) );
  NOR2X1 U234 ( .A(n202), .B(n286), .Y(n178) );
  NOR2X1 U235 ( .A(n287), .B(n286), .Y(n177) );
  AOI22X1 U236 ( .A(\mem[0][0] ), .B(n178), .C(\mem[1][0] ), .D(n177), .Y(n51)
         );
  NAND2X1 U237 ( .A(n162), .B(n51), .Y(N519) );
  AOI22X1 U238 ( .A(\mem[2][1] ), .B(n176), .C(\mem[3][1] ), .D(n175), .Y(n164) );
  AOI22X1 U239 ( .A(\mem[0][1] ), .B(n178), .C(\mem[1][1] ), .D(n177), .Y(n163) );
  NAND2X1 U240 ( .A(n164), .B(n163), .Y(N518) );
  AOI22X1 U241 ( .A(\mem[2][2] ), .B(n176), .C(\mem[3][2] ), .D(n175), .Y(n166) );
  AOI22X1 U242 ( .A(\mem[0][2] ), .B(n178), .C(\mem[1][2] ), .D(n177), .Y(n165) );
  NAND2X1 U243 ( .A(n166), .B(n165), .Y(N517) );
  AOI22X1 U244 ( .A(\mem[2][3] ), .B(n176), .C(\mem[3][3] ), .D(n175), .Y(n168) );
  AOI22X1 U245 ( .A(\mem[0][3] ), .B(n178), .C(\mem[1][3] ), .D(n177), .Y(n167) );
  NAND2X1 U246 ( .A(n168), .B(n167), .Y(N516) );
  AOI22X1 U247 ( .A(\mem[2][4] ), .B(n176), .C(\mem[3][4] ), .D(n175), .Y(n170) );
  AOI22X1 U248 ( .A(\mem[0][4] ), .B(n178), .C(\mem[1][4] ), .D(n177), .Y(n169) );
  NAND2X1 U249 ( .A(n170), .B(n169), .Y(N515) );
  AOI22X1 U250 ( .A(\mem[2][5] ), .B(n176), .C(\mem[3][5] ), .D(n175), .Y(n172) );
  AOI22X1 U251 ( .A(\mem[0][5] ), .B(n178), .C(\mem[1][5] ), .D(n177), .Y(n171) );
  NAND2X1 U252 ( .A(n172), .B(n171), .Y(N514) );
  AOI22X1 U253 ( .A(\mem[2][6] ), .B(n176), .C(\mem[3][6] ), .D(n175), .Y(n174) );
  AOI22X1 U254 ( .A(\mem[0][6] ), .B(n178), .C(\mem[1][6] ), .D(n177), .Y(n173) );
  NAND2X1 U255 ( .A(n174), .B(n173), .Y(N513) );
  AOI22X1 U256 ( .A(\mem[2][7] ), .B(n176), .C(\mem[3][7] ), .D(n175), .Y(n180) );
  AOI22X1 U257 ( .A(\mem[0][7] ), .B(n178), .C(\mem[1][7] ), .D(n177), .Y(n179) );
  NAND2X1 U258 ( .A(n180), .B(n179), .Y(N512) );
  NOR2X1 U259 ( .A(N176), .B(n287), .Y(n196) );
  NOR2X1 U260 ( .A(N176), .B(n203), .Y(n195) );
  AOI22X1 U261 ( .A(\mem[2][0] ), .B(n196), .C(\mem[3][0] ), .D(n195), .Y(n182) );
  NOR2X1 U262 ( .A(n287), .B(n285), .Y(n198) );
  NOR2X1 U263 ( .A(n203), .B(n285), .Y(n197) );
  AOI22X1 U264 ( .A(\mem[0][0] ), .B(n198), .C(\mem[1][0] ), .D(n197), .Y(n181) );
  NAND2X1 U265 ( .A(n182), .B(n181), .Y(N529) );
  AOI22X1 U266 ( .A(\mem[2][1] ), .B(n196), .C(\mem[3][1] ), .D(n195), .Y(n184) );
  AOI22X1 U267 ( .A(\mem[0][1] ), .B(n198), .C(\mem[1][1] ), .D(n197), .Y(n183) );
  NAND2X1 U268 ( .A(n184), .B(n183), .Y(N528) );
  AOI22X1 U269 ( .A(\mem[2][2] ), .B(n196), .C(\mem[3][2] ), .D(n195), .Y(n186) );
  AOI22X1 U270 ( .A(\mem[0][2] ), .B(n198), .C(\mem[1][2] ), .D(n197), .Y(n185) );
  NAND2X1 U271 ( .A(n186), .B(n185), .Y(N527) );
  AOI22X1 U272 ( .A(\mem[2][3] ), .B(n196), .C(\mem[3][3] ), .D(n195), .Y(n188) );
  AOI22X1 U273 ( .A(\mem[0][3] ), .B(n198), .C(\mem[1][3] ), .D(n197), .Y(n187) );
  NAND2X1 U274 ( .A(n188), .B(n187), .Y(N526) );
  AOI22X1 U275 ( .A(\mem[2][4] ), .B(n196), .C(\mem[3][4] ), .D(n195), .Y(n190) );
  AOI22X1 U276 ( .A(\mem[0][4] ), .B(n198), .C(\mem[1][4] ), .D(n197), .Y(n189) );
  NAND2X1 U277 ( .A(n190), .B(n189), .Y(N525) );
  AOI22X1 U278 ( .A(\mem[2][5] ), .B(n196), .C(\mem[3][5] ), .D(n195), .Y(n192) );
  AOI22X1 U279 ( .A(\mem[0][5] ), .B(n198), .C(\mem[1][5] ), .D(n197), .Y(n191) );
  NAND2X1 U280 ( .A(n192), .B(n191), .Y(N524) );
  AOI22X1 U281 ( .A(\mem[2][6] ), .B(n196), .C(\mem[3][6] ), .D(n195), .Y(n194) );
  AOI22X1 U282 ( .A(\mem[0][6] ), .B(n198), .C(\mem[1][6] ), .D(n197), .Y(n193) );
  NAND2X1 U283 ( .A(n194), .B(n193), .Y(N523) );
  AOI22X1 U284 ( .A(\mem[2][7] ), .B(n196), .C(\mem[3][7] ), .D(n195), .Y(n200) );
  AOI22X1 U285 ( .A(\mem[0][7] ), .B(n198), .C(\mem[1][7] ), .D(n197), .Y(n199) );
  NAND2X1 U286 ( .A(n200), .B(n199), .Y(N522) );
  AND2X1 U287 ( .A(write_select[3]), .B(\add_639/carry[3] ), .Y(N995) );
  XOR2X1 U288 ( .A(\add_639/carry[3] ), .B(write_select[3]), .Y(N994) );
  AND2X1 U289 ( .A(write_select[2]), .B(\add_639/carry[2] ), .Y(
        \add_639/carry[3] ) );
  XOR2X1 U290 ( .A(\add_639/carry[2] ), .B(write_select[2]), .Y(N993) );
  OR2X1 U291 ( .A(n203), .B(n205), .Y(\add_639/carry[2] ) );
  XNOR2X1 U292 ( .A(N174), .B(n202), .Y(N992) );
  AND2X1 U293 ( .A(write_select[3]), .B(\add_639_2/carry[3] ), .Y(N1040) );
  XOR2X1 U294 ( .A(\add_639_2/carry[3] ), .B(write_select[3]), .Y(N1039) );
  AND2X1 U295 ( .A(write_select[2]), .B(n205), .Y(\add_639_2/carry[3] ) );
  XOR2X1 U296 ( .A(N174), .B(write_select[2]), .Y(N1038) );
  INVX2 U297 ( .A(n934), .Y(n223) );
  INVX2 U298 ( .A(n939), .Y(n224) );
  INVX2 U299 ( .A(n940), .Y(n225) );
  INVX2 U300 ( .A(n850), .Y(n226) );
  INVX2 U301 ( .A(n855), .Y(n227) );
  INVX2 U302 ( .A(n856), .Y(n228) );
  INVX2 U303 ( .A(n780), .Y(n229) );
  INVX2 U304 ( .A(n785), .Y(n230) );
  INVX2 U305 ( .A(n786), .Y(n231) );
  INVX2 U306 ( .A(n701), .Y(n232) );
  INVX2 U307 ( .A(n707), .Y(n233) );
  INVX2 U308 ( .A(n708), .Y(n234) );
  INVX2 U309 ( .A(N992), .Y(n235) );
  INVX2 U310 ( .A(n943), .Y(n236) );
  INVX2 U311 ( .A(n938), .Y(n237) );
  INVX2 U312 ( .A(n858), .Y(n238) );
  INVX2 U313 ( .A(n854), .Y(n239) );
  INVX2 U314 ( .A(n788), .Y(n240) );
  INVX2 U315 ( .A(n784), .Y(n241) );
  INVX2 U316 ( .A(n712), .Y(n242) );
  INVX2 U317 ( .A(n706), .Y(n243) );
  INVX2 U318 ( .A(rx_transfer_active), .Y(d_mode) );
  INVX2 U319 ( .A(rx_packet[0]), .Y(n245) );
  INVX2 U320 ( .A(rx_packet[1]), .Y(n246) );
  INVX2 U321 ( .A(rx_packet[2]), .Y(n247) );
  INVX2 U322 ( .A(rx_packet[3]), .Y(n248) );
  INVX2 U323 ( .A(n404), .Y(n249) );
  INVX2 U324 ( .A(tx_transfer_active_falling_edge), .Y(n250) );
  INVX2 U325 ( .A(n399), .Y(n251) );
  INVX2 U326 ( .A(n624), .Y(n252) );
  INVX2 U327 ( .A(n958), .Y(n253) );
  INVX2 U328 ( .A(n628), .Y(n254) );
  INVX2 U329 ( .A(n967), .Y(hresp) );
  INVX2 U330 ( .A(hsize_f[1]), .Y(n256) );
  INVX2 U331 ( .A(hsize_f[0]), .Y(n257) );
  INVX2 U332 ( .A(n591), .Y(n258) );
  INVX2 U333 ( .A(n596), .Y(n259) );
  INVX2 U334 ( .A(n550), .Y(n261) );
  INVX2 U335 ( .A(hwrite_f), .Y(n263) );
  INVX2 U336 ( .A(n951), .Y(n264) );
  INVX2 U337 ( .A(n950), .Y(n265) );
  INVX2 U338 ( .A(n955), .Y(n268) );
  INVX2 U339 ( .A(n433), .Y(n269) );
  INVX2 U340 ( .A(haddr_f[3]), .Y(n270) );
  INVX2 U341 ( .A(haddr_f[2]), .Y(n271) );
  INVX2 U342 ( .A(haddr_f[1]), .Y(n272) );
  INVX2 U343 ( .A(haddr_f[0]), .Y(n273) );
  INVX2 U344 ( .A(n935), .Y(n274) );
  INVX2 U345 ( .A(n851), .Y(n275) );
  INVX2 U346 ( .A(n781), .Y(n276) );
  INVX2 U347 ( .A(n702), .Y(n277) );
  INVX2 U348 ( .A(n963), .Y(n282) );
  INVX2 U349 ( .A(write_select[2]), .Y(n283) );
  INVX2 U350 ( .A(N787), .Y(n284) );
  INVX2 U351 ( .A(N176), .Y(n285) );
  INVX2 U352 ( .A(n205), .Y(n286) );
  INVX2 U353 ( .A(n203), .Y(n287) );
  INVX2 U354 ( .A(\mem[3][7] ), .Y(n288) );
  INVX2 U355 ( .A(\mem[3][6] ), .Y(n289) );
  INVX2 U356 ( .A(\mem[3][5] ), .Y(n290) );
  INVX2 U357 ( .A(\mem[3][4] ), .Y(n291) );
  INVX2 U358 ( .A(\mem[3][3] ), .Y(n292) );
  INVX2 U359 ( .A(\mem[3][2] ), .Y(n293) );
  INVX2 U360 ( .A(\mem[3][1] ), .Y(n294) );
  INVX2 U361 ( .A(\mem[3][0] ), .Y(n295) );
  INVX2 U362 ( .A(\mem[2][7] ), .Y(n296) );
  INVX2 U363 ( .A(\mem[2][6] ), .Y(n297) );
  INVX2 U364 ( .A(\mem[2][5] ), .Y(n298) );
  INVX2 U365 ( .A(\mem[2][4] ), .Y(n299) );
  INVX2 U366 ( .A(\mem[2][3] ), .Y(n300) );
  INVX2 U367 ( .A(\mem[2][2] ), .Y(n301) );
  INVX2 U368 ( .A(\mem[2][1] ), .Y(n302) );
  INVX2 U369 ( .A(\mem[2][0] ), .Y(n303) );
  INVX2 U370 ( .A(\mem[1][7] ), .Y(n304) );
  INVX2 U371 ( .A(\mem[1][6] ), .Y(n305) );
  INVX2 U372 ( .A(\mem[1][5] ), .Y(n306) );
  INVX2 U373 ( .A(\mem[1][4] ), .Y(n307) );
  INVX2 U374 ( .A(\mem[1][3] ), .Y(n308) );
  INVX2 U375 ( .A(\mem[1][2] ), .Y(n309) );
  INVX2 U376 ( .A(\mem[1][1] ), .Y(n310) );
  INVX2 U377 ( .A(\mem[1][0] ), .Y(n311) );
  INVX2 U378 ( .A(\mem[0][7] ), .Y(n312) );
  INVX2 U379 ( .A(\mem[0][6] ), .Y(n313) );
  INVX2 U380 ( .A(\mem[0][5] ), .Y(n314) );
  INVX2 U381 ( .A(\mem[0][4] ), .Y(n315) );
  INVX2 U382 ( .A(\mem[0][3] ), .Y(n316) );
  INVX2 U383 ( .A(\mem[0][2] ), .Y(n317) );
  INVX2 U384 ( .A(\mem[0][1] ), .Y(n318) );
  INVX2 U385 ( .A(\mem[0][0] ), .Y(n319) );
  INVX2 U386 ( .A(stat[0]), .Y(n320) );
  INVX2 U387 ( .A(n564), .Y(n321) );
  INVX2 U388 ( .A(n569), .Y(n322) );
  INVX2 U389 ( .A(n441), .Y(n323) );
  INVX2 U390 ( .A(get_rx_data), .Y(n324) );
  INVX2 U473 ( .A(read_state[2]), .Y(n326) );
  INVX2 U476 ( .A(n41), .Y(n329) );
  INVX2 U477 ( .A(read_state[1]), .Y(n330) );
  INVX2 U480 ( .A(read_state[0]), .Y(n331) );
  INVX2 U481 ( .A(hrdata[8]), .Y(n332) );
  INVX2 U484 ( .A(hrdata[9]), .Y(n333) );
  INVX2 U485 ( .A(hrdata[10]), .Y(n334) );
  INVX2 U488 ( .A(hrdata[11]), .Y(n335) );
  INVX2 U489 ( .A(hrdata[12]), .Y(n336) );
  INVX2 U492 ( .A(hrdata[13]), .Y(n337) );
  INVX2 U493 ( .A(hrdata[14]), .Y(n338) );
  INVX2 U496 ( .A(hrdata[15]), .Y(n339) );
  INVX2 U497 ( .A(read_rx[2]), .Y(n340) );
  INVX2 U500 ( .A(read_rx[1]), .Y(n341) );
  INVX2 U501 ( .A(read_rx[0]), .Y(n342) );
  INVX2 U506 ( .A(hrdata[7]), .Y(n343) );
  INVX2 U507 ( .A(write_tx[0]), .Y(n344) );
  INVX2 U508 ( .A(n383), .Y(n345) );
  INVX2 U509 ( .A(store_tx_data), .Y(n347) );
  INVX2 U512 ( .A(write_data_state[0]), .Y(n349) );
  INVX2 U515 ( .A(write_data_state[1]), .Y(n352) );
  INVX2 U516 ( .A(write_tx[2]), .Y(n353) );
  INVX2 U519 ( .A(write_tx[1]), .Y(n354) );
  INVX2 U520 ( .A(write_data_state[2]), .Y(n355) );
  INVX2 U523 ( .A(tx_packet[3]), .Y(n432) );
  INVX2 U524 ( .A(hrdata[3]), .Y(n443) );
  INVX2 U527 ( .A(n587), .Y(n448) );
  INVX2 U528 ( .A(tx_packet[1]), .Y(n449) );
  INVX2 U531 ( .A(n594), .Y(n450) );
  INVX2 U532 ( .A(tx_packet[0]), .Y(n453) );
  INVX2 U535 ( .A(clear), .Y(n456) );
  INVX2 U536 ( .A(n960), .Y(n459) );
  INVX2 U539 ( .A(hsel), .Y(n462) );
  INVX2 U540 ( .A(n378), .Y(n465) );
  INVX2 U545 ( .A(n438), .Y(n468) );
  INVX2 U546 ( .A(n581), .Y(n475) );
  INVX2 U547 ( .A(n555), .Y(n478) );
  INVX2 U548 ( .A(n607), .Y(n483) );
  INVX2 U553 ( .A(n602), .Y(n484) );
  INVX2 U554 ( .A(n558), .Y(n485) );
  INVX2 U558 ( .A(haddr[2]), .Y(n488) );
  INVX2 U559 ( .A(haddr[1]), .Y(n491) );
  INVX2 U563 ( .A(haddr[0]), .Y(n494) );
  INVX2 U564 ( .A(htrans[0]), .Y(n497) );
  INVX2 U568 ( .A(n376), .Y(n500) );
  INVX2 U569 ( .A(hsize[1]), .Y(n503) );
  INVX2 U573 ( .A(n373), .Y(n508) );
  INVX2 U574 ( .A(hsize[0]), .Y(n514) );
  INVX2 U578 ( .A(n412), .Y(n521) );
  INVX2 U579 ( .A(hwdata[31]), .Y(n525) );
  INVX2 U584 ( .A(hwdata[30]), .Y(n529) );
  INVX2 U598 ( .A(hwdata[29]), .Y(n533) );
  INVX2 U600 ( .A(hwdata[28]), .Y(n537) );
  INVX2 U603 ( .A(hwdata[27]), .Y(n556) );
  INVX2 U605 ( .A(hwdata[26]), .Y(n562) );
  INVX2 U609 ( .A(hwdata[25]), .Y(n563) );
  INVX2 U611 ( .A(hwdata[24]), .Y(n567) );
  INVX2 U617 ( .A(hwdata[23]), .Y(n568) );
  INVX2 U624 ( .A(hwdata[22]), .Y(n1055) );
  INVX2 U631 ( .A(hwdata[21]), .Y(n1056) );
  INVX2 U638 ( .A(hwdata[20]), .Y(n1057) );
  INVX2 U1042 ( .A(hwdata[19]), .Y(n1058) );
  INVX2 U1111 ( .A(hwdata[18]), .Y(n1059) );
  INVX2 U1112 ( .A(hwdata[17]), .Y(n1060) );
  INVX2 U1113 ( .A(hwdata[16]), .Y(n1061) );
  INVX2 U1114 ( .A(hwdata[15]), .Y(n1062) );
  INVX2 U1115 ( .A(hwdata[14]), .Y(n1063) );
  INVX2 U1116 ( .A(hwdata[13]), .Y(n1064) );
  INVX2 U1117 ( .A(hwdata[12]), .Y(n1065) );
  INVX2 U1118 ( .A(hwdata[11]), .Y(n1070) );
  INVX2 U1119 ( .A(hwdata[10]), .Y(n1071) );
  INVX2 U1120 ( .A(hwdata[9]), .Y(n1072) );
  INVX2 U1121 ( .A(hwdata[8]), .Y(n1073) );
  INVX2 U1122 ( .A(hwdata[7]), .Y(n1074) );
  INVX2 U1123 ( .A(hwdata[6]), .Y(n1075) );
  INVX2 U1124 ( .A(hwdata[5]), .Y(n1076) );
  INVX2 U1125 ( .A(hwdata[4]), .Y(n1077) );
  INVX2 U1126 ( .A(hwdata[3]), .Y(n1078) );
  INVX2 U1127 ( .A(hwdata[2]), .Y(n1079) );
  INVX2 U1128 ( .A(hwdata[1]), .Y(n1080) );
  INVX2 U1129 ( .A(hwdata[0]), .Y(n1081) );
  NAND2X1 U1130 ( .A(hrdata[7]), .B(n262), .Y(n554) );
  NAND2X1 U1131 ( .A(stat[1]), .B(n558), .Y(n592) );
  NAND2X1 U1132 ( .A(stat[2]), .B(n558), .Y(n585) );
  NAND2X1 U1133 ( .A(stat[3]), .B(n558), .Y(n578) );
  NAND2X1 U1134 ( .A(stat[4]), .B(n558), .Y(n573) );
  NAND2X1 U1135 ( .A(stat[9]), .B(n517), .Y(n541) );
  NOR2X1 U1136 ( .A(n536), .B(n515), .Y(n535) );
  NOR2X1 U1137 ( .A(n532), .B(n515), .Y(n531) );
  NOR2X1 U1138 ( .A(n528), .B(n515), .Y(n527) );
  NOR2X1 U1139 ( .A(n524), .B(n515), .Y(n523) );
  NOR2X1 U1140 ( .A(n520), .B(n515), .Y(n519) );
  NOR2X1 U1141 ( .A(n513), .B(n515), .Y(n512) );
  NAND2X1 U1142 ( .A(n504), .B(n505), .Y(n1002) );
  NAND2X1 U1143 ( .A(n501), .B(n502), .Y(n1001) );
  NAND2X1 U1144 ( .A(n498), .B(n499), .Y(n1000) );
  NAND2X1 U1145 ( .A(n495), .B(n496), .Y(n999) );
  NAND2X1 U1146 ( .A(n492), .B(n493), .Y(n998) );
  NAND2X1 U1147 ( .A(n489), .B(n490), .Y(n997) );
  NAND2X1 U1148 ( .A(n486), .B(n487), .Y(n996) );
  NAND2X1 U1149 ( .A(n479), .B(n480), .Y(n995) );
  NAND2X1 U1150 ( .A(n469), .B(n470), .Y(n994) );
  NAND2X1 U1151 ( .A(n466), .B(n467), .Y(n993) );
  NAND2X1 U1152 ( .A(n463), .B(n464), .Y(n992) );
  NAND2X1 U1153 ( .A(n460), .B(n461), .Y(n991) );
  NAND2X1 U1154 ( .A(n457), .B(n458), .Y(n990) );
  NAND2X1 U1155 ( .A(n454), .B(n455), .Y(n989) );
  NAND2X1 U1156 ( .A(n451), .B(n452), .Y(n988) );
  NAND2X1 U1157 ( .A(n444), .B(n445), .Y(n987) );
endmodule


module fifo_data_buffer_DW01_inc_0 ( A, SUM );
  input [6:0] A;
  output [6:0] SUM;

  wire   [6:2] carry;

  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  INVX2 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[6]), .B(A[6]), .Y(SUM[6]) );
endmodule


module fifo_data_buffer_DW01_inc_1 ( A, SUM );
  input [6:0] A;
  output [6:0] SUM;

  wire   [6:2] carry;

  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  INVX2 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[6]), .B(A[6]), .Y(SUM[6]) );
endmodule


module fifo_data_buffer_DW01_inc_2 ( A, SUM );
  input [6:0] A;
  output [6:0] SUM;

  wire   [6:2] carry;

  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  XOR2X1 U1 ( .A(carry[6]), .B(A[6]), .Y(SUM[6]) );
endmodule


module fifo_data_buffer ( clear, flush, clk, n_rst, store_tx_data, 
        store_rx_packet_data, get_rx_data, get_tx_packet_data, tx_data, 
        rx_packet_data, rx_data, tx_packet_data, buffer_occupancy );
  input [7:0] tx_data;
  input [7:0] rx_packet_data;
  output [7:0] rx_data;
  output [7:0] tx_packet_data;
  output [6:0] buffer_occupancy;
  input clear, flush, clk, n_rst, store_tx_data, store_rx_packet_data,
         get_rx_data, get_tx_packet_data;
  wire   N20, N21, N22, N23, N24, N25, N27, N28, N29, N30, N31, N32, N33, N39,
         N40, N41, N42, N43, N44, N45, N46, N47, N48, N49, N50, N51,
         \rpointer[6] , \registers[63][7] , \registers[63][6] ,
         \registers[63][5] , \registers[63][4] , \registers[63][3] ,
         \registers[63][2] , \registers[63][1] , \registers[63][0] ,
         \registers[62][7] , \registers[62][6] , \registers[62][5] ,
         \registers[62][4] , \registers[62][3] , \registers[62][2] ,
         \registers[62][1] , \registers[62][0] , \registers[61][7] ,
         \registers[61][6] , \registers[61][5] , \registers[61][4] ,
         \registers[61][3] , \registers[61][2] , \registers[61][1] ,
         \registers[61][0] , \registers[60][7] , \registers[60][6] ,
         \registers[60][5] , \registers[60][4] , \registers[60][3] ,
         \registers[60][2] , \registers[60][1] , \registers[60][0] ,
         \registers[59][7] , \registers[59][6] , \registers[59][5] ,
         \registers[59][4] , \registers[59][3] , \registers[59][2] ,
         \registers[59][1] , \registers[59][0] , \registers[58][7] ,
         \registers[58][6] , \registers[58][5] , \registers[58][4] ,
         \registers[58][3] , \registers[58][2] , \registers[58][1] ,
         \registers[58][0] , \registers[57][7] , \registers[57][6] ,
         \registers[57][5] , \registers[57][4] , \registers[57][3] ,
         \registers[57][2] , \registers[57][1] , \registers[57][0] ,
         \registers[56][7] , \registers[56][6] , \registers[56][5] ,
         \registers[56][4] , \registers[56][3] , \registers[56][2] ,
         \registers[56][1] , \registers[56][0] , \registers[55][7] ,
         \registers[55][6] , \registers[55][5] , \registers[55][4] ,
         \registers[55][3] , \registers[55][2] , \registers[55][1] ,
         \registers[55][0] , \registers[54][7] , \registers[54][6] ,
         \registers[54][5] , \registers[54][4] , \registers[54][3] ,
         \registers[54][2] , \registers[54][1] , \registers[54][0] ,
         \registers[53][7] , \registers[53][6] , \registers[53][5] ,
         \registers[53][4] , \registers[53][3] , \registers[53][2] ,
         \registers[53][1] , \registers[53][0] , \registers[52][7] ,
         \registers[52][6] , \registers[52][5] , \registers[52][4] ,
         \registers[52][3] , \registers[52][2] , \registers[52][1] ,
         \registers[52][0] , \registers[51][7] , \registers[51][6] ,
         \registers[51][5] , \registers[51][4] , \registers[51][3] ,
         \registers[51][2] , \registers[51][1] , \registers[51][0] ,
         \registers[50][7] , \registers[50][6] , \registers[50][5] ,
         \registers[50][4] , \registers[50][3] , \registers[50][2] ,
         \registers[50][1] , \registers[50][0] , \registers[49][7] ,
         \registers[49][6] , \registers[49][5] , \registers[49][4] ,
         \registers[49][3] , \registers[49][2] , \registers[49][1] ,
         \registers[49][0] , \registers[48][7] , \registers[48][6] ,
         \registers[48][5] , \registers[48][4] , \registers[48][3] ,
         \registers[48][2] , \registers[48][1] , \registers[48][0] ,
         \registers[47][7] , \registers[47][6] , \registers[47][5] ,
         \registers[47][4] , \registers[47][3] , \registers[47][2] ,
         \registers[47][1] , \registers[47][0] , \registers[46][7] ,
         \registers[46][6] , \registers[46][5] , \registers[46][4] ,
         \registers[46][3] , \registers[46][2] , \registers[46][1] ,
         \registers[46][0] , \registers[45][7] , \registers[45][6] ,
         \registers[45][5] , \registers[45][4] , \registers[45][3] ,
         \registers[45][2] , \registers[45][1] , \registers[45][0] ,
         \registers[44][7] , \registers[44][6] , \registers[44][5] ,
         \registers[44][4] , \registers[44][3] , \registers[44][2] ,
         \registers[44][1] , \registers[44][0] , \registers[43][7] ,
         \registers[43][6] , \registers[43][5] , \registers[43][4] ,
         \registers[43][3] , \registers[43][2] , \registers[43][1] ,
         \registers[43][0] , \registers[42][7] , \registers[42][6] ,
         \registers[42][5] , \registers[42][4] , \registers[42][3] ,
         \registers[42][2] , \registers[42][1] , \registers[42][0] ,
         \registers[41][7] , \registers[41][6] , \registers[41][5] ,
         \registers[41][4] , \registers[41][3] , \registers[41][2] ,
         \registers[41][1] , \registers[41][0] , \registers[40][7] ,
         \registers[40][6] , \registers[40][5] , \registers[40][4] ,
         \registers[40][3] , \registers[40][2] , \registers[40][1] ,
         \registers[40][0] , \registers[39][7] , \registers[39][6] ,
         \registers[39][5] , \registers[39][4] , \registers[39][3] ,
         \registers[39][2] , \registers[39][1] , \registers[39][0] ,
         \registers[38][7] , \registers[38][6] , \registers[38][5] ,
         \registers[38][4] , \registers[38][3] , \registers[38][2] ,
         \registers[38][1] , \registers[38][0] , \registers[37][7] ,
         \registers[37][6] , \registers[37][5] , \registers[37][4] ,
         \registers[37][3] , \registers[37][2] , \registers[37][1] ,
         \registers[37][0] , \registers[36][7] , \registers[36][6] ,
         \registers[36][5] , \registers[36][4] , \registers[36][3] ,
         \registers[36][2] , \registers[36][1] , \registers[36][0] ,
         \registers[35][7] , \registers[35][6] , \registers[35][5] ,
         \registers[35][4] , \registers[35][3] , \registers[35][2] ,
         \registers[35][1] , \registers[35][0] , \registers[34][7] ,
         \registers[34][6] , \registers[34][5] , \registers[34][4] ,
         \registers[34][3] , \registers[34][2] , \registers[34][1] ,
         \registers[34][0] , \registers[33][7] , \registers[33][6] ,
         \registers[33][5] , \registers[33][4] , \registers[33][3] ,
         \registers[33][2] , \registers[33][1] , \registers[33][0] ,
         \registers[32][7] , \registers[32][6] , \registers[32][5] ,
         \registers[32][4] , \registers[32][3] , \registers[32][2] ,
         \registers[32][1] , \registers[32][0] , \registers[31][7] ,
         \registers[31][6] , \registers[31][5] , \registers[31][4] ,
         \registers[31][3] , \registers[31][2] , \registers[31][1] ,
         \registers[31][0] , \registers[30][7] , \registers[30][6] ,
         \registers[30][5] , \registers[30][4] , \registers[30][3] ,
         \registers[30][2] , \registers[30][1] , \registers[30][0] ,
         \registers[29][7] , \registers[29][6] , \registers[29][5] ,
         \registers[29][4] , \registers[29][3] , \registers[29][2] ,
         \registers[29][1] , \registers[29][0] , \registers[28][7] ,
         \registers[28][6] , \registers[28][5] , \registers[28][4] ,
         \registers[28][3] , \registers[28][2] , \registers[28][1] ,
         \registers[28][0] , \registers[27][7] , \registers[27][6] ,
         \registers[27][5] , \registers[27][4] , \registers[27][3] ,
         \registers[27][2] , \registers[27][1] , \registers[27][0] ,
         \registers[26][7] , \registers[26][6] , \registers[26][5] ,
         \registers[26][4] , \registers[26][3] , \registers[26][2] ,
         \registers[26][1] , \registers[26][0] , \registers[25][7] ,
         \registers[25][6] , \registers[25][5] , \registers[25][4] ,
         \registers[25][3] , \registers[25][2] , \registers[25][1] ,
         \registers[25][0] , \registers[24][7] , \registers[24][6] ,
         \registers[24][5] , \registers[24][4] , \registers[24][3] ,
         \registers[24][2] , \registers[24][1] , \registers[24][0] ,
         \registers[23][7] , \registers[23][6] , \registers[23][5] ,
         \registers[23][4] , \registers[23][3] , \registers[23][2] ,
         \registers[23][1] , \registers[23][0] , \registers[22][7] ,
         \registers[22][6] , \registers[22][5] , \registers[22][4] ,
         \registers[22][3] , \registers[22][2] , \registers[22][1] ,
         \registers[22][0] , \registers[21][7] , \registers[21][6] ,
         \registers[21][5] , \registers[21][4] , \registers[21][3] ,
         \registers[21][2] , \registers[21][1] , \registers[21][0] ,
         \registers[20][7] , \registers[20][6] , \registers[20][5] ,
         \registers[20][4] , \registers[20][3] , \registers[20][2] ,
         \registers[20][1] , \registers[20][0] , \registers[19][7] ,
         \registers[19][6] , \registers[19][5] , \registers[19][4] ,
         \registers[19][3] , \registers[19][2] , \registers[19][1] ,
         \registers[19][0] , \registers[18][7] , \registers[18][6] ,
         \registers[18][5] , \registers[18][4] , \registers[18][3] ,
         \registers[18][2] , \registers[18][1] , \registers[18][0] ,
         \registers[17][7] , \registers[17][6] , \registers[17][5] ,
         \registers[17][4] , \registers[17][3] , \registers[17][2] ,
         \registers[17][1] , \registers[17][0] , \registers[16][7] ,
         \registers[16][6] , \registers[16][5] , \registers[16][4] ,
         \registers[16][3] , \registers[16][2] , \registers[16][1] ,
         \registers[16][0] , \registers[15][7] , \registers[15][6] ,
         \registers[15][5] , \registers[15][4] , \registers[15][3] ,
         \registers[15][2] , \registers[15][1] , \registers[15][0] ,
         \registers[14][7] , \registers[14][6] , \registers[14][5] ,
         \registers[14][4] , \registers[14][3] , \registers[14][2] ,
         \registers[14][1] , \registers[14][0] , \registers[13][7] ,
         \registers[13][6] , \registers[13][5] , \registers[13][4] ,
         \registers[13][3] , \registers[13][2] , \registers[13][1] ,
         \registers[13][0] , \registers[12][7] , \registers[12][6] ,
         \registers[12][5] , \registers[12][4] , \registers[12][3] ,
         \registers[12][2] , \registers[12][1] , \registers[12][0] ,
         \registers[11][7] , \registers[11][6] , \registers[11][5] ,
         \registers[11][4] , \registers[11][3] , \registers[11][2] ,
         \registers[11][1] , \registers[11][0] , \registers[10][7] ,
         \registers[10][6] , \registers[10][5] , \registers[10][4] ,
         \registers[10][3] , \registers[10][2] , \registers[10][1] ,
         \registers[10][0] , \registers[9][7] , \registers[9][6] ,
         \registers[9][5] , \registers[9][4] , \registers[9][3] ,
         \registers[9][2] , \registers[9][1] , \registers[9][0] ,
         \registers[8][7] , \registers[8][6] , \registers[8][5] ,
         \registers[8][4] , \registers[8][3] , \registers[8][2] ,
         \registers[8][1] , \registers[8][0] , \registers[7][7] ,
         \registers[7][6] , \registers[7][5] , \registers[7][4] ,
         \registers[7][3] , \registers[7][2] , \registers[7][1] ,
         \registers[7][0] , \registers[6][7] , \registers[6][6] ,
         \registers[6][5] , \registers[6][4] , \registers[6][3] ,
         \registers[6][2] , \registers[6][1] , \registers[6][0] ,
         \registers[5][7] , \registers[5][6] , \registers[5][5] ,
         \registers[5][4] , \registers[5][3] , \registers[5][2] ,
         \registers[5][1] , \registers[5][0] , \registers[4][7] ,
         \registers[4][6] , \registers[4][5] , \registers[4][4] ,
         \registers[4][3] , \registers[4][2] , \registers[4][1] ,
         \registers[4][0] , \registers[3][7] , \registers[3][6] ,
         \registers[3][5] , \registers[3][4] , \registers[3][3] ,
         \registers[3][2] , \registers[3][1] , \registers[3][0] ,
         \registers[2][7] , \registers[2][6] , \registers[2][5] ,
         \registers[2][4] , \registers[2][3] , \registers[2][2] ,
         \registers[2][1] , \registers[2][0] , \registers[1][7] ,
         \registers[1][6] , \registers[1][5] , \registers[1][4] ,
         \registers[1][3] , \registers[1][2] , \registers[1][1] ,
         \registers[1][0] , \registers[0][7] , \registers[0][6] ,
         \registers[0][5] , \registers[0][4] , \registers[0][3] ,
         \registers[0][2] , \registers[0][1] , \registers[0][0] , N118, N119,
         N120, N121, N122, N123, N124, N125, N126, N127, N128, N129, N130,
         N131, N722, N723, N724, N725, N726, N727, N728, N733, N734, N735,
         N736, N737, N738, N739, n625, n626, n627, n628, n629, n630, n631,
         n632, n633, n634, n635, n636, n637, n638, n639, n640, n641, n642,
         n643, n644, n645, n646, n647, n648, n649, n650, n651, n652, n653,
         n654, n655, n656, n657, n658, n659, n660, n661, n662, n663, n664,
         n665, n666, n667, n668, n669, n670, n671, n672, n673, n674, n675,
         n676, n677, n678, n679, n680, n681, n682, n683, n684, n685, n686,
         n687, n688, n689, n690, n691, n692, n693, n694, n695, n696, n697,
         n698, n699, n700, n701, n702, n703, n704, n705, n706, n707, n708,
         n709, n710, n711, n712, n713, n714, n715, n716, n717, n718, n719,
         n720, n721, n722, n723, n724, n725, n726, n727, n728, n729, n730,
         n731, n732, n733, n734, n735, n736, n737, n738, n739, n740, n741,
         n742, n743, n744, n745, n746, n747, n748, n749, n750, n751, n752,
         n753, n754, n755, n756, n757, n758, n759, n760, n761, n762, n763,
         n764, n765, n766, n767, n768, n769, n770, n771, n772, n773, n774,
         n775, n776, n777, n778, n779, n780, n781, n782, n783, n784, n785,
         n786, n787, n788, n789, n790, n791, n792, n793, n794, n795, n796,
         n797, n798, n799, n800, n801, n802, n803, n804, n805, n806, n807,
         n808, n809, n810, n811, n812, n813, n814, n815, n816, n817, n818,
         n819, n820, n821, n822, n823, n824, n825, n826, n827, n828, n829,
         n830, n831, n832, n833, n834, n835, n836, n837, n838, n839, n840,
         n841, n842, n843, n844, n845, n846, n847, n848, n849, n850, n851,
         n852, n853, n854, n855, n856, n857, n858, n859, n860, n861, n862,
         n863, n864, n865, n866, n867, n868, n869, n870, n871, n872, n873,
         n874, n875, n876, n877, n878, n879, n880, n881, n882, n883, n884,
         n885, n886, n887, n888, n889, n890, n891, n892, n893, n894, n895,
         n896, n897, n898, n899, n900, n901, n902, n903, n904, n905, n906,
         n907, n908, n909, n910, n911, n912, n913, n914, n915, n916, n917,
         n918, n919, n920, n921, n922, n923, n924, n925, n926, n927, n928,
         n929, n930, n931, n932, n933, n934, n935, n936, n937, n938, n939,
         n940, n941, n942, n943, n944, n945, n946, n947, n948, n949, n950,
         n951, n952, n953, n954, n955, n956, n957, n958, n959, n960, n961,
         n962, n963, n964, n965, n966, n967, n968, n969, n970, n971, n972,
         n973, n974, n975, n976, n977, n978, n979, n980, n981, n982, n983,
         n984, n985, n986, n987, n988, n989, n990, n991, n992, n993, n994,
         n995, n996, n997, n998, n999, n1000, n1001, n1002, n1003, n1004,
         n1005, n1006, n1007, n1008, n1009, n1010, n1011, n1012, n1013, n1014,
         n1015, n1016, n1017, n1018, n1019, n1020, n1021, n1022, n1023, n1024,
         n1025, n1026, n1027, n1028, n1029, n1030, n1031, n1032, n1033, n1034,
         n1035, n1036, n1037, n1038, n1039, n1040, n1041, n1042, n1043, n1044,
         n1045, n1046, n1047, n1048, n1049, n1050, n1051, n1052, n1053, n1054,
         n1055, n1056, n1057, n1058, n1059, n1060, n1061, n1062, n1063, n1064,
         n1065, n1066, n1067, n1068, n1069, n1070, n1071, n1072, n1073, n1074,
         n1075, n1076, n1077, n1078, n1079, n1080, n1081, n1082, n1083, n1084,
         n1085, n1086, n1087, n1088, n1089, n1090, n1091, n1092, n1093, n1094,
         n1095, n1096, n1097, n1098, n1099, n1100, n1101, n1102, n1103, n1104,
         n1105, n1106, n1107, n1108, n1109, n1110, n1111, n1112, n1113, n1114,
         n1115, n1116, n1117, n1118, n1119, n1120, n1121, n1122, n1123, n1124,
         n1125, n1126, n1127, n1128, n1129, n1130, n1131, n1132, n1133, n1134,
         n1135, n1136, n1137, n1138, n1139, n1140, n1141, n1142, n1143, n1144,
         n1145, n1146, n1147, n1148, n1149, n1150, n1151, n1152, n1153, n1154,
         n1155, n1156, n1157, n1158, n1159, n1160, n1161, n1162, n1163, n1164,
         n1165, n1166, n1167, n1168, n1169, n1170, n1171, n1172, n1173, n1174,
         n1175, n1176, n1177, n1178, n1179, n1180, n1181, n1182, n1183, n1184,
         n1185, n1186, n1187, n1188, n1189, n1190, n1191, n1192, n1193, n1194,
         n1195, n1196, n1197, n1198, n1199, n1200, n1201, n1202, n1203, n1204,
         n1205, n1206, n1207, n1208, n1209, n1210, n1211, n1212, n1213, n1214,
         n1215, n1216, n1217, n1218, n1219, n1220, n1221, n1222, n1223, n1224,
         n1225, n1226, n1227, n1228, n1229, n1230, n1231, n1232, n1233, n1234,
         n1235, n1236, n1237, n1238, n1239, n1240, n1241, n1242, n1243, n1244,
         n1245, n1246, n1247, n1248, n1249, n1250, n1251, n1252, n1253, n1254,
         n1255, n1256, n1257, n1258, n1259, n1260, n1261, n1262, n1263, n1264,
         n1265, n1266, n1267, n1268, n1269, n1270, n1271, n1272, n1273, n1274,
         n1275, n1276, n1277, n1278, n1279, n1280, n1281, n1282, n1283, n1284,
         n1285, n1286, n1287, n1288, n1289, n1290, n1291, n1292, n1293, n1294,
         n1295, n1296, n1297, n1298, n1299, n1300, n1301, n1302, n1303, n1304,
         n1305, n1306, n1307, n1308, n1309, n1310, n1311, n1312, n1313, n1314,
         n1315, n1316, n1317, n1318, n1319, n1320, n1321, n1322, n1323, n1324,
         n1325, n1326, n1327, n1328, n1329, n1330, n1331, n1332, n1333, n1334,
         n1335, n1336, n1337, n1338, n1339, n1340, n1341, n1342, n1343, n1344,
         n1345, n1346, n1347, n1348, n1349, n1350, n1351, n1352, n1353, n1354,
         n1355, n1356, n1357, n1358, n1359, n1360, n1361, n1362, n1363, n1364,
         n1365, n1366, n1367, n1368, n1369, n1370, n1371, n1372, n1373, n1374,
         n1375, n1376, n1377, n1378, n1379, n1380, n1381, n1382, n1383, n1384,
         n1385, n1386, n1387, n1388, n1389, n1390, n1391, n1392, n1393, n1394,
         n1395, n1396, n1397, n1398, n1399, n1400, n1401, n1402, n1403, n1404,
         n1405, n1406, n1407, n1408, n1409, n1410, n1411, n1412, n1413, n1414,
         n1415, n1416, n1417, n1418, n1419, n1420, n1421, n1422, n1423, n1424,
         n1425, n1426, n1427, n1428, n1429, n1430, n1431, n1432, n1433, n1434,
         n1435, n1436, n1437, n1438, n1439, n1440, n1441, n1442, n1443, n1444,
         n1445, n1446, n1447, n1448, n1449, n1450, n1451, n1452, n1453, n1454,
         n1455, n1456, n1457, n1458, n1459, n1460, n1461, n1462, n1463, n1464,
         n1465, n1466, n1467, n1468, n1469, n1470, n1471, n1472, n1473, n1474,
         n1475, n1476, n1477, n1478, n1479, n1480, n1481, n1482, n1483, n1484,
         n1485, n1486, n1487, n1488, n1489, n1490, n1491, n1492, n1493, n1494,
         n1495, n1496, n1497, n1498, n1499, n1500, n1501, n1502, n1503, n1504,
         n1505, n1506, n1507, n1508, n1509, n1510, n1511, n1512, n1513, n1514,
         n1515, n1516, n1517, n1518, n1519, n1520, n1521, n1522, n1523, n1524,
         n1525, n1526, n1527, n1528, n1529, n1530, n1531, n1532, n1533, n1534,
         n1535, n1536, n1537, n1538, n1539, n1540, n1541, n1542, n1543, n1544,
         n1545, n1546, n1547, n1548, n1549, n1550, n1551, n1552, n1553, n1554,
         n1555, n1556, n1557, n1558, n1559, n1560, n1561, n1562, n1563, n1564,
         n1565, n1566, n1567, n1568, n1569, n1570, n1571, n1572, n1573, n1574,
         n1575, n1576, n1577, n1578, n1579, n1580, n1581, n1582, n1583, n1584,
         n1585, n1586, n1587, n1588, n1589, n1590, n1591, n1592, n1593, n1594,
         n1595, n1596, n1597, n1598, n1599, n1600, n1601, n1602, n1603, n1604,
         n1605, n1606, n1607, n1608, n1609, n1610, n1611, n1612, n1613, n1614,
         n1615, n1616, n1617, n1618, n1619, n1620, n1621, n1622, n1623, n1624,
         n1625, n1626, n1627, n1628, n1629, n1630, n1631, n1632, n1633, n1634,
         n1635, n1636, n1637, n1638, n1639, n1640, n1641, n1642, n1643, n1644,
         n1645, n1646, n1647, n1648, n1649, n1650, n1651, n1652, n1653, n1654,
         n1655, n1656, n1657, n1658, n1659, n1660, n1661, n1662, n1663, n1664,
         n1665, n1666, n1667, n1668, n1669, n1670, n1671, n1672, n1673, n1674,
         n1675, n1676, n1677, n1678, n1679, n1680, n1681, n1682, n1683, n1684,
         n1685, n1686, n1687, n1688, n1689, n1690, n1691, n1692, n1693, n1694,
         n1695, n1696, n1697, n1698, n1699, n1700, n1701, n1702, n1703, n1704,
         n1705, n1706, n1707, n1708, n1709, n1710, n1711, n1712, n1713, n1714,
         n1715, n1716, n1717, n1718, n1719, n1720, n1721, n1722, n1723, n1724,
         n1725, n1726, n1727, n1728, n1729, n1730, n1731, n1732, n1733, n1734,
         n1735, n1736, n1737, n1738, n1739, n1740, n1741, n1742, n1743, n1744,
         n1745, n1746, n1747, n1748, n1749, n1750, n1751, n1752, n1753, n1754,
         n1755, n1756, n1757, n1758, n1759, n1760, n1761, n1762, n1763, n1764,
         n1765, n1766, n1767, n1768, n1769, n1770, n1771, n1772, n1773, n1774,
         n1775, n1776, n1777, n1778, n1779, n1780, n1781, n1782, n534, n535,
         n536, n537, n538, n539, n540, n541, n542, n543, n544, n545, n546,
         n547, n548, n549, n550, n551, n552, n553, n554, n555, n556, n557,
         n558, n559, n560, n561, n562, n563, n564, n565, n566, n567, n568,
         n569, n570, n571, n572, n573, n574, n575, n576, n577, n578, n579,
         n580, n581, n582, n583, n584, n585, n586, n587, n588, n589, n590,
         n591, n592, n593, n594, n595, n596, n597, n598, n599, n600, n601,
         n602, n603, n604, n605, n606, n607, n608, n609, n610, n611, n612,
         n613, n614, n615, n616, n617, n618, n619, n620, n621, n622, n623,
         n624, n1783, n1784, n1785, n1786, n1787, n1788, n1789, n1790, n1791,
         n1792, n1793, n1794, n1795, n1796, n1797, n1798, n1799, n1800, n1801,
         n1802, n1803, n1804, n1805, n1806, n1807, n1808, n1809, n1810, n1811,
         n1812, n1813, n1814, n1815, n1816, n1817, n1818, n1819, n1820, n1821,
         n1822, n1823, n1824, n1825, n1826, n1827, n1828, n1829, n1830, n1831,
         n1832, n1833, n1834, n1835, n1836, n1837, n1838, n1839, n1840, n1841,
         n1842, n1843, n1844, n1845, n1846, n1847, n1848, n1849, n1850, n1851,
         n1852, n1853, n1854, n1855, n1856, n1857, n1858, n1859, n1860, n1861,
         n1862, n1863, n1864, n1865, n1866, n1867, n1868, n1869, n1870, n1871,
         n1872, n1873, n1874, n1875, n1876, n1877, n1878, n1879, n1880, n1881,
         n1882, n1883, n1884, n1885, n1886, n1887, n1888, n1889, n1890, n1891,
         n1892, n1893, n1894, n1895, n1896, n1897, n1898, n1899, n1900, n1901,
         n1902, n1903, n1904, n1905, n1906, n1907, n1908, n1909, n1910, n1911,
         n1912, n1913, n1914, n1915, n1916, n1917, n1918, n1919, n1920, n1921,
         n1922, n1923, n1924, n1925, n1926, n1927, n1928, n1929, n1930, n1931,
         n1932, n1933, n1934, n1935, n1936, n1937, n1938, n1939, n1940, n1941,
         n1942, n1943, n1944, n1945, n1946, n1947, n1948, n1949, n1950, n1951,
         n1952, n1953, n1954, n1955, n1956, n1957, n1958, n1959, n1960, n1961,
         n1962, n1963, n1964, n1965, n1966, n1967, n1968, n1969, n1970, n1971,
         n1972, n1973, n1974, n1975, n1976, n1977, n1978, n1979, n1980, n1981,
         n1982, n1983, n1984, n1985, n1986, n1987, n1988, n1989, n1990, n1991,
         n1992, n1993, n1994, n1995, n1996, n1997, n1998, n1999, n2000, n2001,
         n2002, n2003, n2004, n2005, n2006, n2007, n2008, n2009, n2010, n2011,
         n2012, n2013, n2014, n2015, n2016, n2017, n2018, n2019, n2020, n2021,
         n2022, n2023, n2024, n2025, n2026, n2027, n2028, n2029, n2030, n2031,
         n2032, n2033, n2034, n2035, n2036, n2037, n2038, n2039, n2040, n2041,
         n2042, n2043, n2044, n2045, n2046, n2047, n2048, n2049, n2050, n2051,
         n2052, n2053, n2054, n2055, n2056, n2057, n2058, n2059, n2060, n2061,
         n2062, n2063, n2064, n2065, n2066, n2067, n2068, n2069, n2070, n2071,
         n2072, n2073, n2074, n2075, n2076, n2077, n2078, n2079, n2080, n2081,
         n2082, n2083, n2084, n2085, n2086, n2087, n2088, n2089, n2090, n2091,
         n2092, n2093, n2094, n2095, n2096, n2097, n2098, n2099, n2100, n2101,
         n2102, n2103, n2104, n2105, n2106, n2107, n2108, n2109, n2110, n2111,
         n2112, n2113, n2114, n2115, n2116, n2117, n2118, n2119, n2120, n2121,
         n2122, n2123, n2124, n2125, n2126, n2127, n2128, n2129, n2130, n2131,
         n2132, n2133, n2134, n2135, n2136, n2137, n2138, n2139, n2140, n2141,
         n2142, n2143, n2144, n2145, n2146, n2147, n2148, n2149, n2150, n2151,
         n2152, n2153, n2154, n2155, n2156, n2157, n2158, n2159, n2160, n2161,
         n2162, n2163, n2164, n2165, n2166, n2167, n2168, n2169, n2170, n2171,
         n2172, n2173, n2174, n2175, n2176, n2177, n2178, n2179, n2180, n2181,
         n2182, n2183, n2184, n2185, n2186, n2187, n2188, n2189, n2190, n2191,
         n2192, n2193, n2194, n2195, n2196, n2197, n2198, n2199, n2200, n2201,
         n2202, n2203, n2204, n2205, n2206, n2207, n2208, n2209, n2210, n2211,
         n2212, n2213, n2214, n2215, n2216, n2217, n2218, n2219, n2220, n2221,
         n2222, n2223, n2224, n2225, n2226, n2227, n2228, n2229, n2230, n2231,
         n2232, n2233, n2234, n2235, n2236, n2237, n2238, n2239, n2240, n2241,
         n2242, n2243, n2244, n2245, n2246, n2247, n2248, n2249, n2250, n2251,
         n2252, n2253, n2254, n2255, n2256, n2257, n2258, n2259, n2260, n2261,
         n2262, n2263, n2264, n2265, n2266, n2267, n2268, n2269, n2270, n2271,
         n2272, n2273, n2274, n2275, n2276, n2277, n2278, n2279, n2280, n2281,
         n2282, n2283, n2284, n2285, n2286, n2287, n2288, n2289, n2290, n2291,
         n2292, n2293, n2294, n2295, n2296, n2297, n2298, n2299, n2300, n2301,
         n2302, n2303, n2304, n2305, n2306, n2307, n2308, n2309, n2310, n2311,
         n2312, n2313, n2314, n2315, n2316, n2317, n2318, n2319, n2320, n2321,
         n2322, n2323, n2324, n2325, n2326, n2327, n2328, n2329, n2330, n2331,
         n2332, n2333, n2334, n2335, n2336, n2337, n2338, n2339, n2340, n2341,
         n2342, n2343, n2344, n2345, n2346, n2347, n2348, n2349, n2350, n2351,
         n2352, n2353, n2354, n2355, n2356, n2357, n2358, n2359, n2360, n2361,
         n2362, n2363, n2364, n2365, n2366, n2367, n2368, n2369, n2370, n2371,
         n2372, n2373, n2374, n2375, n2376, n2377, n2378, n2379, n2380, n2381,
         n2382, n2383, n2384, n2385, n2386, n2387, n2388, n2389, n2390, n2391,
         n2392, n2393, n2394, n2395, n2396, n2397, n2398, n2399, n2400, n2401,
         n2402, n2403, n2404, n2405, n2406, n2407, n2408, n2409, n2410, n2411,
         n2412, n2413, n2414, n2415, n2416, n2417, n2418, n2419, n2420, n2421,
         n2422, n2423, n2424, n2425, n2426, n2427, n2428, n2429, n2430, n2431,
         n2432, n2433, n2434, n2435, n2436, n2437, n2438, n2439, n2440, n2441,
         n2442, n2443, n2444, n2445, n2446, n2447, n2448, n2449, n2450, n2451,
         n2452, n2453, n2454, n2455, n2456, n2457, n2458, n2459, n2460, n2461,
         n2462, n2463, n2464, n2465, n2466, n2467, n2468, n2469, n2470, n2471,
         n2472, n2473, n2474, n2475, n2476, n2477, n2478, n2479, n2480, n2481,
         n2482, n2483, n2484, n2485, n2486, n2487, n2488, n2489, n2490, n2491,
         n2492, n2493, n2494, n2495, n2496, n2497, n2498, n2499, n2500, n2501,
         n2502, n2503, n2504, n2505, n2506, n2507, n2508, n2509, n2510, n2511,
         n2512, n2513, n2514, n2515, n2516, n2517, n2518, n2519, n2520, n2521,
         n2522, n2523, n2524, n2525, n2526, n2527, n2528, n2529, n2530, n2531,
         n2532, n2533, n2534, n2535, n2536, n2537, n2538, n2539, n2540, n2541,
         n2542, n2543, n2544;
  wire   [6:0] wpointer;
  wire   SYNOPSYS_UNCONNECTED__0;

  DFFSR \buffer_occupancy_reg[0]  ( .D(N27), .CLK(clk), .R(n2440), .S(1'b1), 
        .Q(buffer_occupancy[0]) );
  DFFSR \buffer_occupancy_reg[6]  ( .D(N33), .CLK(clk), .R(n2440), .S(1'b1), 
        .Q(buffer_occupancy[6]) );
  DFFSR \buffer_occupancy_reg[1]  ( .D(N28), .CLK(clk), .R(n2440), .S(1'b1), 
        .Q(buffer_occupancy[1]) );
  DFFSR \buffer_occupancy_reg[2]  ( .D(N29), .CLK(clk), .R(n2440), .S(1'b1), 
        .Q(buffer_occupancy[2]) );
  DFFSR \buffer_occupancy_reg[3]  ( .D(N30), .CLK(clk), .R(n2440), .S(1'b1), 
        .Q(buffer_occupancy[3]) );
  DFFSR \buffer_occupancy_reg[4]  ( .D(N31), .CLK(clk), .R(n2439), .S(1'b1), 
        .Q(buffer_occupancy[4]) );
  DFFSR \buffer_occupancy_reg[5]  ( .D(N32), .CLK(clk), .R(n2439), .S(1'b1), 
        .Q(buffer_occupancy[5]) );
  DFFSR \rpointer_reg[0]  ( .D(N118), .CLK(clk), .R(n2439), .S(1'b1), .Q(N20)
         );
  DFFSR \rpointer_reg[1]  ( .D(N119), .CLK(clk), .R(n2439), .S(1'b1), .Q(N21)
         );
  DFFSR \rpointer_reg[2]  ( .D(N120), .CLK(clk), .R(n2439), .S(1'b1), .Q(N22)
         );
  DFFSR \rpointer_reg[3]  ( .D(N121), .CLK(clk), .R(n2439), .S(1'b1), .Q(N23)
         );
  DFFSR \rpointer_reg[4]  ( .D(N122), .CLK(clk), .R(n2439), .S(1'b1), .Q(N24)
         );
  DFFSR \rpointer_reg[5]  ( .D(N123), .CLK(clk), .R(n2439), .S(1'b1), .Q(N25)
         );
  DFFSR \rpointer_reg[6]  ( .D(N124), .CLK(clk), .R(n2439), .S(1'b1), .Q(
        \rpointer[6] ) );
  DFFSR \wpointer_reg[0]  ( .D(N125), .CLK(clk), .R(n2439), .S(1'b1), .Q(
        wpointer[0]) );
  DFFSR \wpointer_reg[1]  ( .D(N126), .CLK(clk), .R(n2439), .S(1'b1), .Q(
        wpointer[1]) );
  DFFSR \wpointer_reg[2]  ( .D(N127), .CLK(clk), .R(n2439), .S(1'b1), .Q(
        wpointer[2]) );
  DFFSR \wpointer_reg[3]  ( .D(N128), .CLK(clk), .R(n2438), .S(1'b1), .Q(
        wpointer[3]) );
  DFFSR \wpointer_reg[4]  ( .D(N129), .CLK(clk), .R(n2438), .S(1'b1), .Q(
        wpointer[4]) );
  DFFSR \wpointer_reg[5]  ( .D(N130), .CLK(clk), .R(n2438), .S(1'b1), .Q(
        wpointer[5]) );
  DFFSR \wpointer_reg[6]  ( .D(N131), .CLK(clk), .R(n2438), .S(1'b1), .Q(
        wpointer[6]) );
  DFFSR \registers_reg[57][0]  ( .D(n1326), .CLK(clk), .R(n2438), .S(1'b1), 
        .Q(\registers[57][0] ) );
  DFFSR \registers_reg[57][7]  ( .D(n1325), .CLK(clk), .R(n2438), .S(1'b1), 
        .Q(\registers[57][7] ) );
  DFFSR \registers_reg[57][6]  ( .D(n1324), .CLK(clk), .R(n2438), .S(1'b1), 
        .Q(\registers[57][6] ) );
  DFFSR \registers_reg[57][5]  ( .D(n1323), .CLK(clk), .R(n2438), .S(1'b1), 
        .Q(\registers[57][5] ) );
  DFFSR \registers_reg[57][4]  ( .D(n1322), .CLK(clk), .R(n2438), .S(1'b1), 
        .Q(\registers[57][4] ) );
  DFFSR \registers_reg[57][3]  ( .D(n1321), .CLK(clk), .R(n2438), .S(1'b1), 
        .Q(\registers[57][3] ) );
  DFFSR \registers_reg[57][2]  ( .D(n1320), .CLK(clk), .R(n2438), .S(1'b1), 
        .Q(\registers[57][2] ) );
  DFFSR \registers_reg[57][1]  ( .D(n1319), .CLK(clk), .R(n2438), .S(1'b1), 
        .Q(\registers[57][1] ) );
  DFFSR \registers_reg[49][0]  ( .D(n1390), .CLK(clk), .R(n2437), .S(1'b1), 
        .Q(\registers[49][0] ) );
  DFFSR \registers_reg[49][7]  ( .D(n1389), .CLK(clk), .R(n2437), .S(1'b1), 
        .Q(\registers[49][7] ) );
  DFFSR \registers_reg[49][6]  ( .D(n1388), .CLK(clk), .R(n2437), .S(1'b1), 
        .Q(\registers[49][6] ) );
  DFFSR \registers_reg[49][5]  ( .D(n1387), .CLK(clk), .R(n2437), .S(1'b1), 
        .Q(\registers[49][5] ) );
  DFFSR \registers_reg[49][4]  ( .D(n1386), .CLK(clk), .R(n2437), .S(1'b1), 
        .Q(\registers[49][4] ) );
  DFFSR \registers_reg[49][3]  ( .D(n1385), .CLK(clk), .R(n2437), .S(1'b1), 
        .Q(\registers[49][3] ) );
  DFFSR \registers_reg[49][2]  ( .D(n1384), .CLK(clk), .R(n2437), .S(1'b1), 
        .Q(\registers[49][2] ) );
  DFFSR \registers_reg[49][1]  ( .D(n1383), .CLK(clk), .R(n2437), .S(1'b1), 
        .Q(\registers[49][1] ) );
  DFFSR \registers_reg[41][0]  ( .D(n1454), .CLK(clk), .R(n2437), .S(1'b1), 
        .Q(\registers[41][0] ) );
  DFFSR \registers_reg[41][7]  ( .D(n1453), .CLK(clk), .R(n2437), .S(1'b1), 
        .Q(\registers[41][7] ) );
  DFFSR \registers_reg[41][6]  ( .D(n1452), .CLK(clk), .R(n2437), .S(1'b1), 
        .Q(\registers[41][6] ) );
  DFFSR \registers_reg[41][5]  ( .D(n1451), .CLK(clk), .R(n2437), .S(1'b1), 
        .Q(\registers[41][5] ) );
  DFFSR \registers_reg[41][4]  ( .D(n1450), .CLK(clk), .R(n2436), .S(1'b1), 
        .Q(\registers[41][4] ) );
  DFFSR \registers_reg[41][3]  ( .D(n1449), .CLK(clk), .R(n2436), .S(1'b1), 
        .Q(\registers[41][3] ) );
  DFFSR \registers_reg[41][2]  ( .D(n1448), .CLK(clk), .R(n2436), .S(1'b1), 
        .Q(\registers[41][2] ) );
  DFFSR \registers_reg[41][1]  ( .D(n1447), .CLK(clk), .R(n2436), .S(1'b1), 
        .Q(\registers[41][1] ) );
  DFFSR \registers_reg[33][0]  ( .D(n1518), .CLK(clk), .R(n2436), .S(1'b1), 
        .Q(\registers[33][0] ) );
  DFFSR \registers_reg[33][7]  ( .D(n1517), .CLK(clk), .R(n2436), .S(1'b1), 
        .Q(\registers[33][7] ) );
  DFFSR \registers_reg[33][6]  ( .D(n1516), .CLK(clk), .R(n2436), .S(1'b1), 
        .Q(\registers[33][6] ) );
  DFFSR \registers_reg[33][5]  ( .D(n1515), .CLK(clk), .R(n2436), .S(1'b1), 
        .Q(\registers[33][5] ) );
  DFFSR \registers_reg[33][4]  ( .D(n1514), .CLK(clk), .R(n2436), .S(1'b1), 
        .Q(\registers[33][4] ) );
  DFFSR \registers_reg[33][3]  ( .D(n1513), .CLK(clk), .R(n2436), .S(1'b1), 
        .Q(\registers[33][3] ) );
  DFFSR \registers_reg[33][2]  ( .D(n1512), .CLK(clk), .R(n2436), .S(1'b1), 
        .Q(\registers[33][2] ) );
  DFFSR \registers_reg[33][1]  ( .D(n1511), .CLK(clk), .R(n2436), .S(1'b1), 
        .Q(\registers[33][1] ) );
  DFFSR \registers_reg[25][0]  ( .D(n1582), .CLK(clk), .R(n2435), .S(1'b1), 
        .Q(\registers[25][0] ) );
  DFFSR \registers_reg[25][7]  ( .D(n1581), .CLK(clk), .R(n2435), .S(1'b1), 
        .Q(\registers[25][7] ) );
  DFFSR \registers_reg[25][6]  ( .D(n1580), .CLK(clk), .R(n2435), .S(1'b1), 
        .Q(\registers[25][6] ) );
  DFFSR \registers_reg[25][5]  ( .D(n1579), .CLK(clk), .R(n2435), .S(1'b1), 
        .Q(\registers[25][5] ) );
  DFFSR \registers_reg[25][4]  ( .D(n1578), .CLK(clk), .R(n2435), .S(1'b1), 
        .Q(\registers[25][4] ) );
  DFFSR \registers_reg[25][3]  ( .D(n1577), .CLK(clk), .R(n2435), .S(1'b1), 
        .Q(\registers[25][3] ) );
  DFFSR \registers_reg[25][2]  ( .D(n1576), .CLK(clk), .R(n2435), .S(1'b1), 
        .Q(\registers[25][2] ) );
  DFFSR \registers_reg[25][1]  ( .D(n1575), .CLK(clk), .R(n2435), .S(1'b1), 
        .Q(\registers[25][1] ) );
  DFFSR \registers_reg[17][0]  ( .D(n1646), .CLK(clk), .R(n2435), .S(1'b1), 
        .Q(\registers[17][0] ) );
  DFFSR \registers_reg[17][7]  ( .D(n1645), .CLK(clk), .R(n2435), .S(1'b1), 
        .Q(\registers[17][7] ) );
  DFFSR \registers_reg[17][6]  ( .D(n1644), .CLK(clk), .R(n2435), .S(1'b1), 
        .Q(\registers[17][6] ) );
  DFFSR \registers_reg[17][5]  ( .D(n1643), .CLK(clk), .R(n2435), .S(1'b1), 
        .Q(\registers[17][5] ) );
  DFFSR \registers_reg[17][4]  ( .D(n1642), .CLK(clk), .R(n2434), .S(1'b1), 
        .Q(\registers[17][4] ) );
  DFFSR \registers_reg[17][3]  ( .D(n1641), .CLK(clk), .R(n2434), .S(1'b1), 
        .Q(\registers[17][3] ) );
  DFFSR \registers_reg[17][2]  ( .D(n1640), .CLK(clk), .R(n2434), .S(1'b1), 
        .Q(\registers[17][2] ) );
  DFFSR \registers_reg[17][1]  ( .D(n1639), .CLK(clk), .R(n2434), .S(1'b1), 
        .Q(\registers[17][1] ) );
  DFFSR \registers_reg[9][0]  ( .D(n1710), .CLK(clk), .R(n2434), .S(1'b1), .Q(
        \registers[9][0] ) );
  DFFSR \registers_reg[9][7]  ( .D(n1709), .CLK(clk), .R(n2434), .S(1'b1), .Q(
        \registers[9][7] ) );
  DFFSR \registers_reg[9][6]  ( .D(n1708), .CLK(clk), .R(n2434), .S(1'b1), .Q(
        \registers[9][6] ) );
  DFFSR \registers_reg[9][5]  ( .D(n1707), .CLK(clk), .R(n2434), .S(1'b1), .Q(
        \registers[9][5] ) );
  DFFSR \registers_reg[9][4]  ( .D(n1706), .CLK(clk), .R(n2434), .S(1'b1), .Q(
        \registers[9][4] ) );
  DFFSR \registers_reg[9][3]  ( .D(n1705), .CLK(clk), .R(n2434), .S(1'b1), .Q(
        \registers[9][3] ) );
  DFFSR \registers_reg[9][2]  ( .D(n1704), .CLK(clk), .R(n2434), .S(1'b1), .Q(
        \registers[9][2] ) );
  DFFSR \registers_reg[9][1]  ( .D(n1703), .CLK(clk), .R(n2434), .S(1'b1), .Q(
        \registers[9][1] ) );
  DFFSR \registers_reg[1][0]  ( .D(n1774), .CLK(clk), .R(n2433), .S(1'b1), .Q(
        \registers[1][0] ) );
  DFFSR \registers_reg[1][7]  ( .D(n1773), .CLK(clk), .R(n2433), .S(1'b1), .Q(
        \registers[1][7] ) );
  DFFSR \registers_reg[1][6]  ( .D(n1772), .CLK(clk), .R(n2433), .S(1'b1), .Q(
        \registers[1][6] ) );
  DFFSR \registers_reg[1][5]  ( .D(n1771), .CLK(clk), .R(n2433), .S(1'b1), .Q(
        \registers[1][5] ) );
  DFFSR \registers_reg[1][4]  ( .D(n1770), .CLK(clk), .R(n2433), .S(1'b1), .Q(
        \registers[1][4] ) );
  DFFSR \registers_reg[1][3]  ( .D(n1769), .CLK(clk), .R(n2433), .S(1'b1), .Q(
        \registers[1][3] ) );
  DFFSR \registers_reg[1][2]  ( .D(n1768), .CLK(clk), .R(n2433), .S(1'b1), .Q(
        \registers[1][2] ) );
  DFFSR \registers_reg[1][1]  ( .D(n1767), .CLK(clk), .R(n2433), .S(1'b1), .Q(
        \registers[1][1] ) );
  DFFSR \registers_reg[59][0]  ( .D(n1310), .CLK(clk), .R(n2433), .S(1'b1), 
        .Q(\registers[59][0] ) );
  DFFSR \registers_reg[59][7]  ( .D(n1309), .CLK(clk), .R(n2433), .S(1'b1), 
        .Q(\registers[59][7] ) );
  DFFSR \registers_reg[59][6]  ( .D(n1308), .CLK(clk), .R(n2433), .S(1'b1), 
        .Q(\registers[59][6] ) );
  DFFSR \registers_reg[59][5]  ( .D(n1307), .CLK(clk), .R(n2433), .S(1'b1), 
        .Q(\registers[59][5] ) );
  DFFSR \registers_reg[59][4]  ( .D(n1306), .CLK(clk), .R(n2432), .S(1'b1), 
        .Q(\registers[59][4] ) );
  DFFSR \registers_reg[59][3]  ( .D(n1305), .CLK(clk), .R(n2432), .S(1'b1), 
        .Q(\registers[59][3] ) );
  DFFSR \registers_reg[59][2]  ( .D(n1304), .CLK(clk), .R(n2432), .S(1'b1), 
        .Q(\registers[59][2] ) );
  DFFSR \registers_reg[59][1]  ( .D(n1303), .CLK(clk), .R(n2432), .S(1'b1), 
        .Q(\registers[59][1] ) );
  DFFSR \registers_reg[51][0]  ( .D(n1374), .CLK(clk), .R(n2432), .S(1'b1), 
        .Q(\registers[51][0] ) );
  DFFSR \registers_reg[51][7]  ( .D(n1373), .CLK(clk), .R(n2432), .S(1'b1), 
        .Q(\registers[51][7] ) );
  DFFSR \registers_reg[51][6]  ( .D(n1372), .CLK(clk), .R(n2432), .S(1'b1), 
        .Q(\registers[51][6] ) );
  DFFSR \registers_reg[51][5]  ( .D(n1371), .CLK(clk), .R(n2432), .S(1'b1), 
        .Q(\registers[51][5] ) );
  DFFSR \registers_reg[51][4]  ( .D(n1370), .CLK(clk), .R(n2432), .S(1'b1), 
        .Q(\registers[51][4] ) );
  DFFSR \registers_reg[51][3]  ( .D(n1369), .CLK(clk), .R(n2432), .S(1'b1), 
        .Q(\registers[51][3] ) );
  DFFSR \registers_reg[51][2]  ( .D(n1368), .CLK(clk), .R(n2432), .S(1'b1), 
        .Q(\registers[51][2] ) );
  DFFSR \registers_reg[51][1]  ( .D(n1367), .CLK(clk), .R(n2432), .S(1'b1), 
        .Q(\registers[51][1] ) );
  DFFSR \registers_reg[43][0]  ( .D(n1438), .CLK(clk), .R(n2431), .S(1'b1), 
        .Q(\registers[43][0] ) );
  DFFSR \registers_reg[43][7]  ( .D(n1437), .CLK(clk), .R(n2431), .S(1'b1), 
        .Q(\registers[43][7] ) );
  DFFSR \registers_reg[43][6]  ( .D(n1436), .CLK(clk), .R(n2431), .S(1'b1), 
        .Q(\registers[43][6] ) );
  DFFSR \registers_reg[43][5]  ( .D(n1435), .CLK(clk), .R(n2431), .S(1'b1), 
        .Q(\registers[43][5] ) );
  DFFSR \registers_reg[43][4]  ( .D(n1434), .CLK(clk), .R(n2431), .S(1'b1), 
        .Q(\registers[43][4] ) );
  DFFSR \registers_reg[43][3]  ( .D(n1433), .CLK(clk), .R(n2431), .S(1'b1), 
        .Q(\registers[43][3] ) );
  DFFSR \registers_reg[43][2]  ( .D(n1432), .CLK(clk), .R(n2431), .S(1'b1), 
        .Q(\registers[43][2] ) );
  DFFSR \registers_reg[43][1]  ( .D(n1431), .CLK(clk), .R(n2431), .S(1'b1), 
        .Q(\registers[43][1] ) );
  DFFSR \registers_reg[35][0]  ( .D(n1502), .CLK(clk), .R(n2431), .S(1'b1), 
        .Q(\registers[35][0] ) );
  DFFSR \registers_reg[35][7]  ( .D(n1501), .CLK(clk), .R(n2431), .S(1'b1), 
        .Q(\registers[35][7] ) );
  DFFSR \registers_reg[35][6]  ( .D(n1500), .CLK(clk), .R(n2431), .S(1'b1), 
        .Q(\registers[35][6] ) );
  DFFSR \registers_reg[35][5]  ( .D(n1499), .CLK(clk), .R(n2431), .S(1'b1), 
        .Q(\registers[35][5] ) );
  DFFSR \registers_reg[35][4]  ( .D(n1498), .CLK(clk), .R(n2430), .S(1'b1), 
        .Q(\registers[35][4] ) );
  DFFSR \registers_reg[35][3]  ( .D(n1497), .CLK(clk), .R(n2430), .S(1'b1), 
        .Q(\registers[35][3] ) );
  DFFSR \registers_reg[35][2]  ( .D(n1496), .CLK(clk), .R(n2430), .S(1'b1), 
        .Q(\registers[35][2] ) );
  DFFSR \registers_reg[35][1]  ( .D(n1495), .CLK(clk), .R(n2430), .S(1'b1), 
        .Q(\registers[35][1] ) );
  DFFSR \registers_reg[27][0]  ( .D(n1566), .CLK(clk), .R(n2430), .S(1'b1), 
        .Q(\registers[27][0] ) );
  DFFSR \registers_reg[27][7]  ( .D(n1565), .CLK(clk), .R(n2430), .S(1'b1), 
        .Q(\registers[27][7] ) );
  DFFSR \registers_reg[27][6]  ( .D(n1564), .CLK(clk), .R(n2430), .S(1'b1), 
        .Q(\registers[27][6] ) );
  DFFSR \registers_reg[27][5]  ( .D(n1563), .CLK(clk), .R(n2430), .S(1'b1), 
        .Q(\registers[27][5] ) );
  DFFSR \registers_reg[27][4]  ( .D(n1562), .CLK(clk), .R(n2430), .S(1'b1), 
        .Q(\registers[27][4] ) );
  DFFSR \registers_reg[27][3]  ( .D(n1561), .CLK(clk), .R(n2430), .S(1'b1), 
        .Q(\registers[27][3] ) );
  DFFSR \registers_reg[27][2]  ( .D(n1560), .CLK(clk), .R(n2430), .S(1'b1), 
        .Q(\registers[27][2] ) );
  DFFSR \registers_reg[27][1]  ( .D(n1559), .CLK(clk), .R(n2430), .S(1'b1), 
        .Q(\registers[27][1] ) );
  DFFSR \registers_reg[19][0]  ( .D(n1630), .CLK(clk), .R(n2429), .S(1'b1), 
        .Q(\registers[19][0] ) );
  DFFSR \registers_reg[19][7]  ( .D(n1629), .CLK(clk), .R(n2429), .S(1'b1), 
        .Q(\registers[19][7] ) );
  DFFSR \registers_reg[19][6]  ( .D(n1628), .CLK(clk), .R(n2429), .S(1'b1), 
        .Q(\registers[19][6] ) );
  DFFSR \registers_reg[19][5]  ( .D(n1627), .CLK(clk), .R(n2429), .S(1'b1), 
        .Q(\registers[19][5] ) );
  DFFSR \registers_reg[19][4]  ( .D(n1626), .CLK(clk), .R(n2429), .S(1'b1), 
        .Q(\registers[19][4] ) );
  DFFSR \registers_reg[19][3]  ( .D(n1625), .CLK(clk), .R(n2429), .S(1'b1), 
        .Q(\registers[19][3] ) );
  DFFSR \registers_reg[19][2]  ( .D(n1624), .CLK(clk), .R(n2429), .S(1'b1), 
        .Q(\registers[19][2] ) );
  DFFSR \registers_reg[19][1]  ( .D(n1623), .CLK(clk), .R(n2429), .S(1'b1), 
        .Q(\registers[19][1] ) );
  DFFSR \registers_reg[11][0]  ( .D(n1694), .CLK(clk), .R(n2429), .S(1'b1), 
        .Q(\registers[11][0] ) );
  DFFSR \registers_reg[11][7]  ( .D(n1693), .CLK(clk), .R(n2429), .S(1'b1), 
        .Q(\registers[11][7] ) );
  DFFSR \registers_reg[11][6]  ( .D(n1692), .CLK(clk), .R(n2429), .S(1'b1), 
        .Q(\registers[11][6] ) );
  DFFSR \registers_reg[11][5]  ( .D(n1691), .CLK(clk), .R(n2429), .S(1'b1), 
        .Q(\registers[11][5] ) );
  DFFSR \registers_reg[11][4]  ( .D(n1690), .CLK(clk), .R(n2428), .S(1'b1), 
        .Q(\registers[11][4] ) );
  DFFSR \registers_reg[11][3]  ( .D(n1689), .CLK(clk), .R(n2428), .S(1'b1), 
        .Q(\registers[11][3] ) );
  DFFSR \registers_reg[11][2]  ( .D(n1688), .CLK(clk), .R(n2428), .S(1'b1), 
        .Q(\registers[11][2] ) );
  DFFSR \registers_reg[11][1]  ( .D(n1687), .CLK(clk), .R(n2428), .S(1'b1), 
        .Q(\registers[11][1] ) );
  DFFSR \registers_reg[3][0]  ( .D(n1758), .CLK(clk), .R(n2428), .S(1'b1), .Q(
        \registers[3][0] ) );
  DFFSR \registers_reg[3][7]  ( .D(n1757), .CLK(clk), .R(n2428), .S(1'b1), .Q(
        \registers[3][7] ) );
  DFFSR \registers_reg[3][6]  ( .D(n1756), .CLK(clk), .R(n2428), .S(1'b1), .Q(
        \registers[3][6] ) );
  DFFSR \registers_reg[3][5]  ( .D(n1755), .CLK(clk), .R(n2428), .S(1'b1), .Q(
        \registers[3][5] ) );
  DFFSR \registers_reg[3][4]  ( .D(n1754), .CLK(clk), .R(n2428), .S(1'b1), .Q(
        \registers[3][4] ) );
  DFFSR \registers_reg[3][3]  ( .D(n1753), .CLK(clk), .R(n2428), .S(1'b1), .Q(
        \registers[3][3] ) );
  DFFSR \registers_reg[3][2]  ( .D(n1752), .CLK(clk), .R(n2428), .S(1'b1), .Q(
        \registers[3][2] ) );
  DFFSR \registers_reg[3][1]  ( .D(n1751), .CLK(clk), .R(n2428), .S(1'b1), .Q(
        \registers[3][1] ) );
  DFFSR \registers_reg[61][0]  ( .D(n1294), .CLK(clk), .R(n2427), .S(1'b1), 
        .Q(\registers[61][0] ) );
  DFFSR \registers_reg[61][7]  ( .D(n1293), .CLK(clk), .R(n2427), .S(1'b1), 
        .Q(\registers[61][7] ) );
  DFFSR \registers_reg[61][6]  ( .D(n1292), .CLK(clk), .R(n2427), .S(1'b1), 
        .Q(\registers[61][6] ) );
  DFFSR \registers_reg[61][5]  ( .D(n1291), .CLK(clk), .R(n2427), .S(1'b1), 
        .Q(\registers[61][5] ) );
  DFFSR \registers_reg[61][4]  ( .D(n1290), .CLK(clk), .R(n2427), .S(1'b1), 
        .Q(\registers[61][4] ) );
  DFFSR \registers_reg[61][3]  ( .D(n1289), .CLK(clk), .R(n2427), .S(1'b1), 
        .Q(\registers[61][3] ) );
  DFFSR \registers_reg[61][2]  ( .D(n1288), .CLK(clk), .R(n2427), .S(1'b1), 
        .Q(\registers[61][2] ) );
  DFFSR \registers_reg[61][1]  ( .D(n1287), .CLK(clk), .R(n2427), .S(1'b1), 
        .Q(\registers[61][1] ) );
  DFFSR \registers_reg[53][0]  ( .D(n1358), .CLK(clk), .R(n2427), .S(1'b1), 
        .Q(\registers[53][0] ) );
  DFFSR \registers_reg[53][7]  ( .D(n1357), .CLK(clk), .R(n2427), .S(1'b1), 
        .Q(\registers[53][7] ) );
  DFFSR \registers_reg[53][6]  ( .D(n1356), .CLK(clk), .R(n2427), .S(1'b1), 
        .Q(\registers[53][6] ) );
  DFFSR \registers_reg[53][5]  ( .D(n1355), .CLK(clk), .R(n2427), .S(1'b1), 
        .Q(\registers[53][5] ) );
  DFFSR \registers_reg[53][4]  ( .D(n1354), .CLK(clk), .R(n2426), .S(1'b1), 
        .Q(\registers[53][4] ) );
  DFFSR \registers_reg[53][3]  ( .D(n1353), .CLK(clk), .R(n2426), .S(1'b1), 
        .Q(\registers[53][3] ) );
  DFFSR \registers_reg[53][2]  ( .D(n1352), .CLK(clk), .R(n2426), .S(1'b1), 
        .Q(\registers[53][2] ) );
  DFFSR \registers_reg[53][1]  ( .D(n1351), .CLK(clk), .R(n2426), .S(1'b1), 
        .Q(\registers[53][1] ) );
  DFFSR \registers_reg[45][0]  ( .D(n1422), .CLK(clk), .R(n2426), .S(1'b1), 
        .Q(\registers[45][0] ) );
  DFFSR \registers_reg[45][7]  ( .D(n1421), .CLK(clk), .R(n2426), .S(1'b1), 
        .Q(\registers[45][7] ) );
  DFFSR \registers_reg[45][6]  ( .D(n1420), .CLK(clk), .R(n2426), .S(1'b1), 
        .Q(\registers[45][6] ) );
  DFFSR \registers_reg[45][5]  ( .D(n1419), .CLK(clk), .R(n2426), .S(1'b1), 
        .Q(\registers[45][5] ) );
  DFFSR \registers_reg[45][4]  ( .D(n1418), .CLK(clk), .R(n2426), .S(1'b1), 
        .Q(\registers[45][4] ) );
  DFFSR \registers_reg[45][3]  ( .D(n1417), .CLK(clk), .R(n2426), .S(1'b1), 
        .Q(\registers[45][3] ) );
  DFFSR \registers_reg[45][2]  ( .D(n1416), .CLK(clk), .R(n2426), .S(1'b1), 
        .Q(\registers[45][2] ) );
  DFFSR \registers_reg[45][1]  ( .D(n1415), .CLK(clk), .R(n2426), .S(1'b1), 
        .Q(\registers[45][1] ) );
  DFFSR \registers_reg[37][0]  ( .D(n1486), .CLK(clk), .R(n2425), .S(1'b1), 
        .Q(\registers[37][0] ) );
  DFFSR \registers_reg[37][7]  ( .D(n1485), .CLK(clk), .R(n2425), .S(1'b1), 
        .Q(\registers[37][7] ) );
  DFFSR \registers_reg[37][6]  ( .D(n1484), .CLK(clk), .R(n2425), .S(1'b1), 
        .Q(\registers[37][6] ) );
  DFFSR \registers_reg[37][5]  ( .D(n1483), .CLK(clk), .R(n2425), .S(1'b1), 
        .Q(\registers[37][5] ) );
  DFFSR \registers_reg[37][4]  ( .D(n1482), .CLK(clk), .R(n2425), .S(1'b1), 
        .Q(\registers[37][4] ) );
  DFFSR \registers_reg[37][3]  ( .D(n1481), .CLK(clk), .R(n2425), .S(1'b1), 
        .Q(\registers[37][3] ) );
  DFFSR \registers_reg[37][2]  ( .D(n1480), .CLK(clk), .R(n2425), .S(1'b1), 
        .Q(\registers[37][2] ) );
  DFFSR \registers_reg[37][1]  ( .D(n1479), .CLK(clk), .R(n2425), .S(1'b1), 
        .Q(\registers[37][1] ) );
  DFFSR \registers_reg[29][0]  ( .D(n1550), .CLK(clk), .R(n2425), .S(1'b1), 
        .Q(\registers[29][0] ) );
  DFFSR \registers_reg[29][7]  ( .D(n1549), .CLK(clk), .R(n2425), .S(1'b1), 
        .Q(\registers[29][7] ) );
  DFFSR \registers_reg[29][6]  ( .D(n1548), .CLK(clk), .R(n2425), .S(1'b1), 
        .Q(\registers[29][6] ) );
  DFFSR \registers_reg[29][5]  ( .D(n1547), .CLK(clk), .R(n2425), .S(1'b1), 
        .Q(\registers[29][5] ) );
  DFFSR \registers_reg[29][4]  ( .D(n1546), .CLK(clk), .R(n2424), .S(1'b1), 
        .Q(\registers[29][4] ) );
  DFFSR \registers_reg[29][3]  ( .D(n1545), .CLK(clk), .R(n2424), .S(1'b1), 
        .Q(\registers[29][3] ) );
  DFFSR \registers_reg[29][2]  ( .D(n1544), .CLK(clk), .R(n2424), .S(1'b1), 
        .Q(\registers[29][2] ) );
  DFFSR \registers_reg[29][1]  ( .D(n1543), .CLK(clk), .R(n2424), .S(1'b1), 
        .Q(\registers[29][1] ) );
  DFFSR \registers_reg[21][0]  ( .D(n1614), .CLK(clk), .R(n2424), .S(1'b1), 
        .Q(\registers[21][0] ) );
  DFFSR \registers_reg[21][7]  ( .D(n1613), .CLK(clk), .R(n2424), .S(1'b1), 
        .Q(\registers[21][7] ) );
  DFFSR \registers_reg[21][6]  ( .D(n1612), .CLK(clk), .R(n2424), .S(1'b1), 
        .Q(\registers[21][6] ) );
  DFFSR \registers_reg[21][5]  ( .D(n1611), .CLK(clk), .R(n2424), .S(1'b1), 
        .Q(\registers[21][5] ) );
  DFFSR \registers_reg[21][4]  ( .D(n1610), .CLK(clk), .R(n2424), .S(1'b1), 
        .Q(\registers[21][4] ) );
  DFFSR \registers_reg[21][3]  ( .D(n1609), .CLK(clk), .R(n2424), .S(1'b1), 
        .Q(\registers[21][3] ) );
  DFFSR \registers_reg[21][2]  ( .D(n1608), .CLK(clk), .R(n2424), .S(1'b1), 
        .Q(\registers[21][2] ) );
  DFFSR \registers_reg[21][1]  ( .D(n1607), .CLK(clk), .R(n2424), .S(1'b1), 
        .Q(\registers[21][1] ) );
  DFFSR \registers_reg[13][0]  ( .D(n1678), .CLK(clk), .R(n2423), .S(1'b1), 
        .Q(\registers[13][0] ) );
  DFFSR \registers_reg[13][7]  ( .D(n1677), .CLK(clk), .R(n2423), .S(1'b1), 
        .Q(\registers[13][7] ) );
  DFFSR \registers_reg[13][6]  ( .D(n1676), .CLK(clk), .R(n2423), .S(1'b1), 
        .Q(\registers[13][6] ) );
  DFFSR \registers_reg[13][5]  ( .D(n1675), .CLK(clk), .R(n2423), .S(1'b1), 
        .Q(\registers[13][5] ) );
  DFFSR \registers_reg[13][4]  ( .D(n1674), .CLK(clk), .R(n2423), .S(1'b1), 
        .Q(\registers[13][4] ) );
  DFFSR \registers_reg[13][3]  ( .D(n1673), .CLK(clk), .R(n2423), .S(1'b1), 
        .Q(\registers[13][3] ) );
  DFFSR \registers_reg[13][2]  ( .D(n1672), .CLK(clk), .R(n2423), .S(1'b1), 
        .Q(\registers[13][2] ) );
  DFFSR \registers_reg[13][1]  ( .D(n1671), .CLK(clk), .R(n2423), .S(1'b1), 
        .Q(\registers[13][1] ) );
  DFFSR \registers_reg[5][0]  ( .D(n1742), .CLK(clk), .R(n2423), .S(1'b1), .Q(
        \registers[5][0] ) );
  DFFSR \registers_reg[5][7]  ( .D(n1741), .CLK(clk), .R(n2423), .S(1'b1), .Q(
        \registers[5][7] ) );
  DFFSR \registers_reg[5][6]  ( .D(n1740), .CLK(clk), .R(n2423), .S(1'b1), .Q(
        \registers[5][6] ) );
  DFFSR \registers_reg[5][5]  ( .D(n1739), .CLK(clk), .R(n2423), .S(1'b1), .Q(
        \registers[5][5] ) );
  DFFSR \registers_reg[5][4]  ( .D(n1738), .CLK(clk), .R(n2422), .S(1'b1), .Q(
        \registers[5][4] ) );
  DFFSR \registers_reg[5][3]  ( .D(n1737), .CLK(clk), .R(n2422), .S(1'b1), .Q(
        \registers[5][3] ) );
  DFFSR \registers_reg[5][2]  ( .D(n1736), .CLK(clk), .R(n2422), .S(1'b1), .Q(
        \registers[5][2] ) );
  DFFSR \registers_reg[5][1]  ( .D(n1735), .CLK(clk), .R(n2422), .S(1'b1), .Q(
        \registers[5][1] ) );
  DFFSR \registers_reg[63][0]  ( .D(n1278), .CLK(clk), .R(n2422), .S(1'b1), 
        .Q(\registers[63][0] ) );
  DFFSR \registers_reg[63][7]  ( .D(n1277), .CLK(clk), .R(n2422), .S(1'b1), 
        .Q(\registers[63][7] ) );
  DFFSR \registers_reg[63][6]  ( .D(n1276), .CLK(clk), .R(n2422), .S(1'b1), 
        .Q(\registers[63][6] ) );
  DFFSR \registers_reg[63][5]  ( .D(n1275), .CLK(clk), .R(n2422), .S(1'b1), 
        .Q(\registers[63][5] ) );
  DFFSR \registers_reg[63][4]  ( .D(n1274), .CLK(clk), .R(n2422), .S(1'b1), 
        .Q(\registers[63][4] ) );
  DFFSR \registers_reg[63][3]  ( .D(n1273), .CLK(clk), .R(n2422), .S(1'b1), 
        .Q(\registers[63][3] ) );
  DFFSR \registers_reg[63][2]  ( .D(n1272), .CLK(clk), .R(n2422), .S(1'b1), 
        .Q(\registers[63][2] ) );
  DFFSR \registers_reg[63][1]  ( .D(n1271), .CLK(clk), .R(n2422), .S(1'b1), 
        .Q(\registers[63][1] ) );
  DFFSR \registers_reg[55][0]  ( .D(n1342), .CLK(clk), .R(n2421), .S(1'b1), 
        .Q(\registers[55][0] ) );
  DFFSR \registers_reg[55][7]  ( .D(n1341), .CLK(clk), .R(n2421), .S(1'b1), 
        .Q(\registers[55][7] ) );
  DFFSR \registers_reg[55][6]  ( .D(n1340), .CLK(clk), .R(n2421), .S(1'b1), 
        .Q(\registers[55][6] ) );
  DFFSR \registers_reg[55][5]  ( .D(n1339), .CLK(clk), .R(n2421), .S(1'b1), 
        .Q(\registers[55][5] ) );
  DFFSR \registers_reg[55][4]  ( .D(n1338), .CLK(clk), .R(n2421), .S(1'b1), 
        .Q(\registers[55][4] ) );
  DFFSR \registers_reg[55][3]  ( .D(n1337), .CLK(clk), .R(n2421), .S(1'b1), 
        .Q(\registers[55][3] ) );
  DFFSR \registers_reg[55][2]  ( .D(n1336), .CLK(clk), .R(n2421), .S(1'b1), 
        .Q(\registers[55][2] ) );
  DFFSR \registers_reg[55][1]  ( .D(n1335), .CLK(clk), .R(n2421), .S(1'b1), 
        .Q(\registers[55][1] ) );
  DFFSR \registers_reg[47][0]  ( .D(n1406), .CLK(clk), .R(n2421), .S(1'b1), 
        .Q(\registers[47][0] ) );
  DFFSR \registers_reg[47][7]  ( .D(n1405), .CLK(clk), .R(n2421), .S(1'b1), 
        .Q(\registers[47][7] ) );
  DFFSR \registers_reg[47][6]  ( .D(n1404), .CLK(clk), .R(n2421), .S(1'b1), 
        .Q(\registers[47][6] ) );
  DFFSR \registers_reg[47][5]  ( .D(n1403), .CLK(clk), .R(n2421), .S(1'b1), 
        .Q(\registers[47][5] ) );
  DFFSR \registers_reg[47][4]  ( .D(n1402), .CLK(clk), .R(n2420), .S(1'b1), 
        .Q(\registers[47][4] ) );
  DFFSR \registers_reg[47][3]  ( .D(n1401), .CLK(clk), .R(n2420), .S(1'b1), 
        .Q(\registers[47][3] ) );
  DFFSR \registers_reg[47][2]  ( .D(n1400), .CLK(clk), .R(n2420), .S(1'b1), 
        .Q(\registers[47][2] ) );
  DFFSR \registers_reg[47][1]  ( .D(n1399), .CLK(clk), .R(n2420), .S(1'b1), 
        .Q(\registers[47][1] ) );
  DFFSR \registers_reg[39][0]  ( .D(n1470), .CLK(clk), .R(n2420), .S(1'b1), 
        .Q(\registers[39][0] ) );
  DFFSR \registers_reg[39][7]  ( .D(n1469), .CLK(clk), .R(n2420), .S(1'b1), 
        .Q(\registers[39][7] ) );
  DFFSR \registers_reg[39][6]  ( .D(n1468), .CLK(clk), .R(n2420), .S(1'b1), 
        .Q(\registers[39][6] ) );
  DFFSR \registers_reg[39][5]  ( .D(n1467), .CLK(clk), .R(n2420), .S(1'b1), 
        .Q(\registers[39][5] ) );
  DFFSR \registers_reg[39][4]  ( .D(n1466), .CLK(clk), .R(n2420), .S(1'b1), 
        .Q(\registers[39][4] ) );
  DFFSR \registers_reg[39][3]  ( .D(n1465), .CLK(clk), .R(n2420), .S(1'b1), 
        .Q(\registers[39][3] ) );
  DFFSR \registers_reg[39][2]  ( .D(n1464), .CLK(clk), .R(n2420), .S(1'b1), 
        .Q(\registers[39][2] ) );
  DFFSR \registers_reg[39][1]  ( .D(n1463), .CLK(clk), .R(n2420), .S(1'b1), 
        .Q(\registers[39][1] ) );
  DFFSR \registers_reg[31][0]  ( .D(n1534), .CLK(clk), .R(n2419), .S(1'b1), 
        .Q(\registers[31][0] ) );
  DFFSR \registers_reg[31][7]  ( .D(n1533), .CLK(clk), .R(n2419), .S(1'b1), 
        .Q(\registers[31][7] ) );
  DFFSR \registers_reg[31][6]  ( .D(n1532), .CLK(clk), .R(n2419), .S(1'b1), 
        .Q(\registers[31][6] ) );
  DFFSR \registers_reg[31][5]  ( .D(n1531), .CLK(clk), .R(n2419), .S(1'b1), 
        .Q(\registers[31][5] ) );
  DFFSR \registers_reg[31][4]  ( .D(n1530), .CLK(clk), .R(n2419), .S(1'b1), 
        .Q(\registers[31][4] ) );
  DFFSR \registers_reg[31][3]  ( .D(n1529), .CLK(clk), .R(n2419), .S(1'b1), 
        .Q(\registers[31][3] ) );
  DFFSR \registers_reg[31][2]  ( .D(n1528), .CLK(clk), .R(n2419), .S(1'b1), 
        .Q(\registers[31][2] ) );
  DFFSR \registers_reg[31][1]  ( .D(n1527), .CLK(clk), .R(n2419), .S(1'b1), 
        .Q(\registers[31][1] ) );
  DFFSR \registers_reg[23][0]  ( .D(n1598), .CLK(clk), .R(n2419), .S(1'b1), 
        .Q(\registers[23][0] ) );
  DFFSR \registers_reg[23][7]  ( .D(n1597), .CLK(clk), .R(n2419), .S(1'b1), 
        .Q(\registers[23][7] ) );
  DFFSR \registers_reg[23][6]  ( .D(n1596), .CLK(clk), .R(n2419), .S(1'b1), 
        .Q(\registers[23][6] ) );
  DFFSR \registers_reg[23][5]  ( .D(n1595), .CLK(clk), .R(n2419), .S(1'b1), 
        .Q(\registers[23][5] ) );
  DFFSR \registers_reg[23][4]  ( .D(n1594), .CLK(clk), .R(n2418), .S(1'b1), 
        .Q(\registers[23][4] ) );
  DFFSR \registers_reg[23][3]  ( .D(n1593), .CLK(clk), .R(n2418), .S(1'b1), 
        .Q(\registers[23][3] ) );
  DFFSR \registers_reg[23][2]  ( .D(n1592), .CLK(clk), .R(n2418), .S(1'b1), 
        .Q(\registers[23][2] ) );
  DFFSR \registers_reg[23][1]  ( .D(n1591), .CLK(clk), .R(n2418), .S(1'b1), 
        .Q(\registers[23][1] ) );
  DFFSR \registers_reg[15][0]  ( .D(n1662), .CLK(clk), .R(n2418), .S(1'b1), 
        .Q(\registers[15][0] ) );
  DFFSR \registers_reg[15][7]  ( .D(n1661), .CLK(clk), .R(n2418), .S(1'b1), 
        .Q(\registers[15][7] ) );
  DFFSR \registers_reg[15][6]  ( .D(n1660), .CLK(clk), .R(n2418), .S(1'b1), 
        .Q(\registers[15][6] ) );
  DFFSR \registers_reg[15][5]  ( .D(n1659), .CLK(clk), .R(n2418), .S(1'b1), 
        .Q(\registers[15][5] ) );
  DFFSR \registers_reg[15][4]  ( .D(n1658), .CLK(clk), .R(n2418), .S(1'b1), 
        .Q(\registers[15][4] ) );
  DFFSR \registers_reg[15][3]  ( .D(n1657), .CLK(clk), .R(n2418), .S(1'b1), 
        .Q(\registers[15][3] ) );
  DFFSR \registers_reg[15][2]  ( .D(n1656), .CLK(clk), .R(n2418), .S(1'b1), 
        .Q(\registers[15][2] ) );
  DFFSR \registers_reg[15][1]  ( .D(n1655), .CLK(clk), .R(n2418), .S(1'b1), 
        .Q(\registers[15][1] ) );
  DFFSR \registers_reg[7][0]  ( .D(n1726), .CLK(clk), .R(n2417), .S(1'b1), .Q(
        \registers[7][0] ) );
  DFFSR \registers_reg[7][7]  ( .D(n1725), .CLK(clk), .R(n2417), .S(1'b1), .Q(
        \registers[7][7] ) );
  DFFSR \registers_reg[7][6]  ( .D(n1724), .CLK(clk), .R(n2417), .S(1'b1), .Q(
        \registers[7][6] ) );
  DFFSR \registers_reg[7][5]  ( .D(n1723), .CLK(clk), .R(n2417), .S(1'b1), .Q(
        \registers[7][5] ) );
  DFFSR \registers_reg[7][4]  ( .D(n1722), .CLK(clk), .R(n2417), .S(1'b1), .Q(
        \registers[7][4] ) );
  DFFSR \registers_reg[7][3]  ( .D(n1721), .CLK(clk), .R(n2417), .S(1'b1), .Q(
        \registers[7][3] ) );
  DFFSR \registers_reg[7][2]  ( .D(n1720), .CLK(clk), .R(n2417), .S(1'b1), .Q(
        \registers[7][2] ) );
  DFFSR \registers_reg[7][1]  ( .D(n1719), .CLK(clk), .R(n2417), .S(1'b1), .Q(
        \registers[7][1] ) );
  DFFSR \registers_reg[56][0]  ( .D(n1334), .CLK(clk), .R(n2417), .S(1'b1), 
        .Q(\registers[56][0] ) );
  DFFSR \registers_reg[56][7]  ( .D(n1333), .CLK(clk), .R(n2417), .S(1'b1), 
        .Q(\registers[56][7] ) );
  DFFSR \registers_reg[56][6]  ( .D(n1332), .CLK(clk), .R(n2417), .S(1'b1), 
        .Q(\registers[56][6] ) );
  DFFSR \registers_reg[56][5]  ( .D(n1331), .CLK(clk), .R(n2417), .S(1'b1), 
        .Q(\registers[56][5] ) );
  DFFSR \registers_reg[56][4]  ( .D(n1330), .CLK(clk), .R(n2416), .S(1'b1), 
        .Q(\registers[56][4] ) );
  DFFSR \registers_reg[56][3]  ( .D(n1329), .CLK(clk), .R(n2416), .S(1'b1), 
        .Q(\registers[56][3] ) );
  DFFSR \registers_reg[56][2]  ( .D(n1328), .CLK(clk), .R(n2416), .S(1'b1), 
        .Q(\registers[56][2] ) );
  DFFSR \registers_reg[56][1]  ( .D(n1327), .CLK(clk), .R(n2416), .S(1'b1), 
        .Q(\registers[56][1] ) );
  DFFSR \registers_reg[48][0]  ( .D(n1398), .CLK(clk), .R(n2416), .S(1'b1), 
        .Q(\registers[48][0] ) );
  DFFSR \registers_reg[48][7]  ( .D(n1397), .CLK(clk), .R(n2416), .S(1'b1), 
        .Q(\registers[48][7] ) );
  DFFSR \registers_reg[48][6]  ( .D(n1396), .CLK(clk), .R(n2416), .S(1'b1), 
        .Q(\registers[48][6] ) );
  DFFSR \registers_reg[48][5]  ( .D(n1395), .CLK(clk), .R(n2416), .S(1'b1), 
        .Q(\registers[48][5] ) );
  DFFSR \registers_reg[48][4]  ( .D(n1394), .CLK(clk), .R(n2416), .S(1'b1), 
        .Q(\registers[48][4] ) );
  DFFSR \registers_reg[48][3]  ( .D(n1393), .CLK(clk), .R(n2416), .S(1'b1), 
        .Q(\registers[48][3] ) );
  DFFSR \registers_reg[48][2]  ( .D(n1392), .CLK(clk), .R(n2416), .S(1'b1), 
        .Q(\registers[48][2] ) );
  DFFSR \registers_reg[48][1]  ( .D(n1391), .CLK(clk), .R(n2416), .S(1'b1), 
        .Q(\registers[48][1] ) );
  DFFSR \registers_reg[40][0]  ( .D(n1462), .CLK(clk), .R(n2415), .S(1'b1), 
        .Q(\registers[40][0] ) );
  DFFSR \registers_reg[40][7]  ( .D(n1461), .CLK(clk), .R(n2415), .S(1'b1), 
        .Q(\registers[40][7] ) );
  DFFSR \registers_reg[40][6]  ( .D(n1460), .CLK(clk), .R(n2415), .S(1'b1), 
        .Q(\registers[40][6] ) );
  DFFSR \registers_reg[40][5]  ( .D(n1459), .CLK(clk), .R(n2415), .S(1'b1), 
        .Q(\registers[40][5] ) );
  DFFSR \registers_reg[40][4]  ( .D(n1458), .CLK(clk), .R(n2415), .S(1'b1), 
        .Q(\registers[40][4] ) );
  DFFSR \registers_reg[40][3]  ( .D(n1457), .CLK(clk), .R(n2415), .S(1'b1), 
        .Q(\registers[40][3] ) );
  DFFSR \registers_reg[40][2]  ( .D(n1456), .CLK(clk), .R(n2415), .S(1'b1), 
        .Q(\registers[40][2] ) );
  DFFSR \registers_reg[40][1]  ( .D(n1455), .CLK(clk), .R(n2415), .S(1'b1), 
        .Q(\registers[40][1] ) );
  DFFSR \registers_reg[32][0]  ( .D(n1526), .CLK(clk), .R(n2415), .S(1'b1), 
        .Q(\registers[32][0] ) );
  DFFSR \registers_reg[32][7]  ( .D(n1525), .CLK(clk), .R(n2415), .S(1'b1), 
        .Q(\registers[32][7] ) );
  DFFSR \registers_reg[32][6]  ( .D(n1524), .CLK(clk), .R(n2415), .S(1'b1), 
        .Q(\registers[32][6] ) );
  DFFSR \registers_reg[32][5]  ( .D(n1523), .CLK(clk), .R(n2415), .S(1'b1), 
        .Q(\registers[32][5] ) );
  DFFSR \registers_reg[32][4]  ( .D(n1522), .CLK(clk), .R(n2414), .S(1'b1), 
        .Q(\registers[32][4] ) );
  DFFSR \registers_reg[32][3]  ( .D(n1521), .CLK(clk), .R(n2414), .S(1'b1), 
        .Q(\registers[32][3] ) );
  DFFSR \registers_reg[32][2]  ( .D(n1520), .CLK(clk), .R(n2414), .S(1'b1), 
        .Q(\registers[32][2] ) );
  DFFSR \registers_reg[32][1]  ( .D(n1519), .CLK(clk), .R(n2414), .S(1'b1), 
        .Q(\registers[32][1] ) );
  DFFSR \registers_reg[24][0]  ( .D(n1590), .CLK(clk), .R(n2414), .S(1'b1), 
        .Q(\registers[24][0] ) );
  DFFSR \registers_reg[24][7]  ( .D(n1589), .CLK(clk), .R(n2414), .S(1'b1), 
        .Q(\registers[24][7] ) );
  DFFSR \registers_reg[24][6]  ( .D(n1588), .CLK(clk), .R(n2414), .S(1'b1), 
        .Q(\registers[24][6] ) );
  DFFSR \registers_reg[24][5]  ( .D(n1587), .CLK(clk), .R(n2414), .S(1'b1), 
        .Q(\registers[24][5] ) );
  DFFSR \registers_reg[24][4]  ( .D(n1586), .CLK(clk), .R(n2414), .S(1'b1), 
        .Q(\registers[24][4] ) );
  DFFSR \registers_reg[24][3]  ( .D(n1585), .CLK(clk), .R(n2414), .S(1'b1), 
        .Q(\registers[24][3] ) );
  DFFSR \registers_reg[24][2]  ( .D(n1584), .CLK(clk), .R(n2414), .S(1'b1), 
        .Q(\registers[24][2] ) );
  DFFSR \registers_reg[24][1]  ( .D(n1583), .CLK(clk), .R(n2414), .S(1'b1), 
        .Q(\registers[24][1] ) );
  DFFSR \registers_reg[16][0]  ( .D(n1654), .CLK(clk), .R(n2413), .S(1'b1), 
        .Q(\registers[16][0] ) );
  DFFSR \registers_reg[16][7]  ( .D(n1653), .CLK(clk), .R(n2413), .S(1'b1), 
        .Q(\registers[16][7] ) );
  DFFSR \registers_reg[16][6]  ( .D(n1652), .CLK(clk), .R(n2413), .S(1'b1), 
        .Q(\registers[16][6] ) );
  DFFSR \registers_reg[16][5]  ( .D(n1651), .CLK(clk), .R(n2413), .S(1'b1), 
        .Q(\registers[16][5] ) );
  DFFSR \registers_reg[16][4]  ( .D(n1650), .CLK(clk), .R(n2413), .S(1'b1), 
        .Q(\registers[16][4] ) );
  DFFSR \registers_reg[16][3]  ( .D(n1649), .CLK(clk), .R(n2413), .S(1'b1), 
        .Q(\registers[16][3] ) );
  DFFSR \registers_reg[16][2]  ( .D(n1648), .CLK(clk), .R(n2413), .S(1'b1), 
        .Q(\registers[16][2] ) );
  DFFSR \registers_reg[16][1]  ( .D(n1647), .CLK(clk), .R(n2413), .S(1'b1), 
        .Q(\registers[16][1] ) );
  DFFSR \registers_reg[8][0]  ( .D(n1718), .CLK(clk), .R(n2413), .S(1'b1), .Q(
        \registers[8][0] ) );
  DFFSR \registers_reg[8][7]  ( .D(n1717), .CLK(clk), .R(n2413), .S(1'b1), .Q(
        \registers[8][7] ) );
  DFFSR \registers_reg[8][6]  ( .D(n1716), .CLK(clk), .R(n2413), .S(1'b1), .Q(
        \registers[8][6] ) );
  DFFSR \registers_reg[8][5]  ( .D(n1715), .CLK(clk), .R(n2413), .S(1'b1), .Q(
        \registers[8][5] ) );
  DFFSR \registers_reg[8][4]  ( .D(n1714), .CLK(clk), .R(n2412), .S(1'b1), .Q(
        \registers[8][4] ) );
  DFFSR \registers_reg[8][3]  ( .D(n1713), .CLK(clk), .R(n2412), .S(1'b1), .Q(
        \registers[8][3] ) );
  DFFSR \registers_reg[8][2]  ( .D(n1712), .CLK(clk), .R(n2412), .S(1'b1), .Q(
        \registers[8][2] ) );
  DFFSR \registers_reg[8][1]  ( .D(n1711), .CLK(clk), .R(n2412), .S(1'b1), .Q(
        \registers[8][1] ) );
  DFFSR \registers_reg[0][0]  ( .D(n1782), .CLK(clk), .R(n2412), .S(1'b1), .Q(
        \registers[0][0] ) );
  DFFSR \registers_reg[0][7]  ( .D(n1781), .CLK(clk), .R(n2412), .S(1'b1), .Q(
        \registers[0][7] ) );
  DFFSR \registers_reg[0][6]  ( .D(n1780), .CLK(clk), .R(n2412), .S(1'b1), .Q(
        \registers[0][6] ) );
  DFFSR \registers_reg[0][5]  ( .D(n1779), .CLK(clk), .R(n2412), .S(1'b1), .Q(
        \registers[0][5] ) );
  DFFSR \registers_reg[0][4]  ( .D(n1778), .CLK(clk), .R(n2412), .S(1'b1), .Q(
        \registers[0][4] ) );
  DFFSR \registers_reg[0][3]  ( .D(n1777), .CLK(clk), .R(n2412), .S(1'b1), .Q(
        \registers[0][3] ) );
  DFFSR \registers_reg[0][2]  ( .D(n1776), .CLK(clk), .R(n2412), .S(1'b1), .Q(
        \registers[0][2] ) );
  DFFSR \registers_reg[0][1]  ( .D(n1775), .CLK(clk), .R(n2412), .S(1'b1), .Q(
        \registers[0][1] ) );
  DFFSR \registers_reg[58][0]  ( .D(n1318), .CLK(clk), .R(n2411), .S(1'b1), 
        .Q(\registers[58][0] ) );
  DFFSR \registers_reg[58][7]  ( .D(n1317), .CLK(clk), .R(n2411), .S(1'b1), 
        .Q(\registers[58][7] ) );
  DFFSR \registers_reg[58][6]  ( .D(n1316), .CLK(clk), .R(n2411), .S(1'b1), 
        .Q(\registers[58][6] ) );
  DFFSR \registers_reg[58][5]  ( .D(n1315), .CLK(clk), .R(n2411), .S(1'b1), 
        .Q(\registers[58][5] ) );
  DFFSR \registers_reg[58][4]  ( .D(n1314), .CLK(clk), .R(n2411), .S(1'b1), 
        .Q(\registers[58][4] ) );
  DFFSR \registers_reg[58][3]  ( .D(n1313), .CLK(clk), .R(n2411), .S(1'b1), 
        .Q(\registers[58][3] ) );
  DFFSR \registers_reg[58][2]  ( .D(n1312), .CLK(clk), .R(n2411), .S(1'b1), 
        .Q(\registers[58][2] ) );
  DFFSR \registers_reg[58][1]  ( .D(n1311), .CLK(clk), .R(n2411), .S(1'b1), 
        .Q(\registers[58][1] ) );
  DFFSR \registers_reg[50][0]  ( .D(n1382), .CLK(clk), .R(n2411), .S(1'b1), 
        .Q(\registers[50][0] ) );
  DFFSR \registers_reg[50][7]  ( .D(n1381), .CLK(clk), .R(n2411), .S(1'b1), 
        .Q(\registers[50][7] ) );
  DFFSR \registers_reg[50][6]  ( .D(n1380), .CLK(clk), .R(n2411), .S(1'b1), 
        .Q(\registers[50][6] ) );
  DFFSR \registers_reg[50][5]  ( .D(n1379), .CLK(clk), .R(n2411), .S(1'b1), 
        .Q(\registers[50][5] ) );
  DFFSR \registers_reg[50][4]  ( .D(n1378), .CLK(clk), .R(n2410), .S(1'b1), 
        .Q(\registers[50][4] ) );
  DFFSR \registers_reg[50][3]  ( .D(n1377), .CLK(clk), .R(n2410), .S(1'b1), 
        .Q(\registers[50][3] ) );
  DFFSR \registers_reg[50][2]  ( .D(n1376), .CLK(clk), .R(n2410), .S(1'b1), 
        .Q(\registers[50][2] ) );
  DFFSR \registers_reg[50][1]  ( .D(n1375), .CLK(clk), .R(n2410), .S(1'b1), 
        .Q(\registers[50][1] ) );
  DFFSR \registers_reg[42][0]  ( .D(n1446), .CLK(clk), .R(n2410), .S(1'b1), 
        .Q(\registers[42][0] ) );
  DFFSR \registers_reg[42][7]  ( .D(n1445), .CLK(clk), .R(n2410), .S(1'b1), 
        .Q(\registers[42][7] ) );
  DFFSR \registers_reg[42][6]  ( .D(n1444), .CLK(clk), .R(n2410), .S(1'b1), 
        .Q(\registers[42][6] ) );
  DFFSR \registers_reg[42][5]  ( .D(n1443), .CLK(clk), .R(n2410), .S(1'b1), 
        .Q(\registers[42][5] ) );
  DFFSR \registers_reg[42][4]  ( .D(n1442), .CLK(clk), .R(n2410), .S(1'b1), 
        .Q(\registers[42][4] ) );
  DFFSR \registers_reg[42][3]  ( .D(n1441), .CLK(clk), .R(n2410), .S(1'b1), 
        .Q(\registers[42][3] ) );
  DFFSR \registers_reg[42][2]  ( .D(n1440), .CLK(clk), .R(n2410), .S(1'b1), 
        .Q(\registers[42][2] ) );
  DFFSR \registers_reg[42][1]  ( .D(n1439), .CLK(clk), .R(n2410), .S(1'b1), 
        .Q(\registers[42][1] ) );
  DFFSR \registers_reg[34][0]  ( .D(n1510), .CLK(clk), .R(n2409), .S(1'b1), 
        .Q(\registers[34][0] ) );
  DFFSR \registers_reg[34][7]  ( .D(n1509), .CLK(clk), .R(n2409), .S(1'b1), 
        .Q(\registers[34][7] ) );
  DFFSR \registers_reg[34][6]  ( .D(n1508), .CLK(clk), .R(n2409), .S(1'b1), 
        .Q(\registers[34][6] ) );
  DFFSR \registers_reg[34][5]  ( .D(n1507), .CLK(clk), .R(n2409), .S(1'b1), 
        .Q(\registers[34][5] ) );
  DFFSR \registers_reg[34][4]  ( .D(n1506), .CLK(clk), .R(n2409), .S(1'b1), 
        .Q(\registers[34][4] ) );
  DFFSR \registers_reg[34][3]  ( .D(n1505), .CLK(clk), .R(n2409), .S(1'b1), 
        .Q(\registers[34][3] ) );
  DFFSR \registers_reg[34][2]  ( .D(n1504), .CLK(clk), .R(n2409), .S(1'b1), 
        .Q(\registers[34][2] ) );
  DFFSR \registers_reg[34][1]  ( .D(n1503), .CLK(clk), .R(n2409), .S(1'b1), 
        .Q(\registers[34][1] ) );
  DFFSR \registers_reg[26][0]  ( .D(n1574), .CLK(clk), .R(n2409), .S(1'b1), 
        .Q(\registers[26][0] ) );
  DFFSR \registers_reg[26][7]  ( .D(n1573), .CLK(clk), .R(n2409), .S(1'b1), 
        .Q(\registers[26][7] ) );
  DFFSR \registers_reg[26][6]  ( .D(n1572), .CLK(clk), .R(n2409), .S(1'b1), 
        .Q(\registers[26][6] ) );
  DFFSR \registers_reg[26][5]  ( .D(n1571), .CLK(clk), .R(n2409), .S(1'b1), 
        .Q(\registers[26][5] ) );
  DFFSR \registers_reg[26][4]  ( .D(n1570), .CLK(clk), .R(n2408), .S(1'b1), 
        .Q(\registers[26][4] ) );
  DFFSR \registers_reg[26][3]  ( .D(n1569), .CLK(clk), .R(n2408), .S(1'b1), 
        .Q(\registers[26][3] ) );
  DFFSR \registers_reg[26][2]  ( .D(n1568), .CLK(clk), .R(n2408), .S(1'b1), 
        .Q(\registers[26][2] ) );
  DFFSR \registers_reg[26][1]  ( .D(n1567), .CLK(clk), .R(n2408), .S(1'b1), 
        .Q(\registers[26][1] ) );
  DFFSR \registers_reg[18][0]  ( .D(n1638), .CLK(clk), .R(n2408), .S(1'b1), 
        .Q(\registers[18][0] ) );
  DFFSR \registers_reg[18][7]  ( .D(n1637), .CLK(clk), .R(n2408), .S(1'b1), 
        .Q(\registers[18][7] ) );
  DFFSR \registers_reg[18][6]  ( .D(n1636), .CLK(clk), .R(n2408), .S(1'b1), 
        .Q(\registers[18][6] ) );
  DFFSR \registers_reg[18][5]  ( .D(n1635), .CLK(clk), .R(n2408), .S(1'b1), 
        .Q(\registers[18][5] ) );
  DFFSR \registers_reg[18][4]  ( .D(n1634), .CLK(clk), .R(n2408), .S(1'b1), 
        .Q(\registers[18][4] ) );
  DFFSR \registers_reg[18][3]  ( .D(n1633), .CLK(clk), .R(n2408), .S(1'b1), 
        .Q(\registers[18][3] ) );
  DFFSR \registers_reg[18][2]  ( .D(n1632), .CLK(clk), .R(n2408), .S(1'b1), 
        .Q(\registers[18][2] ) );
  DFFSR \registers_reg[18][1]  ( .D(n1631), .CLK(clk), .R(n2408), .S(1'b1), 
        .Q(\registers[18][1] ) );
  DFFSR \registers_reg[10][0]  ( .D(n1702), .CLK(clk), .R(n2407), .S(1'b1), 
        .Q(\registers[10][0] ) );
  DFFSR \registers_reg[10][7]  ( .D(n1701), .CLK(clk), .R(n2407), .S(1'b1), 
        .Q(\registers[10][7] ) );
  DFFSR \registers_reg[10][6]  ( .D(n1700), .CLK(clk), .R(n2407), .S(1'b1), 
        .Q(\registers[10][6] ) );
  DFFSR \registers_reg[10][5]  ( .D(n1699), .CLK(clk), .R(n2407), .S(1'b1), 
        .Q(\registers[10][5] ) );
  DFFSR \registers_reg[10][4]  ( .D(n1698), .CLK(clk), .R(n2407), .S(1'b1), 
        .Q(\registers[10][4] ) );
  DFFSR \registers_reg[10][3]  ( .D(n1697), .CLK(clk), .R(n2407), .S(1'b1), 
        .Q(\registers[10][3] ) );
  DFFSR \registers_reg[10][2]  ( .D(n1696), .CLK(clk), .R(n2407), .S(1'b1), 
        .Q(\registers[10][2] ) );
  DFFSR \registers_reg[10][1]  ( .D(n1695), .CLK(clk), .R(n2407), .S(1'b1), 
        .Q(\registers[10][1] ) );
  DFFSR \registers_reg[2][0]  ( .D(n1766), .CLK(clk), .R(n2407), .S(1'b1), .Q(
        \registers[2][0] ) );
  DFFSR \registers_reg[2][7]  ( .D(n1765), .CLK(clk), .R(n2407), .S(1'b1), .Q(
        \registers[2][7] ) );
  DFFSR \registers_reg[2][6]  ( .D(n1764), .CLK(clk), .R(n2407), .S(1'b1), .Q(
        \registers[2][6] ) );
  DFFSR \registers_reg[2][5]  ( .D(n1763), .CLK(clk), .R(n2407), .S(1'b1), .Q(
        \registers[2][5] ) );
  DFFSR \registers_reg[2][4]  ( .D(n1762), .CLK(clk), .R(n2406), .S(1'b1), .Q(
        \registers[2][4] ) );
  DFFSR \registers_reg[2][3]  ( .D(n1761), .CLK(clk), .R(n2406), .S(1'b1), .Q(
        \registers[2][3] ) );
  DFFSR \registers_reg[2][2]  ( .D(n1760), .CLK(clk), .R(n2406), .S(1'b1), .Q(
        \registers[2][2] ) );
  DFFSR \registers_reg[2][1]  ( .D(n1759), .CLK(clk), .R(n2406), .S(1'b1), .Q(
        \registers[2][1] ) );
  DFFSR \registers_reg[60][0]  ( .D(n1302), .CLK(clk), .R(n2406), .S(1'b1), 
        .Q(\registers[60][0] ) );
  DFFSR \registers_reg[60][7]  ( .D(n1301), .CLK(clk), .R(n2406), .S(1'b1), 
        .Q(\registers[60][7] ) );
  DFFSR \registers_reg[60][6]  ( .D(n1300), .CLK(clk), .R(n2406), .S(1'b1), 
        .Q(\registers[60][6] ) );
  DFFSR \registers_reg[60][5]  ( .D(n1299), .CLK(clk), .R(n2406), .S(1'b1), 
        .Q(\registers[60][5] ) );
  DFFSR \registers_reg[60][4]  ( .D(n1298), .CLK(clk), .R(n2406), .S(1'b1), 
        .Q(\registers[60][4] ) );
  DFFSR \registers_reg[60][3]  ( .D(n1297), .CLK(clk), .R(n2406), .S(1'b1), 
        .Q(\registers[60][3] ) );
  DFFSR \registers_reg[60][2]  ( .D(n1296), .CLK(clk), .R(n2406), .S(1'b1), 
        .Q(\registers[60][2] ) );
  DFFSR \registers_reg[60][1]  ( .D(n1295), .CLK(clk), .R(n2406), .S(1'b1), 
        .Q(\registers[60][1] ) );
  DFFSR \registers_reg[52][0]  ( .D(n1366), .CLK(clk), .R(n2405), .S(1'b1), 
        .Q(\registers[52][0] ) );
  DFFSR \registers_reg[52][7]  ( .D(n1365), .CLK(clk), .R(n2405), .S(1'b1), 
        .Q(\registers[52][7] ) );
  DFFSR \registers_reg[52][6]  ( .D(n1364), .CLK(clk), .R(n2405), .S(1'b1), 
        .Q(\registers[52][6] ) );
  DFFSR \registers_reg[52][5]  ( .D(n1363), .CLK(clk), .R(n2405), .S(1'b1), 
        .Q(\registers[52][5] ) );
  DFFSR \registers_reg[52][4]  ( .D(n1362), .CLK(clk), .R(n2405), .S(1'b1), 
        .Q(\registers[52][4] ) );
  DFFSR \registers_reg[52][3]  ( .D(n1361), .CLK(clk), .R(n2405), .S(1'b1), 
        .Q(\registers[52][3] ) );
  DFFSR \registers_reg[52][2]  ( .D(n1360), .CLK(clk), .R(n2405), .S(1'b1), 
        .Q(\registers[52][2] ) );
  DFFSR \registers_reg[52][1]  ( .D(n1359), .CLK(clk), .R(n2405), .S(1'b1), 
        .Q(\registers[52][1] ) );
  DFFSR \registers_reg[44][0]  ( .D(n1430), .CLK(clk), .R(n2405), .S(1'b1), 
        .Q(\registers[44][0] ) );
  DFFSR \registers_reg[44][7]  ( .D(n1429), .CLK(clk), .R(n2405), .S(1'b1), 
        .Q(\registers[44][7] ) );
  DFFSR \registers_reg[44][6]  ( .D(n1428), .CLK(clk), .R(n2405), .S(1'b1), 
        .Q(\registers[44][6] ) );
  DFFSR \registers_reg[44][5]  ( .D(n1427), .CLK(clk), .R(n2405), .S(1'b1), 
        .Q(\registers[44][5] ) );
  DFFSR \registers_reg[44][4]  ( .D(n1426), .CLK(clk), .R(n2404), .S(1'b1), 
        .Q(\registers[44][4] ) );
  DFFSR \registers_reg[44][3]  ( .D(n1425), .CLK(clk), .R(n2404), .S(1'b1), 
        .Q(\registers[44][3] ) );
  DFFSR \registers_reg[44][2]  ( .D(n1424), .CLK(clk), .R(n2404), .S(1'b1), 
        .Q(\registers[44][2] ) );
  DFFSR \registers_reg[44][1]  ( .D(n1423), .CLK(clk), .R(n2404), .S(1'b1), 
        .Q(\registers[44][1] ) );
  DFFSR \registers_reg[36][0]  ( .D(n1494), .CLK(clk), .R(n2404), .S(1'b1), 
        .Q(\registers[36][0] ) );
  DFFSR \registers_reg[36][7]  ( .D(n1493), .CLK(clk), .R(n2404), .S(1'b1), 
        .Q(\registers[36][7] ) );
  DFFSR \registers_reg[36][6]  ( .D(n1492), .CLK(clk), .R(n2404), .S(1'b1), 
        .Q(\registers[36][6] ) );
  DFFSR \registers_reg[36][5]  ( .D(n1491), .CLK(clk), .R(n2404), .S(1'b1), 
        .Q(\registers[36][5] ) );
  DFFSR \registers_reg[36][4]  ( .D(n1490), .CLK(clk), .R(n2404), .S(1'b1), 
        .Q(\registers[36][4] ) );
  DFFSR \registers_reg[36][3]  ( .D(n1489), .CLK(clk), .R(n2404), .S(1'b1), 
        .Q(\registers[36][3] ) );
  DFFSR \registers_reg[36][2]  ( .D(n1488), .CLK(clk), .R(n2404), .S(1'b1), 
        .Q(\registers[36][2] ) );
  DFFSR \registers_reg[36][1]  ( .D(n1487), .CLK(clk), .R(n2404), .S(1'b1), 
        .Q(\registers[36][1] ) );
  DFFSR \registers_reg[28][0]  ( .D(n1558), .CLK(clk), .R(n2403), .S(1'b1), 
        .Q(\registers[28][0] ) );
  DFFSR \registers_reg[28][7]  ( .D(n1557), .CLK(clk), .R(n2403), .S(1'b1), 
        .Q(\registers[28][7] ) );
  DFFSR \registers_reg[28][6]  ( .D(n1556), .CLK(clk), .R(n2403), .S(1'b1), 
        .Q(\registers[28][6] ) );
  DFFSR \registers_reg[28][5]  ( .D(n1555), .CLK(clk), .R(n2403), .S(1'b1), 
        .Q(\registers[28][5] ) );
  DFFSR \registers_reg[28][4]  ( .D(n1554), .CLK(clk), .R(n2403), .S(1'b1), 
        .Q(\registers[28][4] ) );
  DFFSR \registers_reg[28][3]  ( .D(n1553), .CLK(clk), .R(n2403), .S(1'b1), 
        .Q(\registers[28][3] ) );
  DFFSR \registers_reg[28][2]  ( .D(n1552), .CLK(clk), .R(n2403), .S(1'b1), 
        .Q(\registers[28][2] ) );
  DFFSR \registers_reg[28][1]  ( .D(n1551), .CLK(clk), .R(n2403), .S(1'b1), 
        .Q(\registers[28][1] ) );
  DFFSR \registers_reg[20][0]  ( .D(n1622), .CLK(clk), .R(n2403), .S(1'b1), 
        .Q(\registers[20][0] ) );
  DFFSR \registers_reg[20][7]  ( .D(n1621), .CLK(clk), .R(n2403), .S(1'b1), 
        .Q(\registers[20][7] ) );
  DFFSR \registers_reg[20][6]  ( .D(n1620), .CLK(clk), .R(n2403), .S(1'b1), 
        .Q(\registers[20][6] ) );
  DFFSR \registers_reg[20][5]  ( .D(n1619), .CLK(clk), .R(n2403), .S(1'b1), 
        .Q(\registers[20][5] ) );
  DFFSR \registers_reg[20][4]  ( .D(n1618), .CLK(clk), .R(n2402), .S(1'b1), 
        .Q(\registers[20][4] ) );
  DFFSR \registers_reg[20][3]  ( .D(n1617), .CLK(clk), .R(n2402), .S(1'b1), 
        .Q(\registers[20][3] ) );
  DFFSR \registers_reg[20][2]  ( .D(n1616), .CLK(clk), .R(n2402), .S(1'b1), 
        .Q(\registers[20][2] ) );
  DFFSR \registers_reg[20][1]  ( .D(n1615), .CLK(clk), .R(n2402), .S(1'b1), 
        .Q(\registers[20][1] ) );
  DFFSR \registers_reg[12][0]  ( .D(n1686), .CLK(clk), .R(n2402), .S(1'b1), 
        .Q(\registers[12][0] ) );
  DFFSR \registers_reg[12][7]  ( .D(n1685), .CLK(clk), .R(n2402), .S(1'b1), 
        .Q(\registers[12][7] ) );
  DFFSR \registers_reg[12][6]  ( .D(n1684), .CLK(clk), .R(n2402), .S(1'b1), 
        .Q(\registers[12][6] ) );
  DFFSR \registers_reg[12][5]  ( .D(n1683), .CLK(clk), .R(n2402), .S(1'b1), 
        .Q(\registers[12][5] ) );
  DFFSR \registers_reg[12][4]  ( .D(n1682), .CLK(clk), .R(n2402), .S(1'b1), 
        .Q(\registers[12][4] ) );
  DFFSR \registers_reg[12][3]  ( .D(n1681), .CLK(clk), .R(n2402), .S(1'b1), 
        .Q(\registers[12][3] ) );
  DFFSR \registers_reg[12][2]  ( .D(n1680), .CLK(clk), .R(n2402), .S(1'b1), 
        .Q(\registers[12][2] ) );
  DFFSR \registers_reg[12][1]  ( .D(n1679), .CLK(clk), .R(n2402), .S(1'b1), 
        .Q(\registers[12][1] ) );
  DFFSR \registers_reg[4][0]  ( .D(n1750), .CLK(clk), .R(n2401), .S(1'b1), .Q(
        \registers[4][0] ) );
  DFFSR \registers_reg[4][7]  ( .D(n1749), .CLK(clk), .R(n2401), .S(1'b1), .Q(
        \registers[4][7] ) );
  DFFSR \registers_reg[4][6]  ( .D(n1748), .CLK(clk), .R(n2401), .S(1'b1), .Q(
        \registers[4][6] ) );
  DFFSR \registers_reg[4][5]  ( .D(n1747), .CLK(clk), .R(n2401), .S(1'b1), .Q(
        \registers[4][5] ) );
  DFFSR \registers_reg[4][4]  ( .D(n1746), .CLK(clk), .R(n2401), .S(1'b1), .Q(
        \registers[4][4] ) );
  DFFSR \registers_reg[4][3]  ( .D(n1745), .CLK(clk), .R(n2401), .S(1'b1), .Q(
        \registers[4][3] ) );
  DFFSR \registers_reg[4][2]  ( .D(n1744), .CLK(clk), .R(n2401), .S(1'b1), .Q(
        \registers[4][2] ) );
  DFFSR \registers_reg[4][1]  ( .D(n1743), .CLK(clk), .R(n2401), .S(1'b1), .Q(
        \registers[4][1] ) );
  DFFSR \registers_reg[62][0]  ( .D(n1286), .CLK(clk), .R(n2401), .S(1'b1), 
        .Q(\registers[62][0] ) );
  DFFSR \registers_reg[62][7]  ( .D(n1285), .CLK(clk), .R(n2401), .S(1'b1), 
        .Q(\registers[62][7] ) );
  DFFSR \registers_reg[62][6]  ( .D(n1284), .CLK(clk), .R(n2401), .S(1'b1), 
        .Q(\registers[62][6] ) );
  DFFSR \registers_reg[62][5]  ( .D(n1283), .CLK(clk), .R(n2401), .S(1'b1), 
        .Q(\registers[62][5] ) );
  DFFSR \registers_reg[62][4]  ( .D(n1282), .CLK(clk), .R(n2400), .S(1'b1), 
        .Q(\registers[62][4] ) );
  DFFSR \registers_reg[62][3]  ( .D(n1281), .CLK(clk), .R(n2400), .S(1'b1), 
        .Q(\registers[62][3] ) );
  DFFSR \registers_reg[62][2]  ( .D(n1280), .CLK(clk), .R(n2400), .S(1'b1), 
        .Q(\registers[62][2] ) );
  DFFSR \registers_reg[62][1]  ( .D(n1279), .CLK(clk), .R(n2400), .S(1'b1), 
        .Q(\registers[62][1] ) );
  DFFSR \registers_reg[54][0]  ( .D(n1350), .CLK(clk), .R(n2400), .S(1'b1), 
        .Q(\registers[54][0] ) );
  DFFSR \registers_reg[54][7]  ( .D(n1349), .CLK(clk), .R(n2400), .S(1'b1), 
        .Q(\registers[54][7] ) );
  DFFSR \registers_reg[54][6]  ( .D(n1348), .CLK(clk), .R(n2400), .S(1'b1), 
        .Q(\registers[54][6] ) );
  DFFSR \registers_reg[54][5]  ( .D(n1347), .CLK(clk), .R(n2400), .S(1'b1), 
        .Q(\registers[54][5] ) );
  DFFSR \registers_reg[54][4]  ( .D(n1346), .CLK(clk), .R(n2400), .S(1'b1), 
        .Q(\registers[54][4] ) );
  DFFSR \registers_reg[54][3]  ( .D(n1345), .CLK(clk), .R(n2400), .S(1'b1), 
        .Q(\registers[54][3] ) );
  DFFSR \registers_reg[54][2]  ( .D(n1344), .CLK(clk), .R(n2400), .S(1'b1), 
        .Q(\registers[54][2] ) );
  DFFSR \registers_reg[54][1]  ( .D(n1343), .CLK(clk), .R(n2400), .S(1'b1), 
        .Q(\registers[54][1] ) );
  DFFSR \registers_reg[46][0]  ( .D(n1414), .CLK(clk), .R(n2399), .S(1'b1), 
        .Q(\registers[46][0] ) );
  DFFSR \registers_reg[46][7]  ( .D(n1413), .CLK(clk), .R(n2399), .S(1'b1), 
        .Q(\registers[46][7] ) );
  DFFSR \registers_reg[46][6]  ( .D(n1412), .CLK(clk), .R(n2399), .S(1'b1), 
        .Q(\registers[46][6] ) );
  DFFSR \registers_reg[46][5]  ( .D(n1411), .CLK(clk), .R(n2399), .S(1'b1), 
        .Q(\registers[46][5] ) );
  DFFSR \registers_reg[46][4]  ( .D(n1410), .CLK(clk), .R(n2399), .S(1'b1), 
        .Q(\registers[46][4] ) );
  DFFSR \registers_reg[46][3]  ( .D(n1409), .CLK(clk), .R(n2399), .S(1'b1), 
        .Q(\registers[46][3] ) );
  DFFSR \registers_reg[46][2]  ( .D(n1408), .CLK(clk), .R(n2399), .S(1'b1), 
        .Q(\registers[46][2] ) );
  DFFSR \registers_reg[46][1]  ( .D(n1407), .CLK(clk), .R(n2399), .S(1'b1), 
        .Q(\registers[46][1] ) );
  DFFSR \registers_reg[38][0]  ( .D(n1478), .CLK(clk), .R(n2399), .S(1'b1), 
        .Q(\registers[38][0] ) );
  DFFSR \registers_reg[38][7]  ( .D(n1477), .CLK(clk), .R(n2399), .S(1'b1), 
        .Q(\registers[38][7] ) );
  DFFSR \registers_reg[38][6]  ( .D(n1476), .CLK(clk), .R(n2399), .S(1'b1), 
        .Q(\registers[38][6] ) );
  DFFSR \registers_reg[38][5]  ( .D(n1475), .CLK(clk), .R(n2399), .S(1'b1), 
        .Q(\registers[38][5] ) );
  DFFSR \registers_reg[38][4]  ( .D(n1474), .CLK(clk), .R(n2398), .S(1'b1), 
        .Q(\registers[38][4] ) );
  DFFSR \registers_reg[38][3]  ( .D(n1473), .CLK(clk), .R(n2398), .S(1'b1), 
        .Q(\registers[38][3] ) );
  DFFSR \registers_reg[38][2]  ( .D(n1472), .CLK(clk), .R(n2398), .S(1'b1), 
        .Q(\registers[38][2] ) );
  DFFSR \registers_reg[38][1]  ( .D(n1471), .CLK(clk), .R(n2398), .S(1'b1), 
        .Q(\registers[38][1] ) );
  DFFSR \registers_reg[30][0]  ( .D(n1542), .CLK(clk), .R(n2398), .S(1'b1), 
        .Q(\registers[30][0] ) );
  DFFSR \registers_reg[30][7]  ( .D(n1541), .CLK(clk), .R(n2398), .S(1'b1), 
        .Q(\registers[30][7] ) );
  DFFSR \registers_reg[30][6]  ( .D(n1540), .CLK(clk), .R(n2398), .S(1'b1), 
        .Q(\registers[30][6] ) );
  DFFSR \registers_reg[30][5]  ( .D(n1539), .CLK(clk), .R(n2398), .S(1'b1), 
        .Q(\registers[30][5] ) );
  DFFSR \registers_reg[30][4]  ( .D(n1538), .CLK(clk), .R(n2398), .S(1'b1), 
        .Q(\registers[30][4] ) );
  DFFSR \registers_reg[30][3]  ( .D(n1537), .CLK(clk), .R(n2398), .S(1'b1), 
        .Q(\registers[30][3] ) );
  DFFSR \registers_reg[30][2]  ( .D(n1536), .CLK(clk), .R(n2398), .S(1'b1), 
        .Q(\registers[30][2] ) );
  DFFSR \registers_reg[30][1]  ( .D(n1535), .CLK(clk), .R(n2398), .S(1'b1), 
        .Q(\registers[30][1] ) );
  DFFSR \registers_reg[22][0]  ( .D(n1606), .CLK(clk), .R(n2397), .S(1'b1), 
        .Q(\registers[22][0] ) );
  DFFSR \registers_reg[22][7]  ( .D(n1605), .CLK(clk), .R(n2397), .S(1'b1), 
        .Q(\registers[22][7] ) );
  DFFSR \registers_reg[22][6]  ( .D(n1604), .CLK(clk), .R(n2397), .S(1'b1), 
        .Q(\registers[22][6] ) );
  DFFSR \registers_reg[22][5]  ( .D(n1603), .CLK(clk), .R(n2397), .S(1'b1), 
        .Q(\registers[22][5] ) );
  DFFSR \registers_reg[22][4]  ( .D(n1602), .CLK(clk), .R(n2397), .S(1'b1), 
        .Q(\registers[22][4] ) );
  DFFSR \registers_reg[22][3]  ( .D(n1601), .CLK(clk), .R(n2397), .S(1'b1), 
        .Q(\registers[22][3] ) );
  DFFSR \registers_reg[22][2]  ( .D(n1600), .CLK(clk), .R(n2397), .S(1'b1), 
        .Q(\registers[22][2] ) );
  DFFSR \registers_reg[22][1]  ( .D(n1599), .CLK(clk), .R(n2397), .S(1'b1), 
        .Q(\registers[22][1] ) );
  DFFSR \registers_reg[14][0]  ( .D(n1670), .CLK(clk), .R(n2397), .S(1'b1), 
        .Q(\registers[14][0] ) );
  DFFSR \registers_reg[14][7]  ( .D(n1669), .CLK(clk), .R(n2397), .S(1'b1), 
        .Q(\registers[14][7] ) );
  DFFSR \registers_reg[14][6]  ( .D(n1668), .CLK(clk), .R(n2397), .S(1'b1), 
        .Q(\registers[14][6] ) );
  DFFSR \registers_reg[14][5]  ( .D(n1667), .CLK(clk), .R(n2397), .S(1'b1), 
        .Q(\registers[14][5] ) );
  DFFSR \registers_reg[14][4]  ( .D(n1666), .CLK(clk), .R(n2396), .S(1'b1), 
        .Q(\registers[14][4] ) );
  DFFSR \registers_reg[14][3]  ( .D(n1665), .CLK(clk), .R(n2396), .S(1'b1), 
        .Q(\registers[14][3] ) );
  DFFSR \registers_reg[14][2]  ( .D(n1664), .CLK(clk), .R(n2396), .S(1'b1), 
        .Q(\registers[14][2] ) );
  DFFSR \registers_reg[14][1]  ( .D(n1663), .CLK(clk), .R(n2396), .S(1'b1), 
        .Q(\registers[14][1] ) );
  DFFSR \registers_reg[6][0]  ( .D(n1734), .CLK(clk), .R(n2396), .S(1'b1), .Q(
        \registers[6][0] ) );
  DFFSR \registers_reg[6][7]  ( .D(n1733), .CLK(clk), .R(n2396), .S(1'b1), .Q(
        \registers[6][7] ) );
  DFFSR \registers_reg[6][6]  ( .D(n1732), .CLK(clk), .R(n2396), .S(1'b1), .Q(
        \registers[6][6] ) );
  DFFSR \registers_reg[6][5]  ( .D(n1731), .CLK(clk), .R(n2396), .S(1'b1), .Q(
        \registers[6][5] ) );
  DFFSR \registers_reg[6][4]  ( .D(n1730), .CLK(clk), .R(n2396), .S(1'b1), .Q(
        \registers[6][4] ) );
  DFFSR \registers_reg[6][3]  ( .D(n1729), .CLK(clk), .R(n2396), .S(1'b1), .Q(
        \registers[6][3] ) );
  DFFSR \registers_reg[6][2]  ( .D(n1728), .CLK(clk), .R(n2396), .S(1'b1), .Q(
        \registers[6][2] ) );
  DFFSR \registers_reg[6][1]  ( .D(n1727), .CLK(clk), .R(n2396), .S(1'b1), .Q(
        \registers[6][1] ) );
  AND2X2 U536 ( .A(n1253), .B(n2337), .Y(n1246) );
  NOR2X1 U628 ( .A(n543), .B(n2532), .Y(tx_packet_data[7]) );
  NOR2X1 U629 ( .A(n2532), .B(n542), .Y(tx_packet_data[6]) );
  NOR2X1 U630 ( .A(n2532), .B(n541), .Y(tx_packet_data[5]) );
  NOR2X1 U631 ( .A(n2532), .B(n540), .Y(tx_packet_data[4]) );
  NOR2X1 U632 ( .A(n2532), .B(n539), .Y(tx_packet_data[3]) );
  NOR2X1 U633 ( .A(n2532), .B(n538), .Y(tx_packet_data[2]) );
  NOR2X1 U634 ( .A(n2532), .B(n537), .Y(tx_packet_data[1]) );
  NOR2X1 U635 ( .A(n2532), .B(n536), .Y(tx_packet_data[0]) );
  NOR2X1 U636 ( .A(n543), .B(n625), .Y(rx_data[7]) );
  NOR2X1 U637 ( .A(n542), .B(n625), .Y(rx_data[6]) );
  NOR2X1 U638 ( .A(n541), .B(n625), .Y(rx_data[5]) );
  NOR2X1 U639 ( .A(n540), .B(n625), .Y(rx_data[4]) );
  NOR2X1 U640 ( .A(n539), .B(n625), .Y(rx_data[3]) );
  NOR2X1 U641 ( .A(n538), .B(n625), .Y(rx_data[2]) );
  NOR2X1 U642 ( .A(n537), .B(n625), .Y(rx_data[1]) );
  NOR2X1 U643 ( .A(n536), .B(n625), .Y(rx_data[0]) );
  OAI21X1 U644 ( .A(n2528), .B(n2390), .C(n627), .Y(n1271) );
  NAND2X1 U645 ( .A(\registers[63][1] ), .B(n2528), .Y(n627) );
  OAI21X1 U646 ( .A(n2528), .B(n2384), .C(n629), .Y(n1272) );
  NAND2X1 U647 ( .A(\registers[63][2] ), .B(n2528), .Y(n629) );
  OAI21X1 U648 ( .A(n2528), .B(n2378), .C(n631), .Y(n1273) );
  NAND2X1 U649 ( .A(\registers[63][3] ), .B(n2528), .Y(n631) );
  OAI21X1 U650 ( .A(n2528), .B(n2372), .C(n633), .Y(n1274) );
  NAND2X1 U651 ( .A(\registers[63][4] ), .B(n2528), .Y(n633) );
  OAI21X1 U652 ( .A(n2528), .B(n2366), .C(n635), .Y(n1275) );
  NAND2X1 U653 ( .A(\registers[63][5] ), .B(n2528), .Y(n635) );
  OAI21X1 U654 ( .A(n2528), .B(n2360), .C(n637), .Y(n1276) );
  NAND2X1 U655 ( .A(\registers[63][6] ), .B(n2528), .Y(n637) );
  OAI21X1 U656 ( .A(n2528), .B(n2354), .C(n639), .Y(n1277) );
  NAND2X1 U657 ( .A(\registers[63][7] ), .B(n2528), .Y(n639) );
  OAI21X1 U658 ( .A(n2528), .B(n2348), .C(n641), .Y(n1278) );
  NAND2X1 U659 ( .A(\registers[63][0] ), .B(n2528), .Y(n641) );
  OAI21X1 U660 ( .A(n643), .B(n644), .C(n2337), .Y(n642) );
  OAI21X1 U661 ( .A(n2527), .B(n2390), .C(n646), .Y(n1279) );
  NAND2X1 U662 ( .A(\registers[62][1] ), .B(n2527), .Y(n646) );
  OAI21X1 U663 ( .A(n2527), .B(n2384), .C(n647), .Y(n1280) );
  NAND2X1 U664 ( .A(\registers[62][2] ), .B(n2527), .Y(n647) );
  OAI21X1 U665 ( .A(n2527), .B(n2378), .C(n648), .Y(n1281) );
  NAND2X1 U666 ( .A(\registers[62][3] ), .B(n2527), .Y(n648) );
  OAI21X1 U667 ( .A(n2527), .B(n2372), .C(n649), .Y(n1282) );
  NAND2X1 U668 ( .A(\registers[62][4] ), .B(n2527), .Y(n649) );
  OAI21X1 U669 ( .A(n2527), .B(n2366), .C(n650), .Y(n1283) );
  NAND2X1 U670 ( .A(\registers[62][5] ), .B(n2527), .Y(n650) );
  OAI21X1 U671 ( .A(n2527), .B(n2360), .C(n651), .Y(n1284) );
  NAND2X1 U672 ( .A(\registers[62][6] ), .B(n2527), .Y(n651) );
  OAI21X1 U673 ( .A(n2527), .B(n2354), .C(n652), .Y(n1285) );
  NAND2X1 U674 ( .A(\registers[62][7] ), .B(n2527), .Y(n652) );
  OAI21X1 U675 ( .A(n2527), .B(n2348), .C(n653), .Y(n1286) );
  NAND2X1 U676 ( .A(\registers[62][0] ), .B(n2527), .Y(n653) );
  OAI21X1 U677 ( .A(n643), .B(n655), .C(n2337), .Y(n654) );
  OAI21X1 U678 ( .A(n2526), .B(n2390), .C(n656), .Y(n1287) );
  NAND2X1 U679 ( .A(\registers[61][1] ), .B(n2526), .Y(n656) );
  OAI21X1 U680 ( .A(n2526), .B(n2384), .C(n657), .Y(n1288) );
  NAND2X1 U681 ( .A(\registers[61][2] ), .B(n2526), .Y(n657) );
  OAI21X1 U682 ( .A(n2526), .B(n2378), .C(n658), .Y(n1289) );
  NAND2X1 U683 ( .A(\registers[61][3] ), .B(n2526), .Y(n658) );
  OAI21X1 U684 ( .A(n2526), .B(n2372), .C(n659), .Y(n1290) );
  NAND2X1 U685 ( .A(\registers[61][4] ), .B(n2526), .Y(n659) );
  OAI21X1 U686 ( .A(n2526), .B(n2366), .C(n660), .Y(n1291) );
  NAND2X1 U687 ( .A(\registers[61][5] ), .B(n2526), .Y(n660) );
  OAI21X1 U688 ( .A(n2526), .B(n2360), .C(n661), .Y(n1292) );
  NAND2X1 U689 ( .A(\registers[61][6] ), .B(n2526), .Y(n661) );
  OAI21X1 U690 ( .A(n2526), .B(n2354), .C(n662), .Y(n1293) );
  NAND2X1 U691 ( .A(\registers[61][7] ), .B(n2526), .Y(n662) );
  OAI21X1 U692 ( .A(n2526), .B(n2348), .C(n663), .Y(n1294) );
  NAND2X1 U693 ( .A(\registers[61][0] ), .B(n2526), .Y(n663) );
  OAI21X1 U694 ( .A(n643), .B(n665), .C(n2336), .Y(n664) );
  OAI21X1 U695 ( .A(n2525), .B(n2390), .C(n666), .Y(n1295) );
  NAND2X1 U696 ( .A(\registers[60][1] ), .B(n2525), .Y(n666) );
  OAI21X1 U697 ( .A(n2525), .B(n2384), .C(n667), .Y(n1296) );
  NAND2X1 U698 ( .A(\registers[60][2] ), .B(n2525), .Y(n667) );
  OAI21X1 U699 ( .A(n2525), .B(n2378), .C(n668), .Y(n1297) );
  NAND2X1 U700 ( .A(\registers[60][3] ), .B(n2525), .Y(n668) );
  OAI21X1 U701 ( .A(n2525), .B(n2372), .C(n669), .Y(n1298) );
  NAND2X1 U702 ( .A(\registers[60][4] ), .B(n2525), .Y(n669) );
  OAI21X1 U703 ( .A(n2525), .B(n2366), .C(n670), .Y(n1299) );
  NAND2X1 U704 ( .A(\registers[60][5] ), .B(n2525), .Y(n670) );
  OAI21X1 U705 ( .A(n2525), .B(n2360), .C(n671), .Y(n1300) );
  NAND2X1 U706 ( .A(\registers[60][6] ), .B(n2525), .Y(n671) );
  OAI21X1 U707 ( .A(n2525), .B(n2354), .C(n672), .Y(n1301) );
  NAND2X1 U708 ( .A(\registers[60][7] ), .B(n2525), .Y(n672) );
  OAI21X1 U709 ( .A(n2525), .B(n2348), .C(n673), .Y(n1302) );
  NAND2X1 U710 ( .A(\registers[60][0] ), .B(n2525), .Y(n673) );
  OAI21X1 U711 ( .A(n643), .B(n675), .C(n2337), .Y(n674) );
  OAI21X1 U712 ( .A(n2524), .B(n2389), .C(n676), .Y(n1303) );
  NAND2X1 U713 ( .A(\registers[59][1] ), .B(n2524), .Y(n676) );
  OAI21X1 U714 ( .A(n2524), .B(n2383), .C(n677), .Y(n1304) );
  NAND2X1 U715 ( .A(\registers[59][2] ), .B(n2524), .Y(n677) );
  OAI21X1 U716 ( .A(n2524), .B(n2377), .C(n678), .Y(n1305) );
  NAND2X1 U717 ( .A(\registers[59][3] ), .B(n2524), .Y(n678) );
  OAI21X1 U718 ( .A(n2524), .B(n2371), .C(n679), .Y(n1306) );
  NAND2X1 U719 ( .A(\registers[59][4] ), .B(n2524), .Y(n679) );
  OAI21X1 U720 ( .A(n2524), .B(n2365), .C(n680), .Y(n1307) );
  NAND2X1 U721 ( .A(\registers[59][5] ), .B(n2524), .Y(n680) );
  OAI21X1 U722 ( .A(n2524), .B(n2359), .C(n681), .Y(n1308) );
  NAND2X1 U723 ( .A(\registers[59][6] ), .B(n2524), .Y(n681) );
  OAI21X1 U724 ( .A(n2524), .B(n2353), .C(n682), .Y(n1309) );
  NAND2X1 U725 ( .A(\registers[59][7] ), .B(n2524), .Y(n682) );
  OAI21X1 U726 ( .A(n2524), .B(n2347), .C(n683), .Y(n1310) );
  NAND2X1 U727 ( .A(\registers[59][0] ), .B(n2524), .Y(n683) );
  OAI21X1 U728 ( .A(n643), .B(n685), .C(n2336), .Y(n684) );
  OAI21X1 U729 ( .A(n2523), .B(n2389), .C(n686), .Y(n1311) );
  NAND2X1 U730 ( .A(\registers[58][1] ), .B(n2523), .Y(n686) );
  OAI21X1 U731 ( .A(n2523), .B(n2383), .C(n687), .Y(n1312) );
  NAND2X1 U732 ( .A(\registers[58][2] ), .B(n2523), .Y(n687) );
  OAI21X1 U733 ( .A(n2523), .B(n2377), .C(n688), .Y(n1313) );
  NAND2X1 U734 ( .A(\registers[58][3] ), .B(n2523), .Y(n688) );
  OAI21X1 U735 ( .A(n2523), .B(n2371), .C(n689), .Y(n1314) );
  NAND2X1 U736 ( .A(\registers[58][4] ), .B(n2523), .Y(n689) );
  OAI21X1 U737 ( .A(n2523), .B(n2365), .C(n690), .Y(n1315) );
  NAND2X1 U738 ( .A(\registers[58][5] ), .B(n2523), .Y(n690) );
  OAI21X1 U739 ( .A(n2523), .B(n2359), .C(n691), .Y(n1316) );
  NAND2X1 U740 ( .A(\registers[58][6] ), .B(n2523), .Y(n691) );
  OAI21X1 U741 ( .A(n2523), .B(n2353), .C(n692), .Y(n1317) );
  NAND2X1 U742 ( .A(\registers[58][7] ), .B(n2523), .Y(n692) );
  OAI21X1 U743 ( .A(n2523), .B(n2347), .C(n693), .Y(n1318) );
  NAND2X1 U744 ( .A(\registers[58][0] ), .B(n2523), .Y(n693) );
  OAI21X1 U745 ( .A(n643), .B(n695), .C(n2337), .Y(n694) );
  OAI21X1 U746 ( .A(n2522), .B(n2389), .C(n696), .Y(n1319) );
  NAND2X1 U747 ( .A(\registers[57][1] ), .B(n2522), .Y(n696) );
  OAI21X1 U748 ( .A(n2522), .B(n2383), .C(n697), .Y(n1320) );
  NAND2X1 U749 ( .A(\registers[57][2] ), .B(n2522), .Y(n697) );
  OAI21X1 U750 ( .A(n2522), .B(n2377), .C(n698), .Y(n1321) );
  NAND2X1 U751 ( .A(\registers[57][3] ), .B(n2522), .Y(n698) );
  OAI21X1 U752 ( .A(n2522), .B(n2371), .C(n699), .Y(n1322) );
  NAND2X1 U753 ( .A(\registers[57][4] ), .B(n2522), .Y(n699) );
  OAI21X1 U754 ( .A(n2522), .B(n2365), .C(n700), .Y(n1323) );
  NAND2X1 U755 ( .A(\registers[57][5] ), .B(n2522), .Y(n700) );
  OAI21X1 U756 ( .A(n2522), .B(n2359), .C(n701), .Y(n1324) );
  NAND2X1 U757 ( .A(\registers[57][6] ), .B(n2522), .Y(n701) );
  OAI21X1 U758 ( .A(n2522), .B(n2353), .C(n702), .Y(n1325) );
  NAND2X1 U759 ( .A(\registers[57][7] ), .B(n2522), .Y(n702) );
  OAI21X1 U760 ( .A(n2522), .B(n2347), .C(n703), .Y(n1326) );
  NAND2X1 U761 ( .A(\registers[57][0] ), .B(n2522), .Y(n703) );
  OAI21X1 U762 ( .A(n643), .B(n705), .C(n2336), .Y(n704) );
  OAI21X1 U763 ( .A(n2521), .B(n2389), .C(n706), .Y(n1327) );
  NAND2X1 U764 ( .A(\registers[56][1] ), .B(n2521), .Y(n706) );
  OAI21X1 U765 ( .A(n2521), .B(n2383), .C(n707), .Y(n1328) );
  NAND2X1 U766 ( .A(\registers[56][2] ), .B(n2521), .Y(n707) );
  OAI21X1 U767 ( .A(n2521), .B(n2377), .C(n708), .Y(n1329) );
  NAND2X1 U768 ( .A(\registers[56][3] ), .B(n2521), .Y(n708) );
  OAI21X1 U769 ( .A(n2521), .B(n2371), .C(n709), .Y(n1330) );
  NAND2X1 U770 ( .A(\registers[56][4] ), .B(n2521), .Y(n709) );
  OAI21X1 U771 ( .A(n2521), .B(n2365), .C(n710), .Y(n1331) );
  NAND2X1 U772 ( .A(\registers[56][5] ), .B(n2521), .Y(n710) );
  OAI21X1 U773 ( .A(n2521), .B(n2359), .C(n711), .Y(n1332) );
  NAND2X1 U774 ( .A(\registers[56][6] ), .B(n2521), .Y(n711) );
  OAI21X1 U775 ( .A(n2521), .B(n2353), .C(n712), .Y(n1333) );
  NAND2X1 U776 ( .A(\registers[56][7] ), .B(n2521), .Y(n712) );
  OAI21X1 U777 ( .A(n2521), .B(n2347), .C(n713), .Y(n1334) );
  NAND2X1 U778 ( .A(\registers[56][0] ), .B(n2521), .Y(n713) );
  OAI21X1 U779 ( .A(n643), .B(n715), .C(n2337), .Y(n714) );
  NAND3X1 U780 ( .A(wpointer[3]), .B(n2529), .C(n716), .Y(n643) );
  OAI21X1 U781 ( .A(n2520), .B(n2389), .C(n717), .Y(n1335) );
  NAND2X1 U782 ( .A(\registers[55][1] ), .B(n2520), .Y(n717) );
  OAI21X1 U783 ( .A(n2520), .B(n2383), .C(n718), .Y(n1336) );
  NAND2X1 U784 ( .A(\registers[55][2] ), .B(n2520), .Y(n718) );
  OAI21X1 U785 ( .A(n2520), .B(n2377), .C(n719), .Y(n1337) );
  NAND2X1 U786 ( .A(\registers[55][3] ), .B(n2520), .Y(n719) );
  OAI21X1 U787 ( .A(n2520), .B(n2371), .C(n720), .Y(n1338) );
  NAND2X1 U788 ( .A(\registers[55][4] ), .B(n2520), .Y(n720) );
  OAI21X1 U789 ( .A(n2520), .B(n2365), .C(n721), .Y(n1339) );
  NAND2X1 U790 ( .A(\registers[55][5] ), .B(n2520), .Y(n721) );
  OAI21X1 U791 ( .A(n2520), .B(n2359), .C(n722), .Y(n1340) );
  NAND2X1 U792 ( .A(\registers[55][6] ), .B(n2520), .Y(n722) );
  OAI21X1 U793 ( .A(n2520), .B(n2353), .C(n723), .Y(n1341) );
  NAND2X1 U794 ( .A(\registers[55][7] ), .B(n2520), .Y(n723) );
  OAI21X1 U795 ( .A(n2520), .B(n2347), .C(n724), .Y(n1342) );
  NAND2X1 U796 ( .A(\registers[55][0] ), .B(n2520), .Y(n724) );
  OAI21X1 U797 ( .A(n644), .B(n726), .C(n2336), .Y(n725) );
  OAI21X1 U798 ( .A(n2519), .B(n2389), .C(n727), .Y(n1343) );
  NAND2X1 U799 ( .A(\registers[54][1] ), .B(n2519), .Y(n727) );
  OAI21X1 U800 ( .A(n2519), .B(n2383), .C(n728), .Y(n1344) );
  NAND2X1 U801 ( .A(\registers[54][2] ), .B(n2519), .Y(n728) );
  OAI21X1 U802 ( .A(n2519), .B(n2377), .C(n729), .Y(n1345) );
  NAND2X1 U803 ( .A(\registers[54][3] ), .B(n2519), .Y(n729) );
  OAI21X1 U804 ( .A(n2519), .B(n2371), .C(n730), .Y(n1346) );
  NAND2X1 U805 ( .A(\registers[54][4] ), .B(n2519), .Y(n730) );
  OAI21X1 U806 ( .A(n2519), .B(n2365), .C(n731), .Y(n1347) );
  NAND2X1 U807 ( .A(\registers[54][5] ), .B(n2519), .Y(n731) );
  OAI21X1 U808 ( .A(n2519), .B(n2359), .C(n732), .Y(n1348) );
  NAND2X1 U809 ( .A(\registers[54][6] ), .B(n2519), .Y(n732) );
  OAI21X1 U810 ( .A(n2519), .B(n2353), .C(n733), .Y(n1349) );
  NAND2X1 U811 ( .A(\registers[54][7] ), .B(n2519), .Y(n733) );
  OAI21X1 U812 ( .A(n2519), .B(n2347), .C(n734), .Y(n1350) );
  NAND2X1 U813 ( .A(\registers[54][0] ), .B(n2519), .Y(n734) );
  OAI21X1 U814 ( .A(n655), .B(n726), .C(n2336), .Y(n735) );
  OAI21X1 U815 ( .A(n2518), .B(n2389), .C(n736), .Y(n1351) );
  NAND2X1 U816 ( .A(\registers[53][1] ), .B(n2518), .Y(n736) );
  OAI21X1 U817 ( .A(n2518), .B(n2383), .C(n737), .Y(n1352) );
  NAND2X1 U818 ( .A(\registers[53][2] ), .B(n2518), .Y(n737) );
  OAI21X1 U819 ( .A(n2518), .B(n2377), .C(n738), .Y(n1353) );
  NAND2X1 U820 ( .A(\registers[53][3] ), .B(n2518), .Y(n738) );
  OAI21X1 U821 ( .A(n2518), .B(n2371), .C(n739), .Y(n1354) );
  NAND2X1 U822 ( .A(\registers[53][4] ), .B(n2518), .Y(n739) );
  OAI21X1 U823 ( .A(n2518), .B(n2365), .C(n740), .Y(n1355) );
  NAND2X1 U824 ( .A(\registers[53][5] ), .B(n2518), .Y(n740) );
  OAI21X1 U825 ( .A(n2518), .B(n2359), .C(n741), .Y(n1356) );
  NAND2X1 U826 ( .A(\registers[53][6] ), .B(n2518), .Y(n741) );
  OAI21X1 U827 ( .A(n2518), .B(n2353), .C(n742), .Y(n1357) );
  NAND2X1 U828 ( .A(\registers[53][7] ), .B(n2518), .Y(n742) );
  OAI21X1 U829 ( .A(n2518), .B(n2347), .C(n743), .Y(n1358) );
  NAND2X1 U830 ( .A(\registers[53][0] ), .B(n2518), .Y(n743) );
  OAI21X1 U831 ( .A(n665), .B(n726), .C(n2336), .Y(n744) );
  OAI21X1 U832 ( .A(n2517), .B(n2389), .C(n745), .Y(n1359) );
  NAND2X1 U833 ( .A(\registers[52][1] ), .B(n2517), .Y(n745) );
  OAI21X1 U834 ( .A(n2517), .B(n2383), .C(n746), .Y(n1360) );
  NAND2X1 U835 ( .A(\registers[52][2] ), .B(n2517), .Y(n746) );
  OAI21X1 U836 ( .A(n2517), .B(n2377), .C(n747), .Y(n1361) );
  NAND2X1 U837 ( .A(\registers[52][3] ), .B(n2517), .Y(n747) );
  OAI21X1 U838 ( .A(n2517), .B(n2371), .C(n748), .Y(n1362) );
  NAND2X1 U839 ( .A(\registers[52][4] ), .B(n2517), .Y(n748) );
  OAI21X1 U840 ( .A(n2517), .B(n2365), .C(n749), .Y(n1363) );
  NAND2X1 U841 ( .A(\registers[52][5] ), .B(n2517), .Y(n749) );
  OAI21X1 U842 ( .A(n2517), .B(n2359), .C(n750), .Y(n1364) );
  NAND2X1 U843 ( .A(\registers[52][6] ), .B(n2517), .Y(n750) );
  OAI21X1 U844 ( .A(n2517), .B(n2353), .C(n751), .Y(n1365) );
  NAND2X1 U845 ( .A(\registers[52][7] ), .B(n2517), .Y(n751) );
  OAI21X1 U846 ( .A(n2517), .B(n2347), .C(n752), .Y(n1366) );
  NAND2X1 U847 ( .A(\registers[52][0] ), .B(n2517), .Y(n752) );
  OAI21X1 U848 ( .A(n675), .B(n726), .C(n2336), .Y(n753) );
  OAI21X1 U849 ( .A(n2516), .B(n2389), .C(n754), .Y(n1367) );
  NAND2X1 U850 ( .A(\registers[51][1] ), .B(n2516), .Y(n754) );
  OAI21X1 U851 ( .A(n2516), .B(n2383), .C(n755), .Y(n1368) );
  NAND2X1 U852 ( .A(\registers[51][2] ), .B(n2516), .Y(n755) );
  OAI21X1 U853 ( .A(n2516), .B(n2377), .C(n756), .Y(n1369) );
  NAND2X1 U854 ( .A(\registers[51][3] ), .B(n2516), .Y(n756) );
  OAI21X1 U855 ( .A(n2516), .B(n2371), .C(n757), .Y(n1370) );
  NAND2X1 U856 ( .A(\registers[51][4] ), .B(n2516), .Y(n757) );
  OAI21X1 U857 ( .A(n2516), .B(n2365), .C(n758), .Y(n1371) );
  NAND2X1 U858 ( .A(\registers[51][5] ), .B(n2516), .Y(n758) );
  OAI21X1 U859 ( .A(n2516), .B(n2359), .C(n759), .Y(n1372) );
  NAND2X1 U860 ( .A(\registers[51][6] ), .B(n2516), .Y(n759) );
  OAI21X1 U861 ( .A(n2516), .B(n2353), .C(n760), .Y(n1373) );
  NAND2X1 U862 ( .A(\registers[51][7] ), .B(n2516), .Y(n760) );
  OAI21X1 U863 ( .A(n2516), .B(n2347), .C(n761), .Y(n1374) );
  NAND2X1 U864 ( .A(\registers[51][0] ), .B(n2516), .Y(n761) );
  OAI21X1 U865 ( .A(n685), .B(n726), .C(n2337), .Y(n762) );
  OAI21X1 U866 ( .A(n2515), .B(n2389), .C(n763), .Y(n1375) );
  NAND2X1 U867 ( .A(\registers[50][1] ), .B(n2515), .Y(n763) );
  OAI21X1 U868 ( .A(n2515), .B(n2383), .C(n764), .Y(n1376) );
  NAND2X1 U869 ( .A(\registers[50][2] ), .B(n2515), .Y(n764) );
  OAI21X1 U870 ( .A(n2515), .B(n2377), .C(n765), .Y(n1377) );
  NAND2X1 U871 ( .A(\registers[50][3] ), .B(n2515), .Y(n765) );
  OAI21X1 U872 ( .A(n2515), .B(n2371), .C(n766), .Y(n1378) );
  NAND2X1 U873 ( .A(\registers[50][4] ), .B(n2515), .Y(n766) );
  OAI21X1 U874 ( .A(n2515), .B(n2365), .C(n767), .Y(n1379) );
  NAND2X1 U875 ( .A(\registers[50][5] ), .B(n2515), .Y(n767) );
  OAI21X1 U876 ( .A(n2515), .B(n2359), .C(n768), .Y(n1380) );
  NAND2X1 U877 ( .A(\registers[50][6] ), .B(n2515), .Y(n768) );
  OAI21X1 U878 ( .A(n2515), .B(n2353), .C(n769), .Y(n1381) );
  NAND2X1 U879 ( .A(\registers[50][7] ), .B(n2515), .Y(n769) );
  OAI21X1 U880 ( .A(n2515), .B(n2347), .C(n770), .Y(n1382) );
  NAND2X1 U881 ( .A(\registers[50][0] ), .B(n2515), .Y(n770) );
  OAI21X1 U882 ( .A(n695), .B(n726), .C(n2337), .Y(n771) );
  OAI21X1 U883 ( .A(n2514), .B(n2389), .C(n772), .Y(n1383) );
  NAND2X1 U884 ( .A(\registers[49][1] ), .B(n2514), .Y(n772) );
  OAI21X1 U885 ( .A(n2514), .B(n2383), .C(n773), .Y(n1384) );
  NAND2X1 U886 ( .A(\registers[49][2] ), .B(n2514), .Y(n773) );
  OAI21X1 U887 ( .A(n2514), .B(n2377), .C(n774), .Y(n1385) );
  NAND2X1 U888 ( .A(\registers[49][3] ), .B(n2514), .Y(n774) );
  OAI21X1 U889 ( .A(n2514), .B(n2371), .C(n775), .Y(n1386) );
  NAND2X1 U890 ( .A(\registers[49][4] ), .B(n2514), .Y(n775) );
  OAI21X1 U891 ( .A(n2514), .B(n2365), .C(n776), .Y(n1387) );
  NAND2X1 U892 ( .A(\registers[49][5] ), .B(n2514), .Y(n776) );
  OAI21X1 U893 ( .A(n2514), .B(n2359), .C(n777), .Y(n1388) );
  NAND2X1 U894 ( .A(\registers[49][6] ), .B(n2514), .Y(n777) );
  OAI21X1 U895 ( .A(n2514), .B(n2353), .C(n778), .Y(n1389) );
  NAND2X1 U896 ( .A(\registers[49][7] ), .B(n2514), .Y(n778) );
  OAI21X1 U897 ( .A(n2514), .B(n2347), .C(n779), .Y(n1390) );
  NAND2X1 U898 ( .A(\registers[49][0] ), .B(n2514), .Y(n779) );
  OAI21X1 U899 ( .A(n705), .B(n726), .C(n2336), .Y(n780) );
  OAI21X1 U900 ( .A(n2513), .B(n2389), .C(n781), .Y(n1391) );
  NAND2X1 U901 ( .A(\registers[48][1] ), .B(n2513), .Y(n781) );
  OAI21X1 U902 ( .A(n2513), .B(n2383), .C(n782), .Y(n1392) );
  NAND2X1 U903 ( .A(\registers[48][2] ), .B(n2513), .Y(n782) );
  OAI21X1 U904 ( .A(n2513), .B(n2377), .C(n783), .Y(n1393) );
  NAND2X1 U905 ( .A(\registers[48][3] ), .B(n2513), .Y(n783) );
  OAI21X1 U906 ( .A(n2513), .B(n2371), .C(n784), .Y(n1394) );
  NAND2X1 U907 ( .A(\registers[48][4] ), .B(n2513), .Y(n784) );
  OAI21X1 U908 ( .A(n2513), .B(n2365), .C(n785), .Y(n1395) );
  NAND2X1 U909 ( .A(\registers[48][5] ), .B(n2513), .Y(n785) );
  OAI21X1 U910 ( .A(n2513), .B(n2359), .C(n786), .Y(n1396) );
  NAND2X1 U911 ( .A(\registers[48][6] ), .B(n2513), .Y(n786) );
  OAI21X1 U912 ( .A(n2513), .B(n2353), .C(n787), .Y(n1397) );
  NAND2X1 U913 ( .A(\registers[48][7] ), .B(n2513), .Y(n787) );
  OAI21X1 U914 ( .A(n2513), .B(n2347), .C(n788), .Y(n1398) );
  NAND2X1 U915 ( .A(\registers[48][0] ), .B(n2513), .Y(n788) );
  OAI21X1 U916 ( .A(n715), .B(n726), .C(n2337), .Y(n789) );
  NAND3X1 U917 ( .A(n2529), .B(n2542), .C(n716), .Y(n726) );
  NOR2X1 U918 ( .A(n2543), .B(n2544), .Y(n716) );
  OAI21X1 U919 ( .A(n2512), .B(n2388), .C(n790), .Y(n1399) );
  NAND2X1 U920 ( .A(\registers[47][1] ), .B(n2512), .Y(n790) );
  OAI21X1 U921 ( .A(n2512), .B(n2382), .C(n791), .Y(n1400) );
  NAND2X1 U922 ( .A(\registers[47][2] ), .B(n2512), .Y(n791) );
  OAI21X1 U923 ( .A(n2512), .B(n2376), .C(n792), .Y(n1401) );
  NAND2X1 U924 ( .A(\registers[47][3] ), .B(n2512), .Y(n792) );
  OAI21X1 U925 ( .A(n2512), .B(n2370), .C(n793), .Y(n1402) );
  NAND2X1 U926 ( .A(\registers[47][4] ), .B(n2512), .Y(n793) );
  OAI21X1 U927 ( .A(n2512), .B(n2364), .C(n794), .Y(n1403) );
  NAND2X1 U928 ( .A(\registers[47][5] ), .B(n2512), .Y(n794) );
  OAI21X1 U929 ( .A(n2512), .B(n2358), .C(n795), .Y(n1404) );
  NAND2X1 U930 ( .A(\registers[47][6] ), .B(n2512), .Y(n795) );
  OAI21X1 U931 ( .A(n2512), .B(n2352), .C(n796), .Y(n1405) );
  NAND2X1 U932 ( .A(\registers[47][7] ), .B(n2512), .Y(n796) );
  OAI21X1 U933 ( .A(n2512), .B(n2346), .C(n797), .Y(n1406) );
  NAND2X1 U934 ( .A(\registers[47][0] ), .B(n2512), .Y(n797) );
  OAI21X1 U935 ( .A(n644), .B(n799), .C(n2336), .Y(n798) );
  OAI21X1 U936 ( .A(n2511), .B(n2388), .C(n800), .Y(n1407) );
  NAND2X1 U937 ( .A(\registers[46][1] ), .B(n2511), .Y(n800) );
  OAI21X1 U938 ( .A(n2511), .B(n2382), .C(n801), .Y(n1408) );
  NAND2X1 U939 ( .A(\registers[46][2] ), .B(n2511), .Y(n801) );
  OAI21X1 U940 ( .A(n2511), .B(n2376), .C(n802), .Y(n1409) );
  NAND2X1 U941 ( .A(\registers[46][3] ), .B(n2511), .Y(n802) );
  OAI21X1 U942 ( .A(n2511), .B(n2370), .C(n803), .Y(n1410) );
  NAND2X1 U943 ( .A(\registers[46][4] ), .B(n2511), .Y(n803) );
  OAI21X1 U944 ( .A(n2511), .B(n2364), .C(n804), .Y(n1411) );
  NAND2X1 U945 ( .A(\registers[46][5] ), .B(n2511), .Y(n804) );
  OAI21X1 U946 ( .A(n2511), .B(n2358), .C(n805), .Y(n1412) );
  NAND2X1 U947 ( .A(\registers[46][6] ), .B(n2511), .Y(n805) );
  OAI21X1 U948 ( .A(n2511), .B(n2352), .C(n806), .Y(n1413) );
  NAND2X1 U949 ( .A(\registers[46][7] ), .B(n2511), .Y(n806) );
  OAI21X1 U950 ( .A(n2511), .B(n2346), .C(n807), .Y(n1414) );
  NAND2X1 U951 ( .A(\registers[46][0] ), .B(n2511), .Y(n807) );
  OAI21X1 U952 ( .A(n655), .B(n799), .C(n2337), .Y(n808) );
  OAI21X1 U953 ( .A(n2510), .B(n2388), .C(n809), .Y(n1415) );
  NAND2X1 U954 ( .A(\registers[45][1] ), .B(n2510), .Y(n809) );
  OAI21X1 U955 ( .A(n2510), .B(n2382), .C(n810), .Y(n1416) );
  NAND2X1 U956 ( .A(\registers[45][2] ), .B(n2510), .Y(n810) );
  OAI21X1 U957 ( .A(n2510), .B(n2376), .C(n811), .Y(n1417) );
  NAND2X1 U958 ( .A(\registers[45][3] ), .B(n2510), .Y(n811) );
  OAI21X1 U959 ( .A(n2510), .B(n2370), .C(n812), .Y(n1418) );
  NAND2X1 U960 ( .A(\registers[45][4] ), .B(n2510), .Y(n812) );
  OAI21X1 U961 ( .A(n2510), .B(n2364), .C(n813), .Y(n1419) );
  NAND2X1 U962 ( .A(\registers[45][5] ), .B(n2510), .Y(n813) );
  OAI21X1 U963 ( .A(n2510), .B(n2358), .C(n814), .Y(n1420) );
  NAND2X1 U964 ( .A(\registers[45][6] ), .B(n2510), .Y(n814) );
  OAI21X1 U965 ( .A(n2510), .B(n2352), .C(n815), .Y(n1421) );
  NAND2X1 U966 ( .A(\registers[45][7] ), .B(n2510), .Y(n815) );
  OAI21X1 U967 ( .A(n2510), .B(n2346), .C(n816), .Y(n1422) );
  NAND2X1 U968 ( .A(\registers[45][0] ), .B(n2510), .Y(n816) );
  OAI21X1 U969 ( .A(n665), .B(n799), .C(n2337), .Y(n817) );
  OAI21X1 U970 ( .A(n2509), .B(n2388), .C(n818), .Y(n1423) );
  NAND2X1 U971 ( .A(\registers[44][1] ), .B(n2509), .Y(n818) );
  OAI21X1 U972 ( .A(n2509), .B(n2382), .C(n819), .Y(n1424) );
  NAND2X1 U973 ( .A(\registers[44][2] ), .B(n2509), .Y(n819) );
  OAI21X1 U974 ( .A(n2509), .B(n2376), .C(n820), .Y(n1425) );
  NAND2X1 U975 ( .A(\registers[44][3] ), .B(n2509), .Y(n820) );
  OAI21X1 U976 ( .A(n2509), .B(n2370), .C(n821), .Y(n1426) );
  NAND2X1 U977 ( .A(\registers[44][4] ), .B(n2509), .Y(n821) );
  OAI21X1 U978 ( .A(n2509), .B(n2364), .C(n822), .Y(n1427) );
  NAND2X1 U979 ( .A(\registers[44][5] ), .B(n2509), .Y(n822) );
  OAI21X1 U980 ( .A(n2509), .B(n2358), .C(n823), .Y(n1428) );
  NAND2X1 U981 ( .A(\registers[44][6] ), .B(n2509), .Y(n823) );
  OAI21X1 U982 ( .A(n2509), .B(n2352), .C(n824), .Y(n1429) );
  NAND2X1 U983 ( .A(\registers[44][7] ), .B(n2509), .Y(n824) );
  OAI21X1 U984 ( .A(n2509), .B(n2346), .C(n825), .Y(n1430) );
  NAND2X1 U985 ( .A(\registers[44][0] ), .B(n2509), .Y(n825) );
  OAI21X1 U986 ( .A(n675), .B(n799), .C(n2337), .Y(n826) );
  OAI21X1 U987 ( .A(n2508), .B(n2388), .C(n827), .Y(n1431) );
  NAND2X1 U988 ( .A(\registers[43][1] ), .B(n2508), .Y(n827) );
  OAI21X1 U989 ( .A(n2508), .B(n2382), .C(n828), .Y(n1432) );
  NAND2X1 U990 ( .A(\registers[43][2] ), .B(n2508), .Y(n828) );
  OAI21X1 U991 ( .A(n2508), .B(n2376), .C(n829), .Y(n1433) );
  NAND2X1 U992 ( .A(\registers[43][3] ), .B(n2508), .Y(n829) );
  OAI21X1 U993 ( .A(n2508), .B(n2370), .C(n830), .Y(n1434) );
  NAND2X1 U994 ( .A(\registers[43][4] ), .B(n2508), .Y(n830) );
  OAI21X1 U995 ( .A(n2508), .B(n2364), .C(n831), .Y(n1435) );
  NAND2X1 U996 ( .A(\registers[43][5] ), .B(n2508), .Y(n831) );
  OAI21X1 U997 ( .A(n2508), .B(n2358), .C(n832), .Y(n1436) );
  NAND2X1 U998 ( .A(\registers[43][6] ), .B(n2508), .Y(n832) );
  OAI21X1 U999 ( .A(n2508), .B(n2352), .C(n833), .Y(n1437) );
  NAND2X1 U1000 ( .A(\registers[43][7] ), .B(n2508), .Y(n833) );
  OAI21X1 U1001 ( .A(n2508), .B(n2346), .C(n834), .Y(n1438) );
  NAND2X1 U1002 ( .A(\registers[43][0] ), .B(n2508), .Y(n834) );
  OAI21X1 U1003 ( .A(n685), .B(n799), .C(n2336), .Y(n835) );
  OAI21X1 U1004 ( .A(n2507), .B(n2388), .C(n836), .Y(n1439) );
  NAND2X1 U1005 ( .A(\registers[42][1] ), .B(n2507), .Y(n836) );
  OAI21X1 U1006 ( .A(n2507), .B(n2382), .C(n837), .Y(n1440) );
  NAND2X1 U1007 ( .A(\registers[42][2] ), .B(n2507), .Y(n837) );
  OAI21X1 U1008 ( .A(n2507), .B(n2376), .C(n838), .Y(n1441) );
  NAND2X1 U1009 ( .A(\registers[42][3] ), .B(n2507), .Y(n838) );
  OAI21X1 U1010 ( .A(n2507), .B(n2370), .C(n839), .Y(n1442) );
  NAND2X1 U1011 ( .A(\registers[42][4] ), .B(n2507), .Y(n839) );
  OAI21X1 U1012 ( .A(n2507), .B(n2364), .C(n840), .Y(n1443) );
  NAND2X1 U1013 ( .A(\registers[42][5] ), .B(n2507), .Y(n840) );
  OAI21X1 U1014 ( .A(n2507), .B(n2358), .C(n841), .Y(n1444) );
  NAND2X1 U1015 ( .A(\registers[42][6] ), .B(n2507), .Y(n841) );
  OAI21X1 U1016 ( .A(n2507), .B(n2352), .C(n842), .Y(n1445) );
  NAND2X1 U1017 ( .A(\registers[42][7] ), .B(n2507), .Y(n842) );
  OAI21X1 U1018 ( .A(n2507), .B(n2346), .C(n843), .Y(n1446) );
  NAND2X1 U1019 ( .A(\registers[42][0] ), .B(n2507), .Y(n843) );
  OAI21X1 U1020 ( .A(n695), .B(n799), .C(n2336), .Y(n844) );
  OAI21X1 U1021 ( .A(n2506), .B(n2388), .C(n845), .Y(n1447) );
  NAND2X1 U1022 ( .A(\registers[41][1] ), .B(n2506), .Y(n845) );
  OAI21X1 U1023 ( .A(n2506), .B(n2382), .C(n846), .Y(n1448) );
  NAND2X1 U1024 ( .A(\registers[41][2] ), .B(n2506), .Y(n846) );
  OAI21X1 U1025 ( .A(n2506), .B(n2376), .C(n847), .Y(n1449) );
  NAND2X1 U1026 ( .A(\registers[41][3] ), .B(n2506), .Y(n847) );
  OAI21X1 U1027 ( .A(n2506), .B(n2370), .C(n848), .Y(n1450) );
  NAND2X1 U1028 ( .A(\registers[41][4] ), .B(n2506), .Y(n848) );
  OAI21X1 U1029 ( .A(n2506), .B(n2364), .C(n849), .Y(n1451) );
  NAND2X1 U1030 ( .A(\registers[41][5] ), .B(n2506), .Y(n849) );
  OAI21X1 U1031 ( .A(n2506), .B(n2358), .C(n850), .Y(n1452) );
  NAND2X1 U1032 ( .A(\registers[41][6] ), .B(n2506), .Y(n850) );
  OAI21X1 U1033 ( .A(n2506), .B(n2352), .C(n851), .Y(n1453) );
  NAND2X1 U1034 ( .A(\registers[41][7] ), .B(n2506), .Y(n851) );
  OAI21X1 U1035 ( .A(n2506), .B(n2346), .C(n852), .Y(n1454) );
  NAND2X1 U1036 ( .A(\registers[41][0] ), .B(n2506), .Y(n852) );
  OAI21X1 U1037 ( .A(n705), .B(n799), .C(n2337), .Y(n853) );
  OAI21X1 U1038 ( .A(n2505), .B(n2388), .C(n854), .Y(n1455) );
  NAND2X1 U1039 ( .A(\registers[40][1] ), .B(n2505), .Y(n854) );
  OAI21X1 U1040 ( .A(n2505), .B(n2382), .C(n855), .Y(n1456) );
  NAND2X1 U1041 ( .A(\registers[40][2] ), .B(n2505), .Y(n855) );
  OAI21X1 U1042 ( .A(n2505), .B(n2376), .C(n856), .Y(n1457) );
  NAND2X1 U1043 ( .A(\registers[40][3] ), .B(n2505), .Y(n856) );
  OAI21X1 U1044 ( .A(n2505), .B(n2370), .C(n857), .Y(n1458) );
  NAND2X1 U1045 ( .A(\registers[40][4] ), .B(n2505), .Y(n857) );
  OAI21X1 U1046 ( .A(n2505), .B(n2364), .C(n858), .Y(n1459) );
  NAND2X1 U1047 ( .A(\registers[40][5] ), .B(n2505), .Y(n858) );
  OAI21X1 U1048 ( .A(n2505), .B(n2358), .C(n859), .Y(n1460) );
  NAND2X1 U1049 ( .A(\registers[40][6] ), .B(n2505), .Y(n859) );
  OAI21X1 U1050 ( .A(n2505), .B(n2352), .C(n860), .Y(n1461) );
  NAND2X1 U1051 ( .A(\registers[40][7] ), .B(n2505), .Y(n860) );
  OAI21X1 U1052 ( .A(n2505), .B(n2346), .C(n861), .Y(n1462) );
  NAND2X1 U1053 ( .A(\registers[40][0] ), .B(n2505), .Y(n861) );
  OAI21X1 U1054 ( .A(n715), .B(n799), .C(n2336), .Y(n862) );
  NAND3X1 U1055 ( .A(n2529), .B(n2543), .C(n863), .Y(n799) );
  NOR2X1 U1056 ( .A(n2542), .B(n2544), .Y(n863) );
  OAI21X1 U1057 ( .A(n2504), .B(n2388), .C(n864), .Y(n1463) );
  NAND2X1 U1058 ( .A(\registers[39][1] ), .B(n2504), .Y(n864) );
  OAI21X1 U1059 ( .A(n2504), .B(n2382), .C(n865), .Y(n1464) );
  NAND2X1 U1060 ( .A(\registers[39][2] ), .B(n2504), .Y(n865) );
  OAI21X1 U1061 ( .A(n2504), .B(n2376), .C(n866), .Y(n1465) );
  NAND2X1 U1062 ( .A(\registers[39][3] ), .B(n2504), .Y(n866) );
  OAI21X1 U1063 ( .A(n2504), .B(n2370), .C(n867), .Y(n1466) );
  NAND2X1 U1064 ( .A(\registers[39][4] ), .B(n2504), .Y(n867) );
  OAI21X1 U1065 ( .A(n2504), .B(n2364), .C(n868), .Y(n1467) );
  NAND2X1 U1066 ( .A(\registers[39][5] ), .B(n2504), .Y(n868) );
  OAI21X1 U1067 ( .A(n2504), .B(n2358), .C(n869), .Y(n1468) );
  NAND2X1 U1068 ( .A(\registers[39][6] ), .B(n2504), .Y(n869) );
  OAI21X1 U1069 ( .A(n2504), .B(n2352), .C(n870), .Y(n1469) );
  NAND2X1 U1070 ( .A(\registers[39][7] ), .B(n2504), .Y(n870) );
  OAI21X1 U1071 ( .A(n2504), .B(n2346), .C(n871), .Y(n1470) );
  NAND2X1 U1072 ( .A(\registers[39][0] ), .B(n2504), .Y(n871) );
  OAI21X1 U1073 ( .A(n644), .B(n873), .C(n2337), .Y(n872) );
  OAI21X1 U1074 ( .A(n2503), .B(n2388), .C(n874), .Y(n1471) );
  NAND2X1 U1075 ( .A(\registers[38][1] ), .B(n2503), .Y(n874) );
  OAI21X1 U1076 ( .A(n2503), .B(n2382), .C(n875), .Y(n1472) );
  NAND2X1 U1077 ( .A(\registers[38][2] ), .B(n2503), .Y(n875) );
  OAI21X1 U1078 ( .A(n2503), .B(n2376), .C(n876), .Y(n1473) );
  NAND2X1 U1079 ( .A(\registers[38][3] ), .B(n2503), .Y(n876) );
  OAI21X1 U1080 ( .A(n2503), .B(n2370), .C(n877), .Y(n1474) );
  NAND2X1 U1081 ( .A(\registers[38][4] ), .B(n2503), .Y(n877) );
  OAI21X1 U1082 ( .A(n2503), .B(n2364), .C(n878), .Y(n1475) );
  NAND2X1 U1083 ( .A(\registers[38][5] ), .B(n2503), .Y(n878) );
  OAI21X1 U1084 ( .A(n2503), .B(n2358), .C(n879), .Y(n1476) );
  NAND2X1 U1085 ( .A(\registers[38][6] ), .B(n2503), .Y(n879) );
  OAI21X1 U1086 ( .A(n2503), .B(n2352), .C(n880), .Y(n1477) );
  NAND2X1 U1087 ( .A(\registers[38][7] ), .B(n2503), .Y(n880) );
  OAI21X1 U1088 ( .A(n2503), .B(n2346), .C(n881), .Y(n1478) );
  NAND2X1 U1089 ( .A(\registers[38][0] ), .B(n2503), .Y(n881) );
  OAI21X1 U1090 ( .A(n655), .B(n873), .C(n2336), .Y(n882) );
  OAI21X1 U1091 ( .A(n2502), .B(n2388), .C(n883), .Y(n1479) );
  NAND2X1 U1092 ( .A(\registers[37][1] ), .B(n2502), .Y(n883) );
  OAI21X1 U1093 ( .A(n2502), .B(n2382), .C(n884), .Y(n1480) );
  NAND2X1 U1094 ( .A(\registers[37][2] ), .B(n2502), .Y(n884) );
  OAI21X1 U1095 ( .A(n2502), .B(n2376), .C(n885), .Y(n1481) );
  NAND2X1 U1096 ( .A(\registers[37][3] ), .B(n2502), .Y(n885) );
  OAI21X1 U1097 ( .A(n2502), .B(n2370), .C(n886), .Y(n1482) );
  NAND2X1 U1098 ( .A(\registers[37][4] ), .B(n2502), .Y(n886) );
  OAI21X1 U1099 ( .A(n2502), .B(n2364), .C(n887), .Y(n1483) );
  NAND2X1 U1100 ( .A(\registers[37][5] ), .B(n2502), .Y(n887) );
  OAI21X1 U1101 ( .A(n2502), .B(n2358), .C(n888), .Y(n1484) );
  NAND2X1 U1102 ( .A(\registers[37][6] ), .B(n2502), .Y(n888) );
  OAI21X1 U1103 ( .A(n2502), .B(n2352), .C(n889), .Y(n1485) );
  NAND2X1 U1104 ( .A(\registers[37][7] ), .B(n2502), .Y(n889) );
  OAI21X1 U1105 ( .A(n2502), .B(n2346), .C(n890), .Y(n1486) );
  NAND2X1 U1106 ( .A(\registers[37][0] ), .B(n2502), .Y(n890) );
  OAI21X1 U1107 ( .A(n665), .B(n873), .C(n2337), .Y(n891) );
  OAI21X1 U1108 ( .A(n2501), .B(n2388), .C(n892), .Y(n1487) );
  NAND2X1 U1109 ( .A(\registers[36][1] ), .B(n2501), .Y(n892) );
  OAI21X1 U1110 ( .A(n2501), .B(n2382), .C(n893), .Y(n1488) );
  NAND2X1 U1111 ( .A(\registers[36][2] ), .B(n2501), .Y(n893) );
  OAI21X1 U1112 ( .A(n2501), .B(n2376), .C(n894), .Y(n1489) );
  NAND2X1 U1113 ( .A(\registers[36][3] ), .B(n2501), .Y(n894) );
  OAI21X1 U1114 ( .A(n2501), .B(n2370), .C(n895), .Y(n1490) );
  NAND2X1 U1115 ( .A(\registers[36][4] ), .B(n2501), .Y(n895) );
  OAI21X1 U1116 ( .A(n2501), .B(n2364), .C(n896), .Y(n1491) );
  NAND2X1 U1117 ( .A(\registers[36][5] ), .B(n2501), .Y(n896) );
  OAI21X1 U1118 ( .A(n2501), .B(n2358), .C(n897), .Y(n1492) );
  NAND2X1 U1119 ( .A(\registers[36][6] ), .B(n2501), .Y(n897) );
  OAI21X1 U1120 ( .A(n2501), .B(n2352), .C(n898), .Y(n1493) );
  NAND2X1 U1121 ( .A(\registers[36][7] ), .B(n2501), .Y(n898) );
  OAI21X1 U1122 ( .A(n2501), .B(n2346), .C(n899), .Y(n1494) );
  NAND2X1 U1123 ( .A(\registers[36][0] ), .B(n2501), .Y(n899) );
  OAI21X1 U1124 ( .A(n675), .B(n873), .C(n2336), .Y(n900) );
  OAI21X1 U1125 ( .A(n2500), .B(n2387), .C(n901), .Y(n1495) );
  NAND2X1 U1126 ( .A(\registers[35][1] ), .B(n2500), .Y(n901) );
  OAI21X1 U1127 ( .A(n2500), .B(n2381), .C(n902), .Y(n1496) );
  NAND2X1 U1128 ( .A(\registers[35][2] ), .B(n2500), .Y(n902) );
  OAI21X1 U1129 ( .A(n2500), .B(n2375), .C(n903), .Y(n1497) );
  NAND2X1 U1130 ( .A(\registers[35][3] ), .B(n2500), .Y(n903) );
  OAI21X1 U1131 ( .A(n2500), .B(n2369), .C(n904), .Y(n1498) );
  NAND2X1 U1132 ( .A(\registers[35][4] ), .B(n2500), .Y(n904) );
  OAI21X1 U1133 ( .A(n2500), .B(n2363), .C(n905), .Y(n1499) );
  NAND2X1 U1134 ( .A(\registers[35][5] ), .B(n2500), .Y(n905) );
  OAI21X1 U1135 ( .A(n2500), .B(n2357), .C(n906), .Y(n1500) );
  NAND2X1 U1136 ( .A(\registers[35][6] ), .B(n2500), .Y(n906) );
  OAI21X1 U1137 ( .A(n2500), .B(n2351), .C(n907), .Y(n1501) );
  NAND2X1 U1138 ( .A(\registers[35][7] ), .B(n2500), .Y(n907) );
  OAI21X1 U1139 ( .A(n2500), .B(n2345), .C(n908), .Y(n1502) );
  NAND2X1 U1140 ( .A(\registers[35][0] ), .B(n2500), .Y(n908) );
  OAI21X1 U1141 ( .A(n685), .B(n873), .C(n2336), .Y(n909) );
  OAI21X1 U1142 ( .A(n2499), .B(n2387), .C(n910), .Y(n1503) );
  NAND2X1 U1143 ( .A(\registers[34][1] ), .B(n2499), .Y(n910) );
  OAI21X1 U1144 ( .A(n2499), .B(n2381), .C(n911), .Y(n1504) );
  NAND2X1 U1145 ( .A(\registers[34][2] ), .B(n2499), .Y(n911) );
  OAI21X1 U1146 ( .A(n2499), .B(n2375), .C(n912), .Y(n1505) );
  NAND2X1 U1147 ( .A(\registers[34][3] ), .B(n2499), .Y(n912) );
  OAI21X1 U1148 ( .A(n2499), .B(n2369), .C(n913), .Y(n1506) );
  NAND2X1 U1149 ( .A(\registers[34][4] ), .B(n2499), .Y(n913) );
  OAI21X1 U1150 ( .A(n2499), .B(n2363), .C(n914), .Y(n1507) );
  NAND2X1 U1151 ( .A(\registers[34][5] ), .B(n2499), .Y(n914) );
  OAI21X1 U1152 ( .A(n2499), .B(n2357), .C(n915), .Y(n1508) );
  NAND2X1 U1153 ( .A(\registers[34][6] ), .B(n2499), .Y(n915) );
  OAI21X1 U1154 ( .A(n2499), .B(n2351), .C(n916), .Y(n1509) );
  NAND2X1 U1155 ( .A(\registers[34][7] ), .B(n2499), .Y(n916) );
  OAI21X1 U1156 ( .A(n2499), .B(n2345), .C(n917), .Y(n1510) );
  NAND2X1 U1157 ( .A(\registers[34][0] ), .B(n2499), .Y(n917) );
  OAI21X1 U1158 ( .A(n695), .B(n873), .C(n2336), .Y(n918) );
  OAI21X1 U1159 ( .A(n2498), .B(n2387), .C(n919), .Y(n1511) );
  NAND2X1 U1160 ( .A(\registers[33][1] ), .B(n2498), .Y(n919) );
  OAI21X1 U1161 ( .A(n2498), .B(n2381), .C(n920), .Y(n1512) );
  NAND2X1 U1162 ( .A(\registers[33][2] ), .B(n2498), .Y(n920) );
  OAI21X1 U1163 ( .A(n2498), .B(n2375), .C(n921), .Y(n1513) );
  NAND2X1 U1164 ( .A(\registers[33][3] ), .B(n2498), .Y(n921) );
  OAI21X1 U1165 ( .A(n2498), .B(n2369), .C(n922), .Y(n1514) );
  NAND2X1 U1166 ( .A(\registers[33][4] ), .B(n2498), .Y(n922) );
  OAI21X1 U1167 ( .A(n2498), .B(n2363), .C(n923), .Y(n1515) );
  NAND2X1 U1168 ( .A(\registers[33][5] ), .B(n2498), .Y(n923) );
  OAI21X1 U1169 ( .A(n2498), .B(n2357), .C(n924), .Y(n1516) );
  NAND2X1 U1170 ( .A(\registers[33][6] ), .B(n2498), .Y(n924) );
  OAI21X1 U1171 ( .A(n2498), .B(n2351), .C(n925), .Y(n1517) );
  NAND2X1 U1172 ( .A(\registers[33][7] ), .B(n2498), .Y(n925) );
  OAI21X1 U1173 ( .A(n2498), .B(n2345), .C(n926), .Y(n1518) );
  NAND2X1 U1174 ( .A(\registers[33][0] ), .B(n2498), .Y(n926) );
  OAI21X1 U1175 ( .A(n705), .B(n873), .C(n2337), .Y(n927) );
  OAI21X1 U1176 ( .A(n2497), .B(n2387), .C(n928), .Y(n1519) );
  NAND2X1 U1177 ( .A(\registers[32][1] ), .B(n2497), .Y(n928) );
  OAI21X1 U1178 ( .A(n2497), .B(n2381), .C(n929), .Y(n1520) );
  NAND2X1 U1179 ( .A(\registers[32][2] ), .B(n2497), .Y(n929) );
  OAI21X1 U1180 ( .A(n2497), .B(n2375), .C(n930), .Y(n1521) );
  NAND2X1 U1181 ( .A(\registers[32][3] ), .B(n2497), .Y(n930) );
  OAI21X1 U1182 ( .A(n2497), .B(n2369), .C(n931), .Y(n1522) );
  NAND2X1 U1183 ( .A(\registers[32][4] ), .B(n2497), .Y(n931) );
  OAI21X1 U1184 ( .A(n2497), .B(n2363), .C(n932), .Y(n1523) );
  NAND2X1 U1185 ( .A(\registers[32][5] ), .B(n2497), .Y(n932) );
  OAI21X1 U1186 ( .A(n2497), .B(n2357), .C(n933), .Y(n1524) );
  NAND2X1 U1187 ( .A(\registers[32][6] ), .B(n2497), .Y(n933) );
  OAI21X1 U1188 ( .A(n2497), .B(n2351), .C(n934), .Y(n1525) );
  NAND2X1 U1189 ( .A(\registers[32][7] ), .B(n2497), .Y(n934) );
  OAI21X1 U1190 ( .A(n2497), .B(n2345), .C(n935), .Y(n1526) );
  NAND2X1 U1191 ( .A(\registers[32][0] ), .B(n2497), .Y(n935) );
  OAI21X1 U1192 ( .A(n715), .B(n873), .C(n2336), .Y(n936) );
  NAND3X1 U1193 ( .A(wpointer[5]), .B(n2529), .C(n937), .Y(n873) );
  NOR2X1 U1194 ( .A(wpointer[4]), .B(wpointer[3]), .Y(n937) );
  OAI21X1 U1195 ( .A(n2496), .B(n2387), .C(n938), .Y(n1527) );
  NAND2X1 U1196 ( .A(\registers[31][1] ), .B(n2496), .Y(n938) );
  OAI21X1 U1197 ( .A(n2496), .B(n2381), .C(n939), .Y(n1528) );
  NAND2X1 U1198 ( .A(\registers[31][2] ), .B(n2496), .Y(n939) );
  OAI21X1 U1199 ( .A(n2496), .B(n2375), .C(n940), .Y(n1529) );
  NAND2X1 U1200 ( .A(\registers[31][3] ), .B(n2496), .Y(n940) );
  OAI21X1 U1201 ( .A(n2496), .B(n2369), .C(n941), .Y(n1530) );
  NAND2X1 U1202 ( .A(\registers[31][4] ), .B(n2496), .Y(n941) );
  OAI21X1 U1203 ( .A(n2496), .B(n2363), .C(n942), .Y(n1531) );
  NAND2X1 U1204 ( .A(\registers[31][5] ), .B(n2496), .Y(n942) );
  OAI21X1 U1205 ( .A(n2496), .B(n2357), .C(n943), .Y(n1532) );
  NAND2X1 U1206 ( .A(\registers[31][6] ), .B(n2496), .Y(n943) );
  OAI21X1 U1207 ( .A(n2496), .B(n2351), .C(n944), .Y(n1533) );
  NAND2X1 U1208 ( .A(\registers[31][7] ), .B(n2496), .Y(n944) );
  OAI21X1 U1209 ( .A(n2496), .B(n2345), .C(n945), .Y(n1534) );
  NAND2X1 U1210 ( .A(\registers[31][0] ), .B(n2496), .Y(n945) );
  OAI21X1 U1211 ( .A(n644), .B(n947), .C(n2337), .Y(n946) );
  OAI21X1 U1212 ( .A(n2495), .B(n2387), .C(n948), .Y(n1535) );
  NAND2X1 U1213 ( .A(\registers[30][1] ), .B(n2495), .Y(n948) );
  OAI21X1 U1214 ( .A(n2495), .B(n2381), .C(n949), .Y(n1536) );
  NAND2X1 U1215 ( .A(\registers[30][2] ), .B(n2495), .Y(n949) );
  OAI21X1 U1216 ( .A(n2495), .B(n2375), .C(n950), .Y(n1537) );
  NAND2X1 U1217 ( .A(\registers[30][3] ), .B(n2495), .Y(n950) );
  OAI21X1 U1218 ( .A(n2495), .B(n2369), .C(n951), .Y(n1538) );
  NAND2X1 U1219 ( .A(\registers[30][4] ), .B(n2495), .Y(n951) );
  OAI21X1 U1220 ( .A(n2495), .B(n2363), .C(n952), .Y(n1539) );
  NAND2X1 U1221 ( .A(\registers[30][5] ), .B(n2495), .Y(n952) );
  OAI21X1 U1222 ( .A(n2495), .B(n2357), .C(n953), .Y(n1540) );
  NAND2X1 U1223 ( .A(\registers[30][6] ), .B(n2495), .Y(n953) );
  OAI21X1 U1224 ( .A(n2495), .B(n2351), .C(n954), .Y(n1541) );
  NAND2X1 U1225 ( .A(\registers[30][7] ), .B(n2495), .Y(n954) );
  OAI21X1 U1226 ( .A(n2495), .B(n2345), .C(n955), .Y(n1542) );
  NAND2X1 U1227 ( .A(\registers[30][0] ), .B(n2495), .Y(n955) );
  OAI21X1 U1228 ( .A(n655), .B(n947), .C(n2336), .Y(n956) );
  OAI21X1 U1229 ( .A(n2494), .B(n2387), .C(n957), .Y(n1543) );
  NAND2X1 U1230 ( .A(\registers[29][1] ), .B(n2494), .Y(n957) );
  OAI21X1 U1231 ( .A(n2494), .B(n2381), .C(n958), .Y(n1544) );
  NAND2X1 U1232 ( .A(\registers[29][2] ), .B(n2494), .Y(n958) );
  OAI21X1 U1233 ( .A(n2494), .B(n2375), .C(n959), .Y(n1545) );
  NAND2X1 U1234 ( .A(\registers[29][3] ), .B(n2494), .Y(n959) );
  OAI21X1 U1235 ( .A(n2494), .B(n2369), .C(n960), .Y(n1546) );
  NAND2X1 U1236 ( .A(\registers[29][4] ), .B(n2494), .Y(n960) );
  OAI21X1 U1237 ( .A(n2494), .B(n2363), .C(n961), .Y(n1547) );
  NAND2X1 U1238 ( .A(\registers[29][5] ), .B(n2494), .Y(n961) );
  OAI21X1 U1239 ( .A(n2494), .B(n2357), .C(n962), .Y(n1548) );
  NAND2X1 U1240 ( .A(\registers[29][6] ), .B(n2494), .Y(n962) );
  OAI21X1 U1241 ( .A(n2494), .B(n2351), .C(n963), .Y(n1549) );
  NAND2X1 U1242 ( .A(\registers[29][7] ), .B(n2494), .Y(n963) );
  OAI21X1 U1243 ( .A(n2494), .B(n2345), .C(n964), .Y(n1550) );
  NAND2X1 U1244 ( .A(\registers[29][0] ), .B(n2494), .Y(n964) );
  OAI21X1 U1245 ( .A(n665), .B(n947), .C(n2336), .Y(n965) );
  OAI21X1 U1246 ( .A(n2493), .B(n2387), .C(n966), .Y(n1551) );
  NAND2X1 U1247 ( .A(\registers[28][1] ), .B(n2493), .Y(n966) );
  OAI21X1 U1248 ( .A(n2493), .B(n2381), .C(n967), .Y(n1552) );
  NAND2X1 U1249 ( .A(\registers[28][2] ), .B(n2493), .Y(n967) );
  OAI21X1 U1250 ( .A(n2493), .B(n2375), .C(n968), .Y(n1553) );
  NAND2X1 U1251 ( .A(\registers[28][3] ), .B(n2493), .Y(n968) );
  OAI21X1 U1252 ( .A(n2493), .B(n2369), .C(n969), .Y(n1554) );
  NAND2X1 U1253 ( .A(\registers[28][4] ), .B(n2493), .Y(n969) );
  OAI21X1 U1254 ( .A(n2493), .B(n2363), .C(n970), .Y(n1555) );
  NAND2X1 U1255 ( .A(\registers[28][5] ), .B(n2493), .Y(n970) );
  OAI21X1 U1256 ( .A(n2493), .B(n2357), .C(n971), .Y(n1556) );
  NAND2X1 U1257 ( .A(\registers[28][6] ), .B(n2493), .Y(n971) );
  OAI21X1 U1258 ( .A(n2493), .B(n2351), .C(n972), .Y(n1557) );
  NAND2X1 U1259 ( .A(\registers[28][7] ), .B(n2493), .Y(n972) );
  OAI21X1 U1260 ( .A(n2493), .B(n2345), .C(n973), .Y(n1558) );
  NAND2X1 U1261 ( .A(\registers[28][0] ), .B(n2493), .Y(n973) );
  OAI21X1 U1262 ( .A(n675), .B(n947), .C(n2337), .Y(n974) );
  OAI21X1 U1263 ( .A(n2492), .B(n2387), .C(n975), .Y(n1559) );
  NAND2X1 U1264 ( .A(\registers[27][1] ), .B(n2492), .Y(n975) );
  OAI21X1 U1265 ( .A(n2492), .B(n2381), .C(n976), .Y(n1560) );
  NAND2X1 U1266 ( .A(\registers[27][2] ), .B(n2492), .Y(n976) );
  OAI21X1 U1267 ( .A(n2492), .B(n2375), .C(n977), .Y(n1561) );
  NAND2X1 U1268 ( .A(\registers[27][3] ), .B(n2492), .Y(n977) );
  OAI21X1 U1269 ( .A(n2492), .B(n2369), .C(n978), .Y(n1562) );
  NAND2X1 U1270 ( .A(\registers[27][4] ), .B(n2492), .Y(n978) );
  OAI21X1 U1271 ( .A(n2492), .B(n2363), .C(n979), .Y(n1563) );
  NAND2X1 U1272 ( .A(\registers[27][5] ), .B(n2492), .Y(n979) );
  OAI21X1 U1273 ( .A(n2492), .B(n2357), .C(n980), .Y(n1564) );
  NAND2X1 U1274 ( .A(\registers[27][6] ), .B(n2492), .Y(n980) );
  OAI21X1 U1275 ( .A(n2492), .B(n2351), .C(n981), .Y(n1565) );
  NAND2X1 U1276 ( .A(\registers[27][7] ), .B(n2492), .Y(n981) );
  OAI21X1 U1277 ( .A(n2492), .B(n2345), .C(n982), .Y(n1566) );
  NAND2X1 U1278 ( .A(\registers[27][0] ), .B(n2492), .Y(n982) );
  OAI21X1 U1279 ( .A(n685), .B(n947), .C(n2337), .Y(n983) );
  OAI21X1 U1280 ( .A(n2491), .B(n2387), .C(n984), .Y(n1567) );
  NAND2X1 U1281 ( .A(\registers[26][1] ), .B(n2491), .Y(n984) );
  OAI21X1 U1282 ( .A(n2491), .B(n2381), .C(n985), .Y(n1568) );
  NAND2X1 U1283 ( .A(\registers[26][2] ), .B(n2491), .Y(n985) );
  OAI21X1 U1284 ( .A(n2491), .B(n2375), .C(n986), .Y(n1569) );
  NAND2X1 U1285 ( .A(\registers[26][3] ), .B(n2491), .Y(n986) );
  OAI21X1 U1286 ( .A(n2491), .B(n2369), .C(n987), .Y(n1570) );
  NAND2X1 U1287 ( .A(\registers[26][4] ), .B(n2491), .Y(n987) );
  OAI21X1 U1288 ( .A(n2491), .B(n2363), .C(n988), .Y(n1571) );
  NAND2X1 U1289 ( .A(\registers[26][5] ), .B(n2491), .Y(n988) );
  OAI21X1 U1290 ( .A(n2491), .B(n2357), .C(n989), .Y(n1572) );
  NAND2X1 U1291 ( .A(\registers[26][6] ), .B(n2491), .Y(n989) );
  OAI21X1 U1292 ( .A(n2491), .B(n2351), .C(n990), .Y(n1573) );
  NAND2X1 U1293 ( .A(\registers[26][7] ), .B(n2491), .Y(n990) );
  OAI21X1 U1294 ( .A(n2491), .B(n2345), .C(n991), .Y(n1574) );
  NAND2X1 U1295 ( .A(\registers[26][0] ), .B(n2491), .Y(n991) );
  OAI21X1 U1296 ( .A(n695), .B(n947), .C(n2337), .Y(n992) );
  OAI21X1 U1297 ( .A(n2490), .B(n2387), .C(n993), .Y(n1575) );
  NAND2X1 U1298 ( .A(\registers[25][1] ), .B(n2490), .Y(n993) );
  OAI21X1 U1299 ( .A(n2490), .B(n2381), .C(n994), .Y(n1576) );
  NAND2X1 U1300 ( .A(\registers[25][2] ), .B(n2490), .Y(n994) );
  OAI21X1 U1301 ( .A(n2490), .B(n2375), .C(n995), .Y(n1577) );
  NAND2X1 U1302 ( .A(\registers[25][3] ), .B(n2490), .Y(n995) );
  OAI21X1 U1303 ( .A(n2490), .B(n2369), .C(n996), .Y(n1578) );
  NAND2X1 U1304 ( .A(\registers[25][4] ), .B(n2490), .Y(n996) );
  OAI21X1 U1305 ( .A(n2490), .B(n2363), .C(n997), .Y(n1579) );
  NAND2X1 U1306 ( .A(\registers[25][5] ), .B(n2490), .Y(n997) );
  OAI21X1 U1307 ( .A(n2490), .B(n2357), .C(n998), .Y(n1580) );
  NAND2X1 U1308 ( .A(\registers[25][6] ), .B(n2490), .Y(n998) );
  OAI21X1 U1309 ( .A(n2490), .B(n2351), .C(n999), .Y(n1581) );
  NAND2X1 U1310 ( .A(\registers[25][7] ), .B(n2490), .Y(n999) );
  OAI21X1 U1311 ( .A(n2490), .B(n2345), .C(n1000), .Y(n1582) );
  NAND2X1 U1312 ( .A(\registers[25][0] ), .B(n2490), .Y(n1000) );
  OAI21X1 U1313 ( .A(n705), .B(n947), .C(n2336), .Y(n1001) );
  OAI21X1 U1314 ( .A(n2489), .B(n2387), .C(n1002), .Y(n1583) );
  NAND2X1 U1315 ( .A(\registers[24][1] ), .B(n2489), .Y(n1002) );
  OAI21X1 U1316 ( .A(n2489), .B(n2381), .C(n1003), .Y(n1584) );
  NAND2X1 U1317 ( .A(\registers[24][2] ), .B(n2489), .Y(n1003) );
  OAI21X1 U1318 ( .A(n2489), .B(n2375), .C(n1004), .Y(n1585) );
  NAND2X1 U1319 ( .A(\registers[24][3] ), .B(n2489), .Y(n1004) );
  OAI21X1 U1320 ( .A(n2489), .B(n2369), .C(n1005), .Y(n1586) );
  NAND2X1 U1321 ( .A(\registers[24][4] ), .B(n2489), .Y(n1005) );
  OAI21X1 U1322 ( .A(n2489), .B(n2363), .C(n1006), .Y(n1587) );
  NAND2X1 U1323 ( .A(\registers[24][5] ), .B(n2489), .Y(n1006) );
  OAI21X1 U1324 ( .A(n2489), .B(n2357), .C(n1007), .Y(n1588) );
  NAND2X1 U1325 ( .A(\registers[24][6] ), .B(n2489), .Y(n1007) );
  OAI21X1 U1326 ( .A(n2489), .B(n2351), .C(n1008), .Y(n1589) );
  NAND2X1 U1327 ( .A(\registers[24][7] ), .B(n2489), .Y(n1008) );
  OAI21X1 U1328 ( .A(n2489), .B(n2345), .C(n1009), .Y(n1590) );
  NAND2X1 U1329 ( .A(\registers[24][0] ), .B(n2489), .Y(n1009) );
  OAI21X1 U1330 ( .A(n715), .B(n947), .C(n2336), .Y(n1010) );
  NAND3X1 U1331 ( .A(n2529), .B(n2544), .C(n1011), .Y(n947) );
  NOR2X1 U1332 ( .A(n2542), .B(n2543), .Y(n1011) );
  OAI21X1 U1333 ( .A(n2488), .B(n2386), .C(n1012), .Y(n1591) );
  NAND2X1 U1334 ( .A(\registers[23][1] ), .B(n2488), .Y(n1012) );
  OAI21X1 U1335 ( .A(n2488), .B(n2380), .C(n1013), .Y(n1592) );
  NAND2X1 U1336 ( .A(\registers[23][2] ), .B(n2488), .Y(n1013) );
  OAI21X1 U1337 ( .A(n2488), .B(n2374), .C(n1014), .Y(n1593) );
  NAND2X1 U1338 ( .A(\registers[23][3] ), .B(n2488), .Y(n1014) );
  OAI21X1 U1339 ( .A(n2488), .B(n2368), .C(n1015), .Y(n1594) );
  NAND2X1 U1340 ( .A(\registers[23][4] ), .B(n2488), .Y(n1015) );
  OAI21X1 U1341 ( .A(n2488), .B(n2362), .C(n1016), .Y(n1595) );
  NAND2X1 U1342 ( .A(\registers[23][5] ), .B(n2488), .Y(n1016) );
  OAI21X1 U1343 ( .A(n2488), .B(n2356), .C(n1017), .Y(n1596) );
  NAND2X1 U1344 ( .A(\registers[23][6] ), .B(n2488), .Y(n1017) );
  OAI21X1 U1345 ( .A(n2488), .B(n2350), .C(n1018), .Y(n1597) );
  NAND2X1 U1346 ( .A(\registers[23][7] ), .B(n2488), .Y(n1018) );
  OAI21X1 U1347 ( .A(n2488), .B(n2344), .C(n1019), .Y(n1598) );
  NAND2X1 U1348 ( .A(\registers[23][0] ), .B(n2488), .Y(n1019) );
  OAI21X1 U1349 ( .A(n644), .B(n1021), .C(n2336), .Y(n1020) );
  OAI21X1 U1350 ( .A(n2487), .B(n2386), .C(n1022), .Y(n1599) );
  NAND2X1 U1351 ( .A(\registers[22][1] ), .B(n2487), .Y(n1022) );
  OAI21X1 U1352 ( .A(n2487), .B(n2380), .C(n1023), .Y(n1600) );
  NAND2X1 U1353 ( .A(\registers[22][2] ), .B(n2487), .Y(n1023) );
  OAI21X1 U1354 ( .A(n2487), .B(n2374), .C(n1024), .Y(n1601) );
  NAND2X1 U1355 ( .A(\registers[22][3] ), .B(n2487), .Y(n1024) );
  OAI21X1 U1356 ( .A(n2487), .B(n2368), .C(n1025), .Y(n1602) );
  NAND2X1 U1357 ( .A(\registers[22][4] ), .B(n2487), .Y(n1025) );
  OAI21X1 U1358 ( .A(n2487), .B(n2362), .C(n1026), .Y(n1603) );
  NAND2X1 U1359 ( .A(\registers[22][5] ), .B(n2487), .Y(n1026) );
  OAI21X1 U1360 ( .A(n2487), .B(n2356), .C(n1027), .Y(n1604) );
  NAND2X1 U1361 ( .A(\registers[22][6] ), .B(n2487), .Y(n1027) );
  OAI21X1 U1362 ( .A(n2487), .B(n2350), .C(n1028), .Y(n1605) );
  NAND2X1 U1363 ( .A(\registers[22][7] ), .B(n2487), .Y(n1028) );
  OAI21X1 U1364 ( .A(n2487), .B(n2344), .C(n1029), .Y(n1606) );
  NAND2X1 U1365 ( .A(\registers[22][0] ), .B(n2487), .Y(n1029) );
  OAI21X1 U1366 ( .A(n655), .B(n1021), .C(n2336), .Y(n1030) );
  OAI21X1 U1367 ( .A(n2486), .B(n2386), .C(n1031), .Y(n1607) );
  NAND2X1 U1368 ( .A(\registers[21][1] ), .B(n2486), .Y(n1031) );
  OAI21X1 U1369 ( .A(n2486), .B(n2380), .C(n1032), .Y(n1608) );
  NAND2X1 U1370 ( .A(\registers[21][2] ), .B(n2486), .Y(n1032) );
  OAI21X1 U1371 ( .A(n2486), .B(n2374), .C(n1033), .Y(n1609) );
  NAND2X1 U1372 ( .A(\registers[21][3] ), .B(n2486), .Y(n1033) );
  OAI21X1 U1373 ( .A(n2486), .B(n2368), .C(n1034), .Y(n1610) );
  NAND2X1 U1374 ( .A(\registers[21][4] ), .B(n2486), .Y(n1034) );
  OAI21X1 U1375 ( .A(n2486), .B(n2362), .C(n1035), .Y(n1611) );
  NAND2X1 U1376 ( .A(\registers[21][5] ), .B(n2486), .Y(n1035) );
  OAI21X1 U1377 ( .A(n2486), .B(n2356), .C(n1036), .Y(n1612) );
  NAND2X1 U1378 ( .A(\registers[21][6] ), .B(n2486), .Y(n1036) );
  OAI21X1 U1379 ( .A(n2486), .B(n2350), .C(n1037), .Y(n1613) );
  NAND2X1 U1380 ( .A(\registers[21][7] ), .B(n2486), .Y(n1037) );
  OAI21X1 U1381 ( .A(n2486), .B(n2344), .C(n1038), .Y(n1614) );
  NAND2X1 U1382 ( .A(\registers[21][0] ), .B(n2486), .Y(n1038) );
  OAI21X1 U1383 ( .A(n665), .B(n1021), .C(n2336), .Y(n1039) );
  OAI21X1 U1384 ( .A(n2485), .B(n2386), .C(n1040), .Y(n1615) );
  NAND2X1 U1385 ( .A(\registers[20][1] ), .B(n2485), .Y(n1040) );
  OAI21X1 U1386 ( .A(n2485), .B(n2380), .C(n1041), .Y(n1616) );
  NAND2X1 U1387 ( .A(\registers[20][2] ), .B(n2485), .Y(n1041) );
  OAI21X1 U1388 ( .A(n2485), .B(n2374), .C(n1042), .Y(n1617) );
  NAND2X1 U1389 ( .A(\registers[20][3] ), .B(n2485), .Y(n1042) );
  OAI21X1 U1390 ( .A(n2485), .B(n2368), .C(n1043), .Y(n1618) );
  NAND2X1 U1391 ( .A(\registers[20][4] ), .B(n2485), .Y(n1043) );
  OAI21X1 U1392 ( .A(n2485), .B(n2362), .C(n1044), .Y(n1619) );
  NAND2X1 U1393 ( .A(\registers[20][5] ), .B(n2485), .Y(n1044) );
  OAI21X1 U1394 ( .A(n2485), .B(n2356), .C(n1045), .Y(n1620) );
  NAND2X1 U1395 ( .A(\registers[20][6] ), .B(n2485), .Y(n1045) );
  OAI21X1 U1396 ( .A(n2485), .B(n2350), .C(n1046), .Y(n1621) );
  NAND2X1 U1397 ( .A(\registers[20][7] ), .B(n2485), .Y(n1046) );
  OAI21X1 U1398 ( .A(n2485), .B(n2344), .C(n1047), .Y(n1622) );
  NAND2X1 U1399 ( .A(\registers[20][0] ), .B(n2485), .Y(n1047) );
  OAI21X1 U1400 ( .A(n675), .B(n1021), .C(n2336), .Y(n1048) );
  OAI21X1 U1401 ( .A(n2484), .B(n2386), .C(n1049), .Y(n1623) );
  NAND2X1 U1402 ( .A(\registers[19][1] ), .B(n2484), .Y(n1049) );
  OAI21X1 U1403 ( .A(n2484), .B(n2380), .C(n1050), .Y(n1624) );
  NAND2X1 U1404 ( .A(\registers[19][2] ), .B(n2484), .Y(n1050) );
  OAI21X1 U1405 ( .A(n2484), .B(n2374), .C(n1051), .Y(n1625) );
  NAND2X1 U1406 ( .A(\registers[19][3] ), .B(n2484), .Y(n1051) );
  OAI21X1 U1407 ( .A(n2484), .B(n2368), .C(n1052), .Y(n1626) );
  NAND2X1 U1408 ( .A(\registers[19][4] ), .B(n2484), .Y(n1052) );
  OAI21X1 U1409 ( .A(n2484), .B(n2362), .C(n1053), .Y(n1627) );
  NAND2X1 U1410 ( .A(\registers[19][5] ), .B(n2484), .Y(n1053) );
  OAI21X1 U1411 ( .A(n2484), .B(n2356), .C(n1054), .Y(n1628) );
  NAND2X1 U1412 ( .A(\registers[19][6] ), .B(n2484), .Y(n1054) );
  OAI21X1 U1413 ( .A(n2484), .B(n2350), .C(n1055), .Y(n1629) );
  NAND2X1 U1414 ( .A(\registers[19][7] ), .B(n2484), .Y(n1055) );
  OAI21X1 U1415 ( .A(n2484), .B(n2344), .C(n1056), .Y(n1630) );
  NAND2X1 U1416 ( .A(\registers[19][0] ), .B(n2484), .Y(n1056) );
  OAI21X1 U1417 ( .A(n685), .B(n1021), .C(n2336), .Y(n1057) );
  OAI21X1 U1418 ( .A(n2483), .B(n2386), .C(n1058), .Y(n1631) );
  NAND2X1 U1419 ( .A(\registers[18][1] ), .B(n2483), .Y(n1058) );
  OAI21X1 U1420 ( .A(n2483), .B(n2380), .C(n1059), .Y(n1632) );
  NAND2X1 U1421 ( .A(\registers[18][2] ), .B(n2483), .Y(n1059) );
  OAI21X1 U1422 ( .A(n2483), .B(n2374), .C(n1060), .Y(n1633) );
  NAND2X1 U1423 ( .A(\registers[18][3] ), .B(n2483), .Y(n1060) );
  OAI21X1 U1424 ( .A(n2483), .B(n2368), .C(n1061), .Y(n1634) );
  NAND2X1 U1425 ( .A(\registers[18][4] ), .B(n2483), .Y(n1061) );
  OAI21X1 U1426 ( .A(n2483), .B(n2362), .C(n1062), .Y(n1635) );
  NAND2X1 U1427 ( .A(\registers[18][5] ), .B(n2483), .Y(n1062) );
  OAI21X1 U1428 ( .A(n2483), .B(n2356), .C(n1063), .Y(n1636) );
  NAND2X1 U1429 ( .A(\registers[18][6] ), .B(n2483), .Y(n1063) );
  OAI21X1 U1430 ( .A(n2483), .B(n2350), .C(n1064), .Y(n1637) );
  NAND2X1 U1431 ( .A(\registers[18][7] ), .B(n2483), .Y(n1064) );
  OAI21X1 U1432 ( .A(n2483), .B(n2344), .C(n1065), .Y(n1638) );
  NAND2X1 U1433 ( .A(\registers[18][0] ), .B(n2483), .Y(n1065) );
  OAI21X1 U1434 ( .A(n695), .B(n1021), .C(n2336), .Y(n1066) );
  OAI21X1 U1435 ( .A(n2482), .B(n2386), .C(n1067), .Y(n1639) );
  NAND2X1 U1436 ( .A(\registers[17][1] ), .B(n2482), .Y(n1067) );
  OAI21X1 U1437 ( .A(n2482), .B(n2380), .C(n1068), .Y(n1640) );
  NAND2X1 U1438 ( .A(\registers[17][2] ), .B(n2482), .Y(n1068) );
  OAI21X1 U1439 ( .A(n2482), .B(n2374), .C(n1069), .Y(n1641) );
  NAND2X1 U1440 ( .A(\registers[17][3] ), .B(n2482), .Y(n1069) );
  OAI21X1 U1441 ( .A(n2482), .B(n2368), .C(n1070), .Y(n1642) );
  NAND2X1 U1442 ( .A(\registers[17][4] ), .B(n2482), .Y(n1070) );
  OAI21X1 U1443 ( .A(n2482), .B(n2362), .C(n1071), .Y(n1643) );
  NAND2X1 U1444 ( .A(\registers[17][5] ), .B(n2482), .Y(n1071) );
  OAI21X1 U1445 ( .A(n2482), .B(n2356), .C(n1072), .Y(n1644) );
  NAND2X1 U1446 ( .A(\registers[17][6] ), .B(n2482), .Y(n1072) );
  OAI21X1 U1447 ( .A(n2482), .B(n2350), .C(n1073), .Y(n1645) );
  NAND2X1 U1448 ( .A(\registers[17][7] ), .B(n2482), .Y(n1073) );
  OAI21X1 U1449 ( .A(n2482), .B(n2344), .C(n1074), .Y(n1646) );
  NAND2X1 U1450 ( .A(\registers[17][0] ), .B(n2482), .Y(n1074) );
  OAI21X1 U1451 ( .A(n705), .B(n1021), .C(n2336), .Y(n1075) );
  OAI21X1 U1452 ( .A(n2481), .B(n2386), .C(n1076), .Y(n1647) );
  NAND2X1 U1453 ( .A(\registers[16][1] ), .B(n2481), .Y(n1076) );
  OAI21X1 U1454 ( .A(n2481), .B(n2380), .C(n1077), .Y(n1648) );
  NAND2X1 U1455 ( .A(\registers[16][2] ), .B(n2481), .Y(n1077) );
  OAI21X1 U1456 ( .A(n2481), .B(n2374), .C(n1078), .Y(n1649) );
  NAND2X1 U1457 ( .A(\registers[16][3] ), .B(n2481), .Y(n1078) );
  OAI21X1 U1458 ( .A(n2481), .B(n2368), .C(n1079), .Y(n1650) );
  NAND2X1 U1459 ( .A(\registers[16][4] ), .B(n2481), .Y(n1079) );
  OAI21X1 U1460 ( .A(n2481), .B(n2362), .C(n1080), .Y(n1651) );
  NAND2X1 U1461 ( .A(\registers[16][5] ), .B(n2481), .Y(n1080) );
  OAI21X1 U1462 ( .A(n2481), .B(n2356), .C(n1081), .Y(n1652) );
  NAND2X1 U1463 ( .A(\registers[16][6] ), .B(n2481), .Y(n1081) );
  OAI21X1 U1464 ( .A(n2481), .B(n2350), .C(n1082), .Y(n1653) );
  NAND2X1 U1465 ( .A(\registers[16][7] ), .B(n2481), .Y(n1082) );
  OAI21X1 U1466 ( .A(n2481), .B(n2344), .C(n1083), .Y(n1654) );
  NAND2X1 U1467 ( .A(\registers[16][0] ), .B(n2481), .Y(n1083) );
  OAI21X1 U1468 ( .A(n715), .B(n1021), .C(n2336), .Y(n1084) );
  NAND3X1 U1469 ( .A(wpointer[4]), .B(n2529), .C(n1085), .Y(n1021) );
  NOR2X1 U1470 ( .A(wpointer[5]), .B(wpointer[3]), .Y(n1085) );
  OAI21X1 U1471 ( .A(n2480), .B(n2386), .C(n1086), .Y(n1655) );
  NAND2X1 U1472 ( .A(\registers[15][1] ), .B(n2480), .Y(n1086) );
  OAI21X1 U1473 ( .A(n2480), .B(n2380), .C(n1087), .Y(n1656) );
  NAND2X1 U1474 ( .A(\registers[15][2] ), .B(n2480), .Y(n1087) );
  OAI21X1 U1475 ( .A(n2480), .B(n2374), .C(n1088), .Y(n1657) );
  NAND2X1 U1476 ( .A(\registers[15][3] ), .B(n2480), .Y(n1088) );
  OAI21X1 U1477 ( .A(n2480), .B(n2368), .C(n1089), .Y(n1658) );
  NAND2X1 U1478 ( .A(\registers[15][4] ), .B(n2480), .Y(n1089) );
  OAI21X1 U1479 ( .A(n2480), .B(n2362), .C(n1090), .Y(n1659) );
  NAND2X1 U1480 ( .A(\registers[15][5] ), .B(n2480), .Y(n1090) );
  OAI21X1 U1481 ( .A(n2480), .B(n2356), .C(n1091), .Y(n1660) );
  NAND2X1 U1482 ( .A(\registers[15][6] ), .B(n2480), .Y(n1091) );
  OAI21X1 U1483 ( .A(n2480), .B(n2350), .C(n1092), .Y(n1661) );
  NAND2X1 U1484 ( .A(\registers[15][7] ), .B(n2480), .Y(n1092) );
  OAI21X1 U1485 ( .A(n2480), .B(n2344), .C(n1093), .Y(n1662) );
  NAND2X1 U1486 ( .A(\registers[15][0] ), .B(n2480), .Y(n1093) );
  OAI21X1 U1487 ( .A(n644), .B(n1095), .C(n2336), .Y(n1094) );
  OAI21X1 U1488 ( .A(n2479), .B(n2386), .C(n1096), .Y(n1663) );
  NAND2X1 U1489 ( .A(\registers[14][1] ), .B(n2479), .Y(n1096) );
  OAI21X1 U1490 ( .A(n2479), .B(n2380), .C(n1097), .Y(n1664) );
  NAND2X1 U1491 ( .A(\registers[14][2] ), .B(n2479), .Y(n1097) );
  OAI21X1 U1492 ( .A(n2479), .B(n2374), .C(n1098), .Y(n1665) );
  NAND2X1 U1493 ( .A(\registers[14][3] ), .B(n2479), .Y(n1098) );
  OAI21X1 U1494 ( .A(n2479), .B(n2368), .C(n1099), .Y(n1666) );
  NAND2X1 U1495 ( .A(\registers[14][4] ), .B(n2479), .Y(n1099) );
  OAI21X1 U1496 ( .A(n2479), .B(n2362), .C(n1100), .Y(n1667) );
  NAND2X1 U1497 ( .A(\registers[14][5] ), .B(n2479), .Y(n1100) );
  OAI21X1 U1498 ( .A(n2479), .B(n2356), .C(n1101), .Y(n1668) );
  NAND2X1 U1499 ( .A(\registers[14][6] ), .B(n2479), .Y(n1101) );
  OAI21X1 U1500 ( .A(n2479), .B(n2350), .C(n1102), .Y(n1669) );
  NAND2X1 U1501 ( .A(\registers[14][7] ), .B(n2479), .Y(n1102) );
  OAI21X1 U1502 ( .A(n2479), .B(n2344), .C(n1103), .Y(n1670) );
  NAND2X1 U1503 ( .A(\registers[14][0] ), .B(n2479), .Y(n1103) );
  OAI21X1 U1504 ( .A(n655), .B(n1095), .C(n2336), .Y(n1104) );
  OAI21X1 U1505 ( .A(n2478), .B(n2386), .C(n1105), .Y(n1671) );
  NAND2X1 U1506 ( .A(\registers[13][1] ), .B(n2478), .Y(n1105) );
  OAI21X1 U1507 ( .A(n2478), .B(n2380), .C(n1106), .Y(n1672) );
  NAND2X1 U1508 ( .A(\registers[13][2] ), .B(n2478), .Y(n1106) );
  OAI21X1 U1509 ( .A(n2478), .B(n2374), .C(n1107), .Y(n1673) );
  NAND2X1 U1510 ( .A(\registers[13][3] ), .B(n2478), .Y(n1107) );
  OAI21X1 U1511 ( .A(n2478), .B(n2368), .C(n1108), .Y(n1674) );
  NAND2X1 U1512 ( .A(\registers[13][4] ), .B(n2478), .Y(n1108) );
  OAI21X1 U1513 ( .A(n2478), .B(n2362), .C(n1109), .Y(n1675) );
  NAND2X1 U1514 ( .A(\registers[13][5] ), .B(n2478), .Y(n1109) );
  OAI21X1 U1515 ( .A(n2478), .B(n2356), .C(n1110), .Y(n1676) );
  NAND2X1 U1516 ( .A(\registers[13][6] ), .B(n2478), .Y(n1110) );
  OAI21X1 U1517 ( .A(n2478), .B(n2350), .C(n1111), .Y(n1677) );
  NAND2X1 U1518 ( .A(\registers[13][7] ), .B(n2478), .Y(n1111) );
  OAI21X1 U1519 ( .A(n2478), .B(n2344), .C(n1112), .Y(n1678) );
  NAND2X1 U1520 ( .A(\registers[13][0] ), .B(n2478), .Y(n1112) );
  OAI21X1 U1521 ( .A(n665), .B(n1095), .C(n2336), .Y(n1113) );
  OAI21X1 U1522 ( .A(n2477), .B(n2386), .C(n1114), .Y(n1679) );
  NAND2X1 U1523 ( .A(\registers[12][1] ), .B(n2477), .Y(n1114) );
  OAI21X1 U1524 ( .A(n2477), .B(n2380), .C(n1115), .Y(n1680) );
  NAND2X1 U1525 ( .A(\registers[12][2] ), .B(n2477), .Y(n1115) );
  OAI21X1 U1526 ( .A(n2477), .B(n2374), .C(n1116), .Y(n1681) );
  NAND2X1 U1527 ( .A(\registers[12][3] ), .B(n2477), .Y(n1116) );
  OAI21X1 U1528 ( .A(n2477), .B(n2368), .C(n1117), .Y(n1682) );
  NAND2X1 U1529 ( .A(\registers[12][4] ), .B(n2477), .Y(n1117) );
  OAI21X1 U1530 ( .A(n2477), .B(n2362), .C(n1118), .Y(n1683) );
  NAND2X1 U1531 ( .A(\registers[12][5] ), .B(n2477), .Y(n1118) );
  OAI21X1 U1532 ( .A(n2477), .B(n2356), .C(n1119), .Y(n1684) );
  NAND2X1 U1533 ( .A(\registers[12][6] ), .B(n2477), .Y(n1119) );
  OAI21X1 U1534 ( .A(n2477), .B(n2350), .C(n1120), .Y(n1685) );
  NAND2X1 U1535 ( .A(\registers[12][7] ), .B(n2477), .Y(n1120) );
  OAI21X1 U1536 ( .A(n2477), .B(n2344), .C(n1121), .Y(n1686) );
  NAND2X1 U1537 ( .A(\registers[12][0] ), .B(n2477), .Y(n1121) );
  OAI21X1 U1538 ( .A(n675), .B(n1095), .C(n2337), .Y(n1122) );
  OAI21X1 U1539 ( .A(n2476), .B(n2385), .C(n1123), .Y(n1687) );
  NAND2X1 U1540 ( .A(\registers[11][1] ), .B(n2476), .Y(n1123) );
  OAI21X1 U1541 ( .A(n2476), .B(n2379), .C(n1124), .Y(n1688) );
  NAND2X1 U1542 ( .A(\registers[11][2] ), .B(n2476), .Y(n1124) );
  OAI21X1 U1543 ( .A(n2476), .B(n2373), .C(n1125), .Y(n1689) );
  NAND2X1 U1544 ( .A(\registers[11][3] ), .B(n2476), .Y(n1125) );
  OAI21X1 U1545 ( .A(n2476), .B(n2367), .C(n1126), .Y(n1690) );
  NAND2X1 U1546 ( .A(\registers[11][4] ), .B(n2476), .Y(n1126) );
  OAI21X1 U1547 ( .A(n2476), .B(n2361), .C(n1127), .Y(n1691) );
  NAND2X1 U1548 ( .A(\registers[11][5] ), .B(n2476), .Y(n1127) );
  OAI21X1 U1549 ( .A(n2476), .B(n2355), .C(n1128), .Y(n1692) );
  NAND2X1 U1550 ( .A(\registers[11][6] ), .B(n2476), .Y(n1128) );
  OAI21X1 U1551 ( .A(n2476), .B(n2349), .C(n1129), .Y(n1693) );
  NAND2X1 U1552 ( .A(\registers[11][7] ), .B(n2476), .Y(n1129) );
  OAI21X1 U1553 ( .A(n2476), .B(n2343), .C(n1130), .Y(n1694) );
  NAND2X1 U1554 ( .A(\registers[11][0] ), .B(n2476), .Y(n1130) );
  OAI21X1 U1555 ( .A(n685), .B(n1095), .C(n2337), .Y(n1131) );
  OAI21X1 U1556 ( .A(n2475), .B(n2385), .C(n1132), .Y(n1695) );
  NAND2X1 U1557 ( .A(\registers[10][1] ), .B(n2475), .Y(n1132) );
  OAI21X1 U1558 ( .A(n2475), .B(n2379), .C(n1133), .Y(n1696) );
  NAND2X1 U1559 ( .A(\registers[10][2] ), .B(n2475), .Y(n1133) );
  OAI21X1 U1560 ( .A(n2475), .B(n2373), .C(n1134), .Y(n1697) );
  NAND2X1 U1561 ( .A(\registers[10][3] ), .B(n2475), .Y(n1134) );
  OAI21X1 U1562 ( .A(n2475), .B(n2367), .C(n1135), .Y(n1698) );
  NAND2X1 U1563 ( .A(\registers[10][4] ), .B(n2475), .Y(n1135) );
  OAI21X1 U1564 ( .A(n2475), .B(n2361), .C(n1136), .Y(n1699) );
  NAND2X1 U1565 ( .A(\registers[10][5] ), .B(n2475), .Y(n1136) );
  OAI21X1 U1566 ( .A(n2475), .B(n2355), .C(n1137), .Y(n1700) );
  NAND2X1 U1567 ( .A(\registers[10][6] ), .B(n2475), .Y(n1137) );
  OAI21X1 U1568 ( .A(n2475), .B(n2349), .C(n1138), .Y(n1701) );
  NAND2X1 U1569 ( .A(\registers[10][7] ), .B(n2475), .Y(n1138) );
  OAI21X1 U1570 ( .A(n2475), .B(n2343), .C(n1139), .Y(n1702) );
  NAND2X1 U1571 ( .A(\registers[10][0] ), .B(n2475), .Y(n1139) );
  OAI21X1 U1572 ( .A(n695), .B(n1095), .C(n2337), .Y(n1140) );
  OAI21X1 U1573 ( .A(n2474), .B(n2385), .C(n1141), .Y(n1703) );
  NAND2X1 U1574 ( .A(\registers[9][1] ), .B(n2474), .Y(n1141) );
  OAI21X1 U1575 ( .A(n2474), .B(n2379), .C(n1142), .Y(n1704) );
  NAND2X1 U1576 ( .A(\registers[9][2] ), .B(n2474), .Y(n1142) );
  OAI21X1 U1577 ( .A(n2474), .B(n2373), .C(n1143), .Y(n1705) );
  NAND2X1 U1578 ( .A(\registers[9][3] ), .B(n2474), .Y(n1143) );
  OAI21X1 U1579 ( .A(n2474), .B(n2367), .C(n1144), .Y(n1706) );
  NAND2X1 U1580 ( .A(\registers[9][4] ), .B(n2474), .Y(n1144) );
  OAI21X1 U1581 ( .A(n2474), .B(n2361), .C(n1145), .Y(n1707) );
  NAND2X1 U1582 ( .A(\registers[9][5] ), .B(n2474), .Y(n1145) );
  OAI21X1 U1583 ( .A(n2474), .B(n2355), .C(n1146), .Y(n1708) );
  NAND2X1 U1584 ( .A(\registers[9][6] ), .B(n2474), .Y(n1146) );
  OAI21X1 U1585 ( .A(n2474), .B(n2349), .C(n1147), .Y(n1709) );
  NAND2X1 U1586 ( .A(\registers[9][7] ), .B(n2474), .Y(n1147) );
  OAI21X1 U1587 ( .A(n2474), .B(n2343), .C(n1148), .Y(n1710) );
  NAND2X1 U1588 ( .A(\registers[9][0] ), .B(n2474), .Y(n1148) );
  OAI21X1 U1589 ( .A(n705), .B(n1095), .C(n2337), .Y(n1149) );
  OAI21X1 U1590 ( .A(n2473), .B(n2385), .C(n1150), .Y(n1711) );
  NAND2X1 U1591 ( .A(\registers[8][1] ), .B(n2473), .Y(n1150) );
  OAI21X1 U1592 ( .A(n2473), .B(n2379), .C(n1151), .Y(n1712) );
  NAND2X1 U1593 ( .A(\registers[8][2] ), .B(n2473), .Y(n1151) );
  OAI21X1 U1594 ( .A(n2473), .B(n2373), .C(n1152), .Y(n1713) );
  NAND2X1 U1595 ( .A(\registers[8][3] ), .B(n2473), .Y(n1152) );
  OAI21X1 U1596 ( .A(n2473), .B(n2367), .C(n1153), .Y(n1714) );
  NAND2X1 U1597 ( .A(\registers[8][4] ), .B(n2473), .Y(n1153) );
  OAI21X1 U1598 ( .A(n2473), .B(n2361), .C(n1154), .Y(n1715) );
  NAND2X1 U1599 ( .A(\registers[8][5] ), .B(n2473), .Y(n1154) );
  OAI21X1 U1600 ( .A(n2473), .B(n2355), .C(n1155), .Y(n1716) );
  NAND2X1 U1601 ( .A(\registers[8][6] ), .B(n2473), .Y(n1155) );
  OAI21X1 U1602 ( .A(n2473), .B(n2349), .C(n1156), .Y(n1717) );
  NAND2X1 U1603 ( .A(\registers[8][7] ), .B(n2473), .Y(n1156) );
  OAI21X1 U1604 ( .A(n2473), .B(n2343), .C(n1157), .Y(n1718) );
  NAND2X1 U1605 ( .A(\registers[8][0] ), .B(n2473), .Y(n1157) );
  OAI21X1 U1606 ( .A(n715), .B(n1095), .C(n2337), .Y(n1158) );
  NAND3X1 U1607 ( .A(wpointer[3]), .B(n2529), .C(n1159), .Y(n1095) );
  OAI21X1 U1608 ( .A(n2472), .B(n2385), .C(n1160), .Y(n1719) );
  NAND2X1 U1609 ( .A(\registers[7][1] ), .B(n2472), .Y(n1160) );
  OAI21X1 U1610 ( .A(n2472), .B(n2379), .C(n1161), .Y(n1720) );
  NAND2X1 U1611 ( .A(\registers[7][2] ), .B(n2472), .Y(n1161) );
  OAI21X1 U1612 ( .A(n2472), .B(n2373), .C(n1162), .Y(n1721) );
  NAND2X1 U1613 ( .A(\registers[7][3] ), .B(n2472), .Y(n1162) );
  OAI21X1 U1614 ( .A(n2472), .B(n2367), .C(n1163), .Y(n1722) );
  NAND2X1 U1615 ( .A(\registers[7][4] ), .B(n2472), .Y(n1163) );
  OAI21X1 U1616 ( .A(n2472), .B(n2361), .C(n1164), .Y(n1723) );
  NAND2X1 U1617 ( .A(\registers[7][5] ), .B(n2472), .Y(n1164) );
  OAI21X1 U1618 ( .A(n2472), .B(n2355), .C(n1165), .Y(n1724) );
  NAND2X1 U1619 ( .A(\registers[7][6] ), .B(n2472), .Y(n1165) );
  OAI21X1 U1620 ( .A(n2472), .B(n2349), .C(n1166), .Y(n1725) );
  NAND2X1 U1621 ( .A(\registers[7][7] ), .B(n2472), .Y(n1166) );
  OAI21X1 U1622 ( .A(n2472), .B(n2343), .C(n1167), .Y(n1726) );
  NAND2X1 U1623 ( .A(\registers[7][0] ), .B(n2472), .Y(n1167) );
  OAI21X1 U1624 ( .A(n644), .B(n1169), .C(n2337), .Y(n1168) );
  NAND3X1 U1625 ( .A(wpointer[1]), .B(wpointer[0]), .C(wpointer[2]), .Y(n644)
         );
  OAI21X1 U1626 ( .A(n2471), .B(n2385), .C(n1170), .Y(n1727) );
  NAND2X1 U1627 ( .A(\registers[6][1] ), .B(n2471), .Y(n1170) );
  OAI21X1 U1628 ( .A(n2471), .B(n2379), .C(n1171), .Y(n1728) );
  NAND2X1 U1629 ( .A(\registers[6][2] ), .B(n2471), .Y(n1171) );
  OAI21X1 U1630 ( .A(n2471), .B(n2373), .C(n1172), .Y(n1729) );
  NAND2X1 U1631 ( .A(\registers[6][3] ), .B(n2471), .Y(n1172) );
  OAI21X1 U1632 ( .A(n2471), .B(n2367), .C(n1173), .Y(n1730) );
  NAND2X1 U1633 ( .A(\registers[6][4] ), .B(n2471), .Y(n1173) );
  OAI21X1 U1634 ( .A(n2471), .B(n2361), .C(n1174), .Y(n1731) );
  NAND2X1 U1635 ( .A(\registers[6][5] ), .B(n2471), .Y(n1174) );
  OAI21X1 U1636 ( .A(n2471), .B(n2355), .C(n1175), .Y(n1732) );
  NAND2X1 U1637 ( .A(\registers[6][6] ), .B(n2471), .Y(n1175) );
  OAI21X1 U1638 ( .A(n2471), .B(n2349), .C(n1176), .Y(n1733) );
  NAND2X1 U1639 ( .A(\registers[6][7] ), .B(n2471), .Y(n1176) );
  OAI21X1 U1640 ( .A(n2471), .B(n2343), .C(n1177), .Y(n1734) );
  NAND2X1 U1641 ( .A(\registers[6][0] ), .B(n2471), .Y(n1177) );
  OAI21X1 U1642 ( .A(n655), .B(n1169), .C(n2337), .Y(n1178) );
  NAND3X1 U1643 ( .A(wpointer[1]), .B(n2539), .C(wpointer[2]), .Y(n655) );
  OAI21X1 U1644 ( .A(n2470), .B(n2385), .C(n1179), .Y(n1735) );
  NAND2X1 U1645 ( .A(\registers[5][1] ), .B(n2470), .Y(n1179) );
  OAI21X1 U1646 ( .A(n2470), .B(n2379), .C(n1180), .Y(n1736) );
  NAND2X1 U1647 ( .A(\registers[5][2] ), .B(n2470), .Y(n1180) );
  OAI21X1 U1648 ( .A(n2470), .B(n2373), .C(n1181), .Y(n1737) );
  NAND2X1 U1649 ( .A(\registers[5][3] ), .B(n2470), .Y(n1181) );
  OAI21X1 U1650 ( .A(n2470), .B(n2367), .C(n1182), .Y(n1738) );
  NAND2X1 U1651 ( .A(\registers[5][4] ), .B(n2470), .Y(n1182) );
  OAI21X1 U1652 ( .A(n2470), .B(n2361), .C(n1183), .Y(n1739) );
  NAND2X1 U1653 ( .A(\registers[5][5] ), .B(n2470), .Y(n1183) );
  OAI21X1 U1654 ( .A(n2470), .B(n2355), .C(n1184), .Y(n1740) );
  NAND2X1 U1655 ( .A(\registers[5][6] ), .B(n2470), .Y(n1184) );
  OAI21X1 U1656 ( .A(n2470), .B(n2349), .C(n1185), .Y(n1741) );
  NAND2X1 U1657 ( .A(\registers[5][7] ), .B(n2470), .Y(n1185) );
  OAI21X1 U1658 ( .A(n2470), .B(n2343), .C(n1186), .Y(n1742) );
  NAND2X1 U1659 ( .A(\registers[5][0] ), .B(n2470), .Y(n1186) );
  OAI21X1 U1660 ( .A(n665), .B(n1169), .C(n2337), .Y(n1187) );
  NAND3X1 U1661 ( .A(wpointer[0]), .B(n2540), .C(wpointer[2]), .Y(n665) );
  OAI21X1 U1662 ( .A(n2469), .B(n2385), .C(n1188), .Y(n1743) );
  NAND2X1 U1663 ( .A(\registers[4][1] ), .B(n2469), .Y(n1188) );
  OAI21X1 U1664 ( .A(n2469), .B(n2379), .C(n1189), .Y(n1744) );
  NAND2X1 U1665 ( .A(\registers[4][2] ), .B(n2469), .Y(n1189) );
  OAI21X1 U1666 ( .A(n2469), .B(n2373), .C(n1190), .Y(n1745) );
  NAND2X1 U1667 ( .A(\registers[4][3] ), .B(n2469), .Y(n1190) );
  OAI21X1 U1668 ( .A(n2469), .B(n2367), .C(n1191), .Y(n1746) );
  NAND2X1 U1669 ( .A(\registers[4][4] ), .B(n2469), .Y(n1191) );
  OAI21X1 U1670 ( .A(n2469), .B(n2361), .C(n1192), .Y(n1747) );
  NAND2X1 U1671 ( .A(\registers[4][5] ), .B(n2469), .Y(n1192) );
  OAI21X1 U1672 ( .A(n2469), .B(n2355), .C(n1193), .Y(n1748) );
  NAND2X1 U1673 ( .A(\registers[4][6] ), .B(n2469), .Y(n1193) );
  OAI21X1 U1674 ( .A(n2469), .B(n2349), .C(n1194), .Y(n1749) );
  NAND2X1 U1675 ( .A(\registers[4][7] ), .B(n2469), .Y(n1194) );
  OAI21X1 U1676 ( .A(n2469), .B(n2343), .C(n1195), .Y(n1750) );
  NAND2X1 U1677 ( .A(\registers[4][0] ), .B(n2469), .Y(n1195) );
  OAI21X1 U1678 ( .A(n675), .B(n1169), .C(n2337), .Y(n1196) );
  NAND3X1 U1679 ( .A(n2539), .B(n2540), .C(wpointer[2]), .Y(n675) );
  OAI21X1 U1680 ( .A(n2468), .B(n2385), .C(n1197), .Y(n1751) );
  NAND2X1 U1681 ( .A(\registers[3][1] ), .B(n2468), .Y(n1197) );
  OAI21X1 U1682 ( .A(n2468), .B(n2379), .C(n1198), .Y(n1752) );
  NAND2X1 U1683 ( .A(\registers[3][2] ), .B(n2468), .Y(n1198) );
  OAI21X1 U1684 ( .A(n2468), .B(n2373), .C(n1199), .Y(n1753) );
  NAND2X1 U1685 ( .A(\registers[3][3] ), .B(n2468), .Y(n1199) );
  OAI21X1 U1686 ( .A(n2468), .B(n2367), .C(n1200), .Y(n1754) );
  NAND2X1 U1687 ( .A(\registers[3][4] ), .B(n2468), .Y(n1200) );
  OAI21X1 U1688 ( .A(n2468), .B(n2361), .C(n1201), .Y(n1755) );
  NAND2X1 U1689 ( .A(\registers[3][5] ), .B(n2468), .Y(n1201) );
  OAI21X1 U1690 ( .A(n2468), .B(n2355), .C(n1202), .Y(n1756) );
  NAND2X1 U1691 ( .A(\registers[3][6] ), .B(n2468), .Y(n1202) );
  OAI21X1 U1692 ( .A(n2468), .B(n2349), .C(n1203), .Y(n1757) );
  NAND2X1 U1693 ( .A(\registers[3][7] ), .B(n2468), .Y(n1203) );
  OAI21X1 U1694 ( .A(n2468), .B(n2343), .C(n1204), .Y(n1758) );
  NAND2X1 U1695 ( .A(\registers[3][0] ), .B(n2468), .Y(n1204) );
  OAI21X1 U1696 ( .A(n685), .B(n1169), .C(n2337), .Y(n1205) );
  NAND3X1 U1697 ( .A(wpointer[0]), .B(n2541), .C(wpointer[1]), .Y(n685) );
  OAI21X1 U1698 ( .A(n2467), .B(n2385), .C(n1206), .Y(n1759) );
  NAND2X1 U1699 ( .A(\registers[2][1] ), .B(n2467), .Y(n1206) );
  OAI21X1 U1700 ( .A(n2467), .B(n2379), .C(n1207), .Y(n1760) );
  NAND2X1 U1701 ( .A(\registers[2][2] ), .B(n2467), .Y(n1207) );
  OAI21X1 U1702 ( .A(n2467), .B(n2373), .C(n1208), .Y(n1761) );
  NAND2X1 U1703 ( .A(\registers[2][3] ), .B(n2467), .Y(n1208) );
  OAI21X1 U1704 ( .A(n2467), .B(n2367), .C(n1209), .Y(n1762) );
  NAND2X1 U1705 ( .A(\registers[2][4] ), .B(n2467), .Y(n1209) );
  OAI21X1 U1706 ( .A(n2467), .B(n2361), .C(n1210), .Y(n1763) );
  NAND2X1 U1707 ( .A(\registers[2][5] ), .B(n2467), .Y(n1210) );
  OAI21X1 U1708 ( .A(n2467), .B(n2355), .C(n1211), .Y(n1764) );
  NAND2X1 U1709 ( .A(\registers[2][6] ), .B(n2467), .Y(n1211) );
  OAI21X1 U1710 ( .A(n2467), .B(n2349), .C(n1212), .Y(n1765) );
  NAND2X1 U1711 ( .A(\registers[2][7] ), .B(n2467), .Y(n1212) );
  OAI21X1 U1712 ( .A(n2467), .B(n2343), .C(n1213), .Y(n1766) );
  NAND2X1 U1713 ( .A(\registers[2][0] ), .B(n2467), .Y(n1213) );
  OAI21X1 U1714 ( .A(n695), .B(n1169), .C(n2337), .Y(n1214) );
  NAND3X1 U1715 ( .A(n2539), .B(n2541), .C(wpointer[1]), .Y(n695) );
  OAI21X1 U1716 ( .A(n2466), .B(n2385), .C(n1215), .Y(n1767) );
  NAND2X1 U1717 ( .A(\registers[1][1] ), .B(n2466), .Y(n1215) );
  OAI21X1 U1718 ( .A(n2466), .B(n2379), .C(n1216), .Y(n1768) );
  NAND2X1 U1719 ( .A(\registers[1][2] ), .B(n2466), .Y(n1216) );
  OAI21X1 U1720 ( .A(n2466), .B(n2373), .C(n1217), .Y(n1769) );
  NAND2X1 U1721 ( .A(\registers[1][3] ), .B(n2466), .Y(n1217) );
  OAI21X1 U1722 ( .A(n2466), .B(n2367), .C(n1218), .Y(n1770) );
  NAND2X1 U1723 ( .A(\registers[1][4] ), .B(n2466), .Y(n1218) );
  OAI21X1 U1724 ( .A(n2466), .B(n2361), .C(n1219), .Y(n1771) );
  NAND2X1 U1725 ( .A(\registers[1][5] ), .B(n2466), .Y(n1219) );
  OAI21X1 U1726 ( .A(n2466), .B(n2355), .C(n1220), .Y(n1772) );
  NAND2X1 U1727 ( .A(\registers[1][6] ), .B(n2466), .Y(n1220) );
  OAI21X1 U1728 ( .A(n2466), .B(n2349), .C(n1221), .Y(n1773) );
  NAND2X1 U1729 ( .A(\registers[1][7] ), .B(n2466), .Y(n1221) );
  OAI21X1 U1730 ( .A(n2466), .B(n2343), .C(n1222), .Y(n1774) );
  NAND2X1 U1731 ( .A(\registers[1][0] ), .B(n2466), .Y(n1222) );
  OAI21X1 U1732 ( .A(n705), .B(n1169), .C(n2337), .Y(n1223) );
  NAND3X1 U1733 ( .A(n2540), .B(n2541), .C(wpointer[0]), .Y(n705) );
  OAI21X1 U1734 ( .A(n2465), .B(n2385), .C(n1224), .Y(n1775) );
  NAND2X1 U1735 ( .A(\registers[0][1] ), .B(n2465), .Y(n1224) );
  OR2X1 U1736 ( .A(n1225), .B(n1226), .Y(n626) );
  AOI22X1 U1737 ( .A(rx_packet_data[1]), .B(n2334), .C(tx_data[1]), .D(
        store_tx_data), .Y(n1225) );
  OAI21X1 U1738 ( .A(n2465), .B(n2379), .C(n1228), .Y(n1776) );
  NAND2X1 U1739 ( .A(\registers[0][2] ), .B(n2465), .Y(n1228) );
  OR2X1 U1740 ( .A(n1229), .B(n1226), .Y(n628) );
  AOI22X1 U1741 ( .A(rx_packet_data[2]), .B(n2334), .C(tx_data[2]), .D(
        store_tx_data), .Y(n1229) );
  OAI21X1 U1742 ( .A(n2465), .B(n2373), .C(n1230), .Y(n1777) );
  NAND2X1 U1743 ( .A(\registers[0][3] ), .B(n2465), .Y(n1230) );
  OR2X1 U1744 ( .A(n1231), .B(n1226), .Y(n630) );
  AOI22X1 U1745 ( .A(rx_packet_data[3]), .B(n2334), .C(tx_data[3]), .D(
        store_tx_data), .Y(n1231) );
  OAI21X1 U1746 ( .A(n2465), .B(n2367), .C(n1232), .Y(n1778) );
  NAND2X1 U1747 ( .A(\registers[0][4] ), .B(n2465), .Y(n1232) );
  OR2X1 U1748 ( .A(n1233), .B(n1226), .Y(n632) );
  AOI22X1 U1749 ( .A(rx_packet_data[4]), .B(n2334), .C(tx_data[4]), .D(
        store_tx_data), .Y(n1233) );
  OAI21X1 U1750 ( .A(n2465), .B(n2361), .C(n1234), .Y(n1779) );
  NAND2X1 U1751 ( .A(\registers[0][5] ), .B(n2465), .Y(n1234) );
  OR2X1 U1752 ( .A(n1235), .B(n1226), .Y(n634) );
  AOI22X1 U1753 ( .A(rx_packet_data[5]), .B(n2334), .C(tx_data[5]), .D(
        store_tx_data), .Y(n1235) );
  OAI21X1 U1754 ( .A(n2465), .B(n2355), .C(n1236), .Y(n1780) );
  NAND2X1 U1755 ( .A(\registers[0][6] ), .B(n2465), .Y(n1236) );
  OR2X1 U1756 ( .A(n1237), .B(n1226), .Y(n636) );
  AOI22X1 U1757 ( .A(rx_packet_data[6]), .B(n2334), .C(tx_data[6]), .D(
        store_tx_data), .Y(n1237) );
  OAI21X1 U1758 ( .A(n2465), .B(n2349), .C(n1238), .Y(n1781) );
  NAND2X1 U1759 ( .A(\registers[0][7] ), .B(n2465), .Y(n1238) );
  OR2X1 U1760 ( .A(n1239), .B(n1226), .Y(n638) );
  AOI22X1 U1761 ( .A(rx_packet_data[7]), .B(n2334), .C(tx_data[7]), .D(
        store_tx_data), .Y(n1239) );
  OAI21X1 U1762 ( .A(n2465), .B(n2343), .C(n1240), .Y(n1782) );
  NAND2X1 U1763 ( .A(\registers[0][0] ), .B(n2465), .Y(n1240) );
  OR2X1 U1764 ( .A(n1241), .B(n1226), .Y(n640) );
  AOI22X1 U1765 ( .A(rx_packet_data[0]), .B(n2334), .C(tx_data[0]), .D(
        store_tx_data), .Y(n1241) );
  OAI21X1 U1766 ( .A(n715), .B(n1169), .C(n2337), .Y(n1242) );
  NAND3X1 U1767 ( .A(n2529), .B(n2542), .C(n1159), .Y(n1169) );
  NOR2X1 U1768 ( .A(wpointer[5]), .B(wpointer[4]), .Y(n1159) );
  NAND2X1 U1769 ( .A(n645), .B(n2530), .Y(n1226) );
  NAND3X1 U1770 ( .A(n2540), .B(n2541), .C(n2539), .Y(n715) );
  OAI21X1 U1771 ( .A(n1243), .B(n2533), .C(n1244), .Y(N33) );
  AOI22X1 U1772 ( .A(buffer_occupancy[6]), .B(n1245), .C(N51), .D(n1246), .Y(
        n1244) );
  OAI21X1 U1773 ( .A(n1243), .B(n2534), .C(n1247), .Y(N32) );
  AOI22X1 U1774 ( .A(buffer_occupancy[5]), .B(n1245), .C(N50), .D(n1246), .Y(
        n1247) );
  OAI21X1 U1775 ( .A(n1243), .B(n2535), .C(n1248), .Y(N31) );
  AOI22X1 U1776 ( .A(buffer_occupancy[4]), .B(n1245), .C(N49), .D(n1246), .Y(
        n1248) );
  OAI21X1 U1777 ( .A(n1243), .B(n2536), .C(n1249), .Y(N30) );
  AOI22X1 U1778 ( .A(buffer_occupancy[3]), .B(n1245), .C(N48), .D(n1246), .Y(
        n1249) );
  OAI21X1 U1779 ( .A(n1243), .B(n2537), .C(n1250), .Y(N29) );
  AOI22X1 U1780 ( .A(buffer_occupancy[2]), .B(n1245), .C(N47), .D(n1246), .Y(
        n1250) );
  OAI21X1 U1781 ( .A(n1243), .B(n2538), .C(n1251), .Y(N28) );
  AOI22X1 U1782 ( .A(buffer_occupancy[1]), .B(n1245), .C(N46), .D(n1246), .Y(
        n1251) );
  OAI21X1 U1783 ( .A(n1243), .B(buffer_occupancy[0]), .C(n1252), .Y(N27) );
  AOI22X1 U1784 ( .A(buffer_occupancy[0]), .B(n1245), .C(N45), .D(n1246), .Y(
        n1252) );
  NOR3X1 U1785 ( .A(n1253), .B(n1254), .C(n2338), .Y(n1245) );
  NOR2X1 U1786 ( .A(n2530), .B(n2333), .Y(n1253) );
  NAND2X1 U1787 ( .A(n1254), .B(n2336), .Y(n1243) );
  NOR2X1 U1788 ( .A(n1255), .B(n2335), .Y(n1254) );
  NOR2X1 U1789 ( .A(n1257), .B(n2338), .Y(N131) );
  AOI22X1 U1790 ( .A(wpointer[6]), .B(n2335), .C(N739), .D(n2530), .Y(n1257)
         );
  NOR2X1 U1791 ( .A(n1258), .B(n2338), .Y(N130) );
  AOI22X1 U1792 ( .A(n2335), .B(wpointer[5]), .C(N738), .D(n2530), .Y(n1258)
         );
  NOR2X1 U1793 ( .A(n1259), .B(n2339), .Y(N129) );
  AOI22X1 U1794 ( .A(n2335), .B(wpointer[4]), .C(N737), .D(n2530), .Y(n1259)
         );
  NOR2X1 U1795 ( .A(n1260), .B(n2339), .Y(N128) );
  AOI22X1 U1796 ( .A(n2335), .B(wpointer[3]), .C(N736), .D(n2530), .Y(n1260)
         );
  NOR2X1 U1797 ( .A(n1261), .B(n2339), .Y(N127) );
  AOI22X1 U1798 ( .A(n2335), .B(wpointer[2]), .C(N735), .D(n2530), .Y(n1261)
         );
  NOR2X1 U1799 ( .A(n1262), .B(n2339), .Y(N126) );
  AOI22X1 U1800 ( .A(n2335), .B(wpointer[1]), .C(N734), .D(n2530), .Y(n1262)
         );
  NOR2X1 U1801 ( .A(n1263), .B(n2340), .Y(N125) );
  AOI22X1 U1802 ( .A(n2335), .B(wpointer[0]), .C(N733), .D(n2530), .Y(n1263)
         );
  NOR2X1 U1803 ( .A(store_tx_data), .B(n2334), .Y(n1256) );
  NOR2X1 U1804 ( .A(n2531), .B(store_tx_data), .Y(n1227) );
  NOR2X1 U1805 ( .A(n1264), .B(n2340), .Y(N124) );
  AOI22X1 U1806 ( .A(\rpointer[6] ), .B(n2333), .C(N728), .D(n1255), .Y(n1264)
         );
  NOR2X1 U1807 ( .A(n1265), .B(n2340), .Y(N123) );
  AOI22X1 U1808 ( .A(N25), .B(n2333), .C(N727), .D(n1255), .Y(n1265) );
  NOR2X1 U1809 ( .A(n1266), .B(n2340), .Y(N122) );
  AOI22X1 U1810 ( .A(N24), .B(n2333), .C(N726), .D(n1255), .Y(n1266) );
  NOR2X1 U1811 ( .A(n1267), .B(n2341), .Y(N121) );
  AOI22X1 U1812 ( .A(N23), .B(n2333), .C(N725), .D(n1255), .Y(n1267) );
  NOR2X1 U1813 ( .A(n1268), .B(n2341), .Y(N120) );
  AOI22X1 U1814 ( .A(N22), .B(n2333), .C(N724), .D(n1255), .Y(n1268) );
  NOR2X1 U1815 ( .A(n1269), .B(n2341), .Y(N119) );
  AOI22X1 U1816 ( .A(N21), .B(n2333), .C(N723), .D(n1255), .Y(n1269) );
  NOR2X1 U1817 ( .A(n1270), .B(n2341), .Y(N118) );
  NOR2X1 U1818 ( .A(clear), .B(flush), .Y(n645) );
  AOI22X1 U1819 ( .A(N20), .B(n2333), .C(N722), .D(n1255), .Y(n1270) );
  NAND2X1 U1820 ( .A(n2532), .B(n625), .Y(n1255) );
  NAND2X1 U1821 ( .A(get_rx_data), .B(n2532), .Y(n625) );
  fifo_data_buffer_DW01_inc_0 add_146 ( .A(wpointer), .SUM({N739, N738, N737, 
        N736, N735, N734, N733}) );
  fifo_data_buffer_DW01_inc_1 add_126 ( .A({\rpointer[6] , N25, N24, N23, N22, 
        N21, N20}), .SUM({N728, N727, N726, N725, N724, N723, N722}) );
  fifo_data_buffer_DW01_inc_2 add_53 ( .A(buffer_occupancy), .SUM({N44, N43, 
        N42, N41, N40, N39, SYNOPSYS_UNCONNECTED__0}) );
  AND2X2 U537 ( .A(N25), .B(n2281), .Y(n534) );
  AND2X2 U538 ( .A(N25), .B(N24), .Y(n535) );
  NOR2X1 U539 ( .A(n617), .B(n616), .Y(n536) );
  NOR2X1 U540 ( .A(n1845), .B(n1844), .Y(n537) );
  NOR2X1 U541 ( .A(n1915), .B(n1914), .Y(n538) );
  NOR2X1 U542 ( .A(n1985), .B(n1984), .Y(n539) );
  NOR2X1 U543 ( .A(n2055), .B(n2054), .Y(n540) );
  NOR2X1 U544 ( .A(n2125), .B(n2124), .Y(n541) );
  NOR2X1 U545 ( .A(n2195), .B(n2194), .Y(n542) );
  NOR2X1 U546 ( .A(n2279), .B(n2278), .Y(n543) );
  INVX2 U547 ( .A(n2335), .Y(n2530) );
  BUFX2 U548 ( .A(n1256), .Y(n2335) );
  BUFX2 U549 ( .A(n1227), .Y(n2334) );
  INVX2 U550 ( .A(n1255), .Y(n2333) );
  INVX2 U551 ( .A(n2339), .Y(n2337) );
  INVX2 U552 ( .A(n2340), .Y(n2336) );
  INVX2 U553 ( .A(n1242), .Y(n2465) );
  INVX2 U554 ( .A(n1010), .Y(n2489) );
  INVX2 U555 ( .A(n862), .Y(n2505) );
  INVX2 U556 ( .A(n789), .Y(n2513) );
  BUFX2 U557 ( .A(n626), .Y(n2385) );
  BUFX2 U558 ( .A(n628), .Y(n2379) );
  BUFX2 U559 ( .A(n630), .Y(n2373) );
  BUFX2 U560 ( .A(n632), .Y(n2367) );
  BUFX2 U561 ( .A(n634), .Y(n2361) );
  BUFX2 U562 ( .A(n636), .Y(n2355) );
  BUFX2 U563 ( .A(n638), .Y(n2349) );
  BUFX2 U564 ( .A(n640), .Y(n2343) );
  BUFX2 U565 ( .A(n626), .Y(n2386) );
  BUFX2 U566 ( .A(n628), .Y(n2380) );
  BUFX2 U567 ( .A(n630), .Y(n2374) );
  BUFX2 U568 ( .A(n632), .Y(n2368) );
  BUFX2 U569 ( .A(n634), .Y(n2362) );
  BUFX2 U570 ( .A(n636), .Y(n2356) );
  BUFX2 U571 ( .A(n638), .Y(n2350) );
  BUFX2 U572 ( .A(n640), .Y(n2344) );
  BUFX2 U573 ( .A(n626), .Y(n2387) );
  BUFX2 U574 ( .A(n628), .Y(n2381) );
  BUFX2 U575 ( .A(n630), .Y(n2375) );
  BUFX2 U576 ( .A(n632), .Y(n2369) );
  BUFX2 U577 ( .A(n634), .Y(n2363) );
  BUFX2 U578 ( .A(n636), .Y(n2357) );
  BUFX2 U579 ( .A(n638), .Y(n2351) );
  BUFX2 U580 ( .A(n640), .Y(n2345) );
  BUFX2 U581 ( .A(n626), .Y(n2388) );
  BUFX2 U582 ( .A(n628), .Y(n2382) );
  BUFX2 U583 ( .A(n630), .Y(n2376) );
  BUFX2 U584 ( .A(n632), .Y(n2370) );
  BUFX2 U585 ( .A(n634), .Y(n2364) );
  BUFX2 U586 ( .A(n636), .Y(n2358) );
  BUFX2 U587 ( .A(n638), .Y(n2352) );
  BUFX2 U588 ( .A(n640), .Y(n2346) );
  BUFX2 U589 ( .A(n626), .Y(n2389) );
  BUFX2 U590 ( .A(n628), .Y(n2383) );
  BUFX2 U591 ( .A(n630), .Y(n2377) );
  BUFX2 U592 ( .A(n632), .Y(n2371) );
  BUFX2 U593 ( .A(n634), .Y(n2365) );
  BUFX2 U594 ( .A(n636), .Y(n2359) );
  BUFX2 U595 ( .A(n638), .Y(n2353) );
  BUFX2 U596 ( .A(n640), .Y(n2347) );
  BUFX2 U597 ( .A(n626), .Y(n2390) );
  BUFX2 U598 ( .A(n628), .Y(n2384) );
  BUFX2 U599 ( .A(n630), .Y(n2378) );
  BUFX2 U600 ( .A(n632), .Y(n2372) );
  BUFX2 U601 ( .A(n634), .Y(n2366) );
  BUFX2 U602 ( .A(n636), .Y(n2360) );
  BUFX2 U603 ( .A(n638), .Y(n2354) );
  BUFX2 U604 ( .A(n640), .Y(n2348) );
  INVX2 U605 ( .A(get_tx_packet_data), .Y(n2532) );
  BUFX2 U606 ( .A(n2342), .Y(n2338) );
  BUFX2 U607 ( .A(n2268), .Y(n2324) );
  BUFX2 U608 ( .A(n2268), .Y(n2321) );
  BUFX2 U609 ( .A(n2268), .Y(n2322) );
  BUFX2 U610 ( .A(n2268), .Y(n2323) );
  BUFX2 U611 ( .A(n2267), .Y(n2319) );
  BUFX2 U612 ( .A(n2267), .Y(n2318) );
  BUFX2 U613 ( .A(n2267), .Y(n2317) );
  BUFX2 U614 ( .A(n2267), .Y(n2316) );
  BUFX2 U615 ( .A(n2267), .Y(n2315) );
  BUFX2 U616 ( .A(n2263), .Y(n2313) );
  BUFX2 U617 ( .A(n2263), .Y(n2312) );
  BUFX2 U618 ( .A(n2263), .Y(n2311) );
  BUFX2 U619 ( .A(n2263), .Y(n2310) );
  BUFX2 U620 ( .A(n2263), .Y(n2309) );
  BUFX2 U621 ( .A(n2268), .Y(n2320) );
  BUFX2 U622 ( .A(n2262), .Y(n2307) );
  BUFX2 U623 ( .A(n2262), .Y(n2306) );
  BUFX2 U624 ( .A(n2262), .Y(n2305) );
  BUFX2 U625 ( .A(n2262), .Y(n2304) );
  BUFX2 U626 ( .A(n2262), .Y(n2303) );
  BUFX2 U627 ( .A(n2342), .Y(n2339) );
  BUFX2 U1822 ( .A(n2342), .Y(n2340) );
  BUFX2 U1823 ( .A(n2339), .Y(n2341) );
  BUFX2 U1824 ( .A(n2267), .Y(n2314) );
  BUFX2 U1825 ( .A(n2262), .Y(n2302) );
  BUFX2 U1826 ( .A(n2263), .Y(n2308) );
  BUFX2 U1827 ( .A(n2455), .Y(n2396) );
  BUFX2 U1828 ( .A(n2455), .Y(n2397) );
  BUFX2 U1829 ( .A(n2455), .Y(n2398) );
  BUFX2 U1830 ( .A(n2454), .Y(n2399) );
  BUFX2 U1831 ( .A(n2454), .Y(n2400) );
  BUFX2 U1832 ( .A(n2454), .Y(n2401) );
  BUFX2 U1833 ( .A(n2453), .Y(n2402) );
  BUFX2 U1834 ( .A(n2453), .Y(n2403) );
  BUFX2 U1835 ( .A(n2453), .Y(n2404) );
  BUFX2 U1836 ( .A(n2452), .Y(n2405) );
  BUFX2 U1837 ( .A(n2452), .Y(n2406) );
  BUFX2 U1838 ( .A(n2452), .Y(n2407) );
  BUFX2 U1839 ( .A(n2451), .Y(n2408) );
  BUFX2 U1840 ( .A(n2451), .Y(n2409) );
  BUFX2 U1841 ( .A(n2451), .Y(n2410) );
  BUFX2 U1842 ( .A(n2450), .Y(n2411) );
  BUFX2 U1843 ( .A(n2450), .Y(n2412) );
  BUFX2 U1844 ( .A(n2450), .Y(n2413) );
  BUFX2 U1845 ( .A(n2449), .Y(n2414) );
  BUFX2 U1846 ( .A(n2449), .Y(n2415) );
  BUFX2 U1847 ( .A(n2449), .Y(n2416) );
  BUFX2 U1848 ( .A(n2448), .Y(n2417) );
  BUFX2 U1849 ( .A(n2448), .Y(n2418) );
  BUFX2 U1850 ( .A(n2448), .Y(n2419) );
  BUFX2 U1851 ( .A(n2447), .Y(n2420) );
  BUFX2 U1852 ( .A(n2447), .Y(n2421) );
  BUFX2 U1853 ( .A(n2447), .Y(n2422) );
  BUFX2 U1854 ( .A(n2446), .Y(n2423) );
  BUFX2 U1855 ( .A(n2446), .Y(n2424) );
  BUFX2 U1856 ( .A(n2446), .Y(n2425) );
  BUFX2 U1857 ( .A(n2445), .Y(n2426) );
  BUFX2 U1858 ( .A(n2445), .Y(n2427) );
  BUFX2 U1859 ( .A(n2445), .Y(n2428) );
  BUFX2 U1860 ( .A(n2444), .Y(n2429) );
  BUFX2 U1861 ( .A(n2444), .Y(n2430) );
  BUFX2 U1862 ( .A(n2444), .Y(n2431) );
  BUFX2 U1863 ( .A(n2443), .Y(n2432) );
  BUFX2 U1864 ( .A(n2443), .Y(n2433) );
  BUFX2 U1865 ( .A(n2443), .Y(n2434) );
  BUFX2 U1866 ( .A(n2442), .Y(n2435) );
  BUFX2 U1867 ( .A(n2442), .Y(n2436) );
  BUFX2 U1868 ( .A(n2442), .Y(n2437) );
  BUFX2 U1869 ( .A(n2441), .Y(n2438) );
  BUFX2 U1870 ( .A(n2441), .Y(n2439) );
  BUFX2 U1871 ( .A(n2441), .Y(n2440) );
  INVX2 U1872 ( .A(n1178), .Y(n2471) );
  INVX2 U1873 ( .A(n1104), .Y(n2479) );
  INVX2 U1874 ( .A(n1030), .Y(n2487) );
  INVX2 U1875 ( .A(n956), .Y(n2495) );
  INVX2 U1876 ( .A(n882), .Y(n2503) );
  INVX2 U1877 ( .A(n808), .Y(n2511) );
  INVX2 U1878 ( .A(n735), .Y(n2519) );
  INVX2 U1879 ( .A(n1168), .Y(n2472) );
  INVX2 U1880 ( .A(n1094), .Y(n2480) );
  INVX2 U1881 ( .A(n1020), .Y(n2488) );
  INVX2 U1882 ( .A(n946), .Y(n2496) );
  INVX2 U1883 ( .A(n872), .Y(n2504) );
  INVX2 U1884 ( .A(n798), .Y(n2512) );
  INVX2 U1885 ( .A(n725), .Y(n2520) );
  INVX2 U1886 ( .A(n642), .Y(n2528) );
  INVX2 U1887 ( .A(n704), .Y(n2522) );
  INVX2 U1888 ( .A(n1187), .Y(n2470) );
  INVX2 U1889 ( .A(n1113), .Y(n2478) );
  INVX2 U1890 ( .A(n1039), .Y(n2486) );
  INVX2 U1891 ( .A(n965), .Y(n2494) );
  INVX2 U1892 ( .A(n891), .Y(n2502) );
  INVX2 U1893 ( .A(n817), .Y(n2510) );
  INVX2 U1894 ( .A(n744), .Y(n2518) );
  INVX2 U1895 ( .A(n1205), .Y(n2468) );
  INVX2 U1896 ( .A(n1131), .Y(n2476) );
  INVX2 U1897 ( .A(n1057), .Y(n2484) );
  INVX2 U1898 ( .A(n983), .Y(n2492) );
  INVX2 U1899 ( .A(n909), .Y(n2500) );
  INVX2 U1900 ( .A(n835), .Y(n2508) );
  INVX2 U1901 ( .A(n762), .Y(n2516) );
  INVX2 U1902 ( .A(n654), .Y(n2527) );
  INVX2 U1903 ( .A(n674), .Y(n2525) );
  INVX2 U1904 ( .A(n694), .Y(n2523) );
  INVX2 U1905 ( .A(n714), .Y(n2521) );
  INVX2 U1906 ( .A(n664), .Y(n2526) );
  INVX2 U1907 ( .A(n684), .Y(n2524) );
  INVX2 U1908 ( .A(n1196), .Y(n2469) );
  INVX2 U1909 ( .A(n1122), .Y(n2477) );
  INVX2 U1910 ( .A(n1048), .Y(n2485) );
  INVX2 U1911 ( .A(n974), .Y(n2493) );
  INVX2 U1912 ( .A(n900), .Y(n2501) );
  INVX2 U1913 ( .A(n826), .Y(n2509) );
  INVX2 U1914 ( .A(n753), .Y(n2517) );
  INVX2 U1915 ( .A(n1214), .Y(n2467) );
  INVX2 U1916 ( .A(n1140), .Y(n2475) );
  INVX2 U1917 ( .A(n1066), .Y(n2483) );
  INVX2 U1918 ( .A(n992), .Y(n2491) );
  INVX2 U1919 ( .A(n918), .Y(n2499) );
  INVX2 U1920 ( .A(n844), .Y(n2507) );
  INVX2 U1921 ( .A(n771), .Y(n2515) );
  INVX2 U1922 ( .A(n1158), .Y(n2473) );
  INVX2 U1923 ( .A(n1084), .Y(n2481) );
  INVX2 U1924 ( .A(n936), .Y(n2497) );
  INVX2 U1925 ( .A(n1223), .Y(n2466) );
  INVX2 U1926 ( .A(n1149), .Y(n2474) );
  INVX2 U1927 ( .A(n1075), .Y(n2482) );
  INVX2 U1928 ( .A(n1001), .Y(n2490) );
  INVX2 U1929 ( .A(n927), .Y(n2498) );
  INVX2 U1930 ( .A(n853), .Y(n2506) );
  INVX2 U1931 ( .A(n780), .Y(n2514) );
  INVX2 U1932 ( .A(n645), .Y(n2342) );
  BUFX2 U1933 ( .A(n2256), .Y(n2290) );
  BUFX2 U1934 ( .A(n2259), .Y(n2301) );
  INVX2 U1935 ( .A(n2248), .Y(n2280) );
  BUFX2 U1936 ( .A(n2259), .Y(n2298) );
  BUFX2 U1937 ( .A(n2259), .Y(n2299) );
  BUFX2 U1938 ( .A(n2259), .Y(n2300) );
  BUFX2 U1939 ( .A(n2256), .Y(n2287) );
  BUFX2 U1940 ( .A(n2256), .Y(n2288) );
  BUFX2 U1941 ( .A(n2256), .Y(n2289) );
  INVX2 U1942 ( .A(n2258), .Y(n2282) );
  BUFX2 U1943 ( .A(n2257), .Y(n2296) );
  BUFX2 U1944 ( .A(n2269), .Y(n2330) );
  BUFX2 U1945 ( .A(n2257), .Y(n2295) );
  BUFX2 U1946 ( .A(n2269), .Y(n2329) );
  BUFX2 U1947 ( .A(n2257), .Y(n2294) );
  BUFX2 U1948 ( .A(n2269), .Y(n2328) );
  BUFX2 U1949 ( .A(n2257), .Y(n2293) );
  BUFX2 U1950 ( .A(n2269), .Y(n2327) );
  BUFX2 U1951 ( .A(n2257), .Y(n2292) );
  BUFX2 U1952 ( .A(n2269), .Y(n2326) );
  BUFX2 U1953 ( .A(n2259), .Y(n2297) );
  BUFX2 U1954 ( .A(n2256), .Y(n2286) );
  BUFX2 U1955 ( .A(n2269), .Y(n2325) );
  BUFX2 U1956 ( .A(n2257), .Y(n2291) );
  BUFX2 U1957 ( .A(n2395), .Y(n2455) );
  BUFX2 U1958 ( .A(n2395), .Y(n2454) );
  BUFX2 U1959 ( .A(n2395), .Y(n2453) );
  BUFX2 U1960 ( .A(n2394), .Y(n2452) );
  BUFX2 U1961 ( .A(n2394), .Y(n2451) );
  BUFX2 U1962 ( .A(n2394), .Y(n2450) );
  BUFX2 U1963 ( .A(n2393), .Y(n2449) );
  BUFX2 U1964 ( .A(n2393), .Y(n2448) );
  BUFX2 U1965 ( .A(n2393), .Y(n2447) );
  BUFX2 U1966 ( .A(n2392), .Y(n2446) );
  BUFX2 U1967 ( .A(n2392), .Y(n2445) );
  BUFX2 U1968 ( .A(n2392), .Y(n2444) );
  BUFX2 U1969 ( .A(n2391), .Y(n2443) );
  BUFX2 U1970 ( .A(n2391), .Y(n2442) );
  BUFX2 U1971 ( .A(n2391), .Y(n2441) );
  INVX2 U1972 ( .A(n535), .Y(n2332) );
  INVX2 U1973 ( .A(n534), .Y(n2331) );
  BUFX2 U1974 ( .A(n_rst), .Y(n2395) );
  BUFX2 U1975 ( .A(n_rst), .Y(n2394) );
  BUFX2 U1976 ( .A(n_rst), .Y(n2393) );
  BUFX2 U1977 ( .A(n_rst), .Y(n2392) );
  BUFX2 U1978 ( .A(n_rst), .Y(n2391) );
  NOR2X1 U1979 ( .A(n2284), .B(N22), .Y(n546) );
  NAND2X1 U1980 ( .A(n546), .B(N20), .Y(n2256) );
  NOR2X1 U1981 ( .A(N21), .B(N22), .Y(n547) );
  NAND2X1 U1982 ( .A(n547), .B(N20), .Y(n2269) );
  OAI22X1 U1983 ( .A(\registers[35][0] ), .B(n2286), .C(\registers[33][0] ), 
        .D(n2330), .Y(n545) );
  AND2X1 U1984 ( .A(N22), .B(N21), .Y(n550) );
  NAND2X1 U1985 ( .A(N20), .B(n550), .Y(n2259) );
  AND2X1 U1986 ( .A(N22), .B(n2284), .Y(n551) );
  NAND2X1 U1987 ( .A(n551), .B(N20), .Y(n2257) );
  OAI22X1 U1988 ( .A(\registers[39][0] ), .B(n2297), .C(\registers[37][0] ), 
        .D(n2296), .Y(n544) );
  NOR2X1 U1989 ( .A(n545), .B(n544), .Y(n563) );
  NAND2X1 U1990 ( .A(n546), .B(n2285), .Y(n2263) );
  NAND2X1 U1991 ( .A(n547), .B(n2285), .Y(n2262) );
  NOR2X1 U1992 ( .A(\registers[32][0] ), .B(n2307), .Y(n548) );
  NOR2X1 U1993 ( .A(n2331), .B(n548), .Y(n549) );
  OAI21X1 U1994 ( .A(\registers[34][0] ), .B(n2313), .C(n549), .Y(n553) );
  NAND2X1 U1995 ( .A(n550), .B(n2285), .Y(n2268) );
  NAND2X1 U1996 ( .A(n551), .B(n2285), .Y(n2267) );
  OAI22X1 U1997 ( .A(\registers[38][0] ), .B(n2320), .C(\registers[36][0] ), 
        .D(n2319), .Y(n552) );
  NOR2X1 U1998 ( .A(n553), .B(n552), .Y(n562) );
  OAI22X1 U1999 ( .A(\registers[51][0] ), .B(n2286), .C(\registers[49][0] ), 
        .D(n2330), .Y(n555) );
  OAI22X1 U2000 ( .A(\registers[55][0] ), .B(n2297), .C(\registers[53][0] ), 
        .D(n2296), .Y(n554) );
  NOR2X1 U2001 ( .A(n555), .B(n554), .Y(n561) );
  NOR2X1 U2002 ( .A(\registers[48][0] ), .B(n2307), .Y(n556) );
  NOR2X1 U2003 ( .A(n2332), .B(n556), .Y(n557) );
  OAI21X1 U2004 ( .A(\registers[50][0] ), .B(n2313), .C(n557), .Y(n559) );
  OAI22X1 U2005 ( .A(\registers[54][0] ), .B(n2320), .C(\registers[52][0] ), 
        .D(n2319), .Y(n558) );
  NOR2X1 U2006 ( .A(n559), .B(n558), .Y(n560) );
  AOI22X1 U2007 ( .A(n563), .B(n562), .C(n561), .D(n560), .Y(n581) );
  OAI22X1 U2008 ( .A(\registers[3][0] ), .B(n2286), .C(\registers[1][0] ), .D(
        n2330), .Y(n565) );
  OAI22X1 U2009 ( .A(\registers[7][0] ), .B(n2297), .C(\registers[5][0] ), .D(
        n2296), .Y(n564) );
  NOR2X1 U2010 ( .A(n565), .B(n564), .Y(n579) );
  NOR2X1 U2011 ( .A(N24), .B(N25), .Y(n2248) );
  NOR2X1 U2012 ( .A(\registers[0][0] ), .B(n2307), .Y(n566) );
  NOR2X1 U2013 ( .A(n2280), .B(n566), .Y(n567) );
  OAI21X1 U2014 ( .A(\registers[2][0] ), .B(n2313), .C(n567), .Y(n569) );
  OAI22X1 U2015 ( .A(\registers[6][0] ), .B(n2320), .C(\registers[4][0] ), .D(
        n2319), .Y(n568) );
  NOR2X1 U2016 ( .A(n569), .B(n568), .Y(n578) );
  OAI22X1 U2017 ( .A(\registers[19][0] ), .B(n2286), .C(\registers[17][0] ), 
        .D(n2330), .Y(n571) );
  OAI22X1 U2018 ( .A(\registers[23][0] ), .B(n2297), .C(\registers[21][0] ), 
        .D(n2296), .Y(n570) );
  NOR2X1 U2019 ( .A(n571), .B(n570), .Y(n577) );
  NOR2X1 U2020 ( .A(n2281), .B(N25), .Y(n2258) );
  NOR2X1 U2021 ( .A(\registers[16][0] ), .B(n2307), .Y(n572) );
  NOR2X1 U2022 ( .A(n2282), .B(n572), .Y(n573) );
  OAI21X1 U2023 ( .A(\registers[18][0] ), .B(n2313), .C(n573), .Y(n575) );
  OAI22X1 U2024 ( .A(\registers[22][0] ), .B(n2320), .C(\registers[20][0] ), 
        .D(n2319), .Y(n574) );
  NOR2X1 U2025 ( .A(n575), .B(n574), .Y(n576) );
  AOI22X1 U2026 ( .A(n579), .B(n578), .C(n577), .D(n576), .Y(n580) );
  AOI21X1 U2027 ( .A(n581), .B(n580), .C(N23), .Y(n617) );
  OAI22X1 U2028 ( .A(\registers[43][0] ), .B(n2286), .C(\registers[41][0] ), 
        .D(n2330), .Y(n583) );
  OAI22X1 U2029 ( .A(\registers[47][0] ), .B(n2297), .C(\registers[45][0] ), 
        .D(n2296), .Y(n582) );
  NOR2X1 U2030 ( .A(n583), .B(n582), .Y(n597) );
  NOR2X1 U2031 ( .A(\registers[40][0] ), .B(n2307), .Y(n584) );
  NOR2X1 U2032 ( .A(n2331), .B(n584), .Y(n585) );
  OAI21X1 U2033 ( .A(\registers[42][0] ), .B(n2313), .C(n585), .Y(n587) );
  OAI22X1 U2034 ( .A(\registers[46][0] ), .B(n2320), .C(\registers[44][0] ), 
        .D(n2319), .Y(n586) );
  NOR2X1 U2035 ( .A(n587), .B(n586), .Y(n596) );
  OAI22X1 U2036 ( .A(\registers[59][0] ), .B(n2286), .C(\registers[57][0] ), 
        .D(n2330), .Y(n589) );
  OAI22X1 U2037 ( .A(\registers[63][0] ), .B(n2297), .C(\registers[61][0] ), 
        .D(n2296), .Y(n588) );
  NOR2X1 U2038 ( .A(n589), .B(n588), .Y(n595) );
  NOR2X1 U2039 ( .A(\registers[56][0] ), .B(n2307), .Y(n590) );
  NOR2X1 U2040 ( .A(n2332), .B(n590), .Y(n591) );
  OAI21X1 U2041 ( .A(\registers[58][0] ), .B(n2313), .C(n591), .Y(n593) );
  OAI22X1 U2042 ( .A(\registers[62][0] ), .B(n2320), .C(\registers[60][0] ), 
        .D(n2319), .Y(n592) );
  NOR2X1 U2043 ( .A(n593), .B(n592), .Y(n594) );
  AOI22X1 U2044 ( .A(n597), .B(n596), .C(n595), .D(n594), .Y(n615) );
  OAI22X1 U2045 ( .A(\registers[11][0] ), .B(n2286), .C(\registers[9][0] ), 
        .D(n2330), .Y(n599) );
  OAI22X1 U2046 ( .A(\registers[15][0] ), .B(n2297), .C(\registers[13][0] ), 
        .D(n2296), .Y(n598) );
  NOR2X1 U2047 ( .A(n599), .B(n598), .Y(n613) );
  NOR2X1 U2048 ( .A(\registers[8][0] ), .B(n2307), .Y(n600) );
  NOR2X1 U2049 ( .A(n2280), .B(n600), .Y(n601) );
  OAI21X1 U2050 ( .A(\registers[10][0] ), .B(n2313), .C(n601), .Y(n603) );
  OAI22X1 U2051 ( .A(\registers[14][0] ), .B(n2320), .C(\registers[12][0] ), 
        .D(n2319), .Y(n602) );
  NOR2X1 U2052 ( .A(n603), .B(n602), .Y(n612) );
  OAI22X1 U2053 ( .A(\registers[27][0] ), .B(n2286), .C(\registers[25][0] ), 
        .D(n2330), .Y(n605) );
  OAI22X1 U2054 ( .A(\registers[31][0] ), .B(n2297), .C(\registers[29][0] ), 
        .D(n2296), .Y(n604) );
  NOR2X1 U2055 ( .A(n605), .B(n604), .Y(n611) );
  NOR2X1 U2056 ( .A(\registers[24][0] ), .B(n2307), .Y(n606) );
  NOR2X1 U2057 ( .A(n2282), .B(n606), .Y(n607) );
  OAI21X1 U2058 ( .A(\registers[26][0] ), .B(n2313), .C(n607), .Y(n609) );
  OAI22X1 U2059 ( .A(\registers[30][0] ), .B(n2320), .C(\registers[28][0] ), 
        .D(n2319), .Y(n608) );
  NOR2X1 U2060 ( .A(n609), .B(n608), .Y(n610) );
  AOI22X1 U2061 ( .A(n613), .B(n612), .C(n611), .D(n610), .Y(n614) );
  AOI21X1 U2062 ( .A(n615), .B(n614), .C(n2283), .Y(n616) );
  OAI22X1 U2063 ( .A(\registers[35][1] ), .B(n2286), .C(\registers[33][1] ), 
        .D(n2330), .Y(n619) );
  OAI22X1 U2064 ( .A(\registers[39][1] ), .B(n2297), .C(\registers[37][1] ), 
        .D(n2296), .Y(n618) );
  NOR2X1 U2065 ( .A(n619), .B(n618), .Y(n1791) );
  NOR2X1 U2066 ( .A(\registers[32][1] ), .B(n2307), .Y(n620) );
  NOR2X1 U2067 ( .A(n2331), .B(n620), .Y(n621) );
  OAI21X1 U2068 ( .A(\registers[34][1] ), .B(n2313), .C(n621), .Y(n623) );
  OAI22X1 U2069 ( .A(\registers[38][1] ), .B(n2320), .C(\registers[36][1] ), 
        .D(n2319), .Y(n622) );
  NOR2X1 U2070 ( .A(n623), .B(n622), .Y(n1790) );
  OAI22X1 U2071 ( .A(\registers[51][1] ), .B(n2286), .C(\registers[49][1] ), 
        .D(n2330), .Y(n1783) );
  OAI22X1 U2072 ( .A(\registers[55][1] ), .B(n2297), .C(\registers[53][1] ), 
        .D(n2296), .Y(n624) );
  NOR2X1 U2073 ( .A(n1783), .B(n624), .Y(n1789) );
  NOR2X1 U2074 ( .A(\registers[48][1] ), .B(n2307), .Y(n1784) );
  NOR2X1 U2075 ( .A(n2332), .B(n1784), .Y(n1785) );
  OAI21X1 U2076 ( .A(\registers[50][1] ), .B(n2313), .C(n1785), .Y(n1787) );
  OAI22X1 U2077 ( .A(\registers[54][1] ), .B(n2320), .C(\registers[52][1] ), 
        .D(n2319), .Y(n1786) );
  NOR2X1 U2078 ( .A(n1787), .B(n1786), .Y(n1788) );
  AOI22X1 U2079 ( .A(n1791), .B(n1790), .C(n1789), .D(n1788), .Y(n1809) );
  OAI22X1 U2080 ( .A(\registers[3][1] ), .B(n2286), .C(\registers[1][1] ), .D(
        n2330), .Y(n1793) );
  OAI22X1 U2081 ( .A(\registers[7][1] ), .B(n2297), .C(\registers[5][1] ), .D(
        n2296), .Y(n1792) );
  NOR2X1 U2082 ( .A(n1793), .B(n1792), .Y(n1807) );
  NOR2X1 U2083 ( .A(\registers[0][1] ), .B(n2307), .Y(n1794) );
  NOR2X1 U2084 ( .A(n2280), .B(n1794), .Y(n1795) );
  OAI21X1 U2085 ( .A(\registers[2][1] ), .B(n2313), .C(n1795), .Y(n1797) );
  OAI22X1 U2086 ( .A(\registers[6][1] ), .B(n2320), .C(\registers[4][1] ), .D(
        n2319), .Y(n1796) );
  NOR2X1 U2087 ( .A(n1797), .B(n1796), .Y(n1806) );
  OAI22X1 U2088 ( .A(\registers[19][1] ), .B(n2286), .C(\registers[17][1] ), 
        .D(n2330), .Y(n1799) );
  OAI22X1 U2089 ( .A(\registers[23][1] ), .B(n2297), .C(\registers[21][1] ), 
        .D(n2296), .Y(n1798) );
  NOR2X1 U2090 ( .A(n1799), .B(n1798), .Y(n1805) );
  NOR2X1 U2091 ( .A(\registers[16][1] ), .B(n2307), .Y(n1800) );
  NOR2X1 U2092 ( .A(n2282), .B(n1800), .Y(n1801) );
  OAI21X1 U2093 ( .A(\registers[18][1] ), .B(n2313), .C(n1801), .Y(n1803) );
  OAI22X1 U2094 ( .A(\registers[22][1] ), .B(n2320), .C(\registers[20][1] ), 
        .D(n2319), .Y(n1802) );
  NOR2X1 U2095 ( .A(n1803), .B(n1802), .Y(n1804) );
  AOI22X1 U2096 ( .A(n1807), .B(n1806), .C(n1805), .D(n1804), .Y(n1808) );
  AOI21X1 U2097 ( .A(n1809), .B(n1808), .C(N23), .Y(n1845) );
  OAI22X1 U2098 ( .A(\registers[43][1] ), .B(n2287), .C(\registers[41][1] ), 
        .D(n2329), .Y(n1811) );
  OAI22X1 U2099 ( .A(\registers[47][1] ), .B(n2298), .C(\registers[45][1] ), 
        .D(n2295), .Y(n1810) );
  NOR2X1 U2100 ( .A(n1811), .B(n1810), .Y(n1825) );
  NOR2X1 U2101 ( .A(\registers[40][1] ), .B(n2306), .Y(n1812) );
  NOR2X1 U2102 ( .A(n2331), .B(n1812), .Y(n1813) );
  OAI21X1 U2103 ( .A(\registers[42][1] ), .B(n2312), .C(n1813), .Y(n1815) );
  OAI22X1 U2104 ( .A(\registers[46][1] ), .B(n2321), .C(\registers[44][1] ), 
        .D(n2318), .Y(n1814) );
  NOR2X1 U2105 ( .A(n1815), .B(n1814), .Y(n1824) );
  OAI22X1 U2106 ( .A(\registers[59][1] ), .B(n2287), .C(\registers[57][1] ), 
        .D(n2329), .Y(n1817) );
  OAI22X1 U2107 ( .A(\registers[63][1] ), .B(n2298), .C(\registers[61][1] ), 
        .D(n2295), .Y(n1816) );
  NOR2X1 U2108 ( .A(n1817), .B(n1816), .Y(n1823) );
  NOR2X1 U2109 ( .A(\registers[56][1] ), .B(n2306), .Y(n1818) );
  NOR2X1 U2110 ( .A(n2332), .B(n1818), .Y(n1819) );
  OAI21X1 U2111 ( .A(\registers[58][1] ), .B(n2312), .C(n1819), .Y(n1821) );
  OAI22X1 U2112 ( .A(\registers[62][1] ), .B(n2321), .C(\registers[60][1] ), 
        .D(n2318), .Y(n1820) );
  NOR2X1 U2113 ( .A(n1821), .B(n1820), .Y(n1822) );
  AOI22X1 U2114 ( .A(n1825), .B(n1824), .C(n1823), .D(n1822), .Y(n1843) );
  OAI22X1 U2115 ( .A(\registers[11][1] ), .B(n2287), .C(\registers[9][1] ), 
        .D(n2329), .Y(n1827) );
  OAI22X1 U2116 ( .A(\registers[15][1] ), .B(n2298), .C(\registers[13][1] ), 
        .D(n2295), .Y(n1826) );
  NOR2X1 U2117 ( .A(n1827), .B(n1826), .Y(n1841) );
  NOR2X1 U2118 ( .A(\registers[8][1] ), .B(n2306), .Y(n1828) );
  NOR2X1 U2119 ( .A(n2280), .B(n1828), .Y(n1829) );
  OAI21X1 U2120 ( .A(\registers[10][1] ), .B(n2312), .C(n1829), .Y(n1831) );
  OAI22X1 U2121 ( .A(\registers[14][1] ), .B(n2321), .C(\registers[12][1] ), 
        .D(n2318), .Y(n1830) );
  NOR2X1 U2122 ( .A(n1831), .B(n1830), .Y(n1840) );
  OAI22X1 U2123 ( .A(\registers[27][1] ), .B(n2287), .C(\registers[25][1] ), 
        .D(n2329), .Y(n1833) );
  OAI22X1 U2124 ( .A(\registers[31][1] ), .B(n2298), .C(\registers[29][1] ), 
        .D(n2295), .Y(n1832) );
  NOR2X1 U2125 ( .A(n1833), .B(n1832), .Y(n1839) );
  NOR2X1 U2126 ( .A(\registers[24][1] ), .B(n2306), .Y(n1834) );
  NOR2X1 U2127 ( .A(n2282), .B(n1834), .Y(n1835) );
  OAI21X1 U2128 ( .A(\registers[26][1] ), .B(n2312), .C(n1835), .Y(n1837) );
  OAI22X1 U2129 ( .A(\registers[30][1] ), .B(n2321), .C(\registers[28][1] ), 
        .D(n2318), .Y(n1836) );
  NOR2X1 U2130 ( .A(n1837), .B(n1836), .Y(n1838) );
  AOI22X1 U2131 ( .A(n1841), .B(n1840), .C(n1839), .D(n1838), .Y(n1842) );
  AOI21X1 U2132 ( .A(n1843), .B(n1842), .C(n2283), .Y(n1844) );
  OAI22X1 U2133 ( .A(\registers[35][2] ), .B(n2287), .C(\registers[33][2] ), 
        .D(n2329), .Y(n1847) );
  OAI22X1 U2134 ( .A(\registers[39][2] ), .B(n2298), .C(\registers[37][2] ), 
        .D(n2295), .Y(n1846) );
  NOR2X1 U2135 ( .A(n1847), .B(n1846), .Y(n1861) );
  NOR2X1 U2136 ( .A(\registers[32][2] ), .B(n2306), .Y(n1848) );
  NOR2X1 U2137 ( .A(n2331), .B(n1848), .Y(n1849) );
  OAI21X1 U2138 ( .A(\registers[34][2] ), .B(n2312), .C(n1849), .Y(n1851) );
  OAI22X1 U2139 ( .A(\registers[38][2] ), .B(n2321), .C(\registers[36][2] ), 
        .D(n2318), .Y(n1850) );
  NOR2X1 U2140 ( .A(n1851), .B(n1850), .Y(n1860) );
  OAI22X1 U2141 ( .A(\registers[51][2] ), .B(n2287), .C(\registers[49][2] ), 
        .D(n2329), .Y(n1853) );
  OAI22X1 U2142 ( .A(\registers[55][2] ), .B(n2298), .C(\registers[53][2] ), 
        .D(n2295), .Y(n1852) );
  NOR2X1 U2143 ( .A(n1853), .B(n1852), .Y(n1859) );
  NOR2X1 U2144 ( .A(\registers[48][2] ), .B(n2306), .Y(n1854) );
  NOR2X1 U2145 ( .A(n2332), .B(n1854), .Y(n1855) );
  OAI21X1 U2146 ( .A(\registers[50][2] ), .B(n2312), .C(n1855), .Y(n1857) );
  OAI22X1 U2147 ( .A(\registers[54][2] ), .B(n2321), .C(\registers[52][2] ), 
        .D(n2318), .Y(n1856) );
  NOR2X1 U2148 ( .A(n1857), .B(n1856), .Y(n1858) );
  AOI22X1 U2149 ( .A(n1861), .B(n1860), .C(n1859), .D(n1858), .Y(n1879) );
  OAI22X1 U2150 ( .A(\registers[3][2] ), .B(n2287), .C(\registers[1][2] ), .D(
        n2329), .Y(n1863) );
  OAI22X1 U2151 ( .A(\registers[7][2] ), .B(n2298), .C(\registers[5][2] ), .D(
        n2295), .Y(n1862) );
  NOR2X1 U2152 ( .A(n1863), .B(n1862), .Y(n1877) );
  NOR2X1 U2153 ( .A(\registers[0][2] ), .B(n2306), .Y(n1864) );
  NOR2X1 U2154 ( .A(n2280), .B(n1864), .Y(n1865) );
  OAI21X1 U2155 ( .A(\registers[2][2] ), .B(n2312), .C(n1865), .Y(n1867) );
  OAI22X1 U2156 ( .A(\registers[6][2] ), .B(n2321), .C(\registers[4][2] ), .D(
        n2318), .Y(n1866) );
  NOR2X1 U2157 ( .A(n1867), .B(n1866), .Y(n1876) );
  OAI22X1 U2158 ( .A(\registers[19][2] ), .B(n2287), .C(\registers[17][2] ), 
        .D(n2329), .Y(n1869) );
  OAI22X1 U2159 ( .A(\registers[23][2] ), .B(n2298), .C(\registers[21][2] ), 
        .D(n2295), .Y(n1868) );
  NOR2X1 U2160 ( .A(n1869), .B(n1868), .Y(n1875) );
  NOR2X1 U2161 ( .A(\registers[16][2] ), .B(n2306), .Y(n1870) );
  NOR2X1 U2162 ( .A(n2282), .B(n1870), .Y(n1871) );
  OAI21X1 U2163 ( .A(\registers[18][2] ), .B(n2312), .C(n1871), .Y(n1873) );
  OAI22X1 U2164 ( .A(\registers[22][2] ), .B(n2321), .C(\registers[20][2] ), 
        .D(n2318), .Y(n1872) );
  NOR2X1 U2165 ( .A(n1873), .B(n1872), .Y(n1874) );
  AOI22X1 U2166 ( .A(n1877), .B(n1876), .C(n1875), .D(n1874), .Y(n1878) );
  AOI21X1 U2167 ( .A(n1879), .B(n1878), .C(N23), .Y(n1915) );
  OAI22X1 U2168 ( .A(\registers[43][2] ), .B(n2287), .C(\registers[41][2] ), 
        .D(n2329), .Y(n1881) );
  OAI22X1 U2169 ( .A(\registers[47][2] ), .B(n2298), .C(\registers[45][2] ), 
        .D(n2295), .Y(n1880) );
  NOR2X1 U2170 ( .A(n1881), .B(n1880), .Y(n1895) );
  NOR2X1 U2171 ( .A(\registers[40][2] ), .B(n2306), .Y(n1882) );
  NOR2X1 U2172 ( .A(n2331), .B(n1882), .Y(n1883) );
  OAI21X1 U2173 ( .A(\registers[42][2] ), .B(n2312), .C(n1883), .Y(n1885) );
  OAI22X1 U2174 ( .A(\registers[46][2] ), .B(n2321), .C(\registers[44][2] ), 
        .D(n2318), .Y(n1884) );
  NOR2X1 U2175 ( .A(n1885), .B(n1884), .Y(n1894) );
  OAI22X1 U2176 ( .A(\registers[59][2] ), .B(n2287), .C(\registers[57][2] ), 
        .D(n2329), .Y(n1887) );
  OAI22X1 U2177 ( .A(\registers[63][2] ), .B(n2298), .C(\registers[61][2] ), 
        .D(n2295), .Y(n1886) );
  NOR2X1 U2178 ( .A(n1887), .B(n1886), .Y(n1893) );
  NOR2X1 U2179 ( .A(\registers[56][2] ), .B(n2306), .Y(n1888) );
  NOR2X1 U2180 ( .A(n2332), .B(n1888), .Y(n1889) );
  OAI21X1 U2181 ( .A(\registers[58][2] ), .B(n2312), .C(n1889), .Y(n1891) );
  OAI22X1 U2182 ( .A(\registers[62][2] ), .B(n2321), .C(\registers[60][2] ), 
        .D(n2318), .Y(n1890) );
  NOR2X1 U2183 ( .A(n1891), .B(n1890), .Y(n1892) );
  AOI22X1 U2184 ( .A(n1895), .B(n1894), .C(n1893), .D(n1892), .Y(n1913) );
  OAI22X1 U2185 ( .A(\registers[11][2] ), .B(n2287), .C(\registers[9][2] ), 
        .D(n2329), .Y(n1897) );
  OAI22X1 U2186 ( .A(\registers[15][2] ), .B(n2298), .C(\registers[13][2] ), 
        .D(n2295), .Y(n1896) );
  NOR2X1 U2187 ( .A(n1897), .B(n1896), .Y(n1911) );
  NOR2X1 U2188 ( .A(\registers[8][2] ), .B(n2306), .Y(n1898) );
  NOR2X1 U2189 ( .A(n2280), .B(n1898), .Y(n1899) );
  OAI21X1 U2190 ( .A(\registers[10][2] ), .B(n2312), .C(n1899), .Y(n1901) );
  OAI22X1 U2191 ( .A(\registers[14][2] ), .B(n2321), .C(\registers[12][2] ), 
        .D(n2318), .Y(n1900) );
  NOR2X1 U2192 ( .A(n1901), .B(n1900), .Y(n1910) );
  OAI22X1 U2193 ( .A(\registers[27][2] ), .B(n2287), .C(\registers[25][2] ), 
        .D(n2329), .Y(n1903) );
  OAI22X1 U2194 ( .A(\registers[31][2] ), .B(n2298), .C(\registers[29][2] ), 
        .D(n2295), .Y(n1902) );
  NOR2X1 U2195 ( .A(n1903), .B(n1902), .Y(n1909) );
  NOR2X1 U2196 ( .A(\registers[24][2] ), .B(n2306), .Y(n1904) );
  NOR2X1 U2197 ( .A(n2282), .B(n1904), .Y(n1905) );
  OAI21X1 U2198 ( .A(\registers[26][2] ), .B(n2312), .C(n1905), .Y(n1907) );
  OAI22X1 U2199 ( .A(\registers[30][2] ), .B(n2321), .C(\registers[28][2] ), 
        .D(n2318), .Y(n1906) );
  NOR2X1 U2200 ( .A(n1907), .B(n1906), .Y(n1908) );
  AOI22X1 U2201 ( .A(n1911), .B(n1910), .C(n1909), .D(n1908), .Y(n1912) );
  AOI21X1 U2202 ( .A(n1913), .B(n1912), .C(n2283), .Y(n1914) );
  OAI22X1 U2203 ( .A(\registers[35][3] ), .B(n2287), .C(\registers[33][3] ), 
        .D(n2328), .Y(n1917) );
  OAI22X1 U2204 ( .A(\registers[39][3] ), .B(n2298), .C(\registers[37][3] ), 
        .D(n2294), .Y(n1916) );
  NOR2X1 U2205 ( .A(n1917), .B(n1916), .Y(n1931) );
  NOR2X1 U2206 ( .A(\registers[32][3] ), .B(n2305), .Y(n1918) );
  NOR2X1 U2207 ( .A(n2331), .B(n1918), .Y(n1919) );
  OAI21X1 U2208 ( .A(\registers[34][3] ), .B(n2311), .C(n1919), .Y(n1921) );
  OAI22X1 U2209 ( .A(\registers[38][3] ), .B(n2321), .C(\registers[36][3] ), 
        .D(n2317), .Y(n1920) );
  NOR2X1 U2210 ( .A(n1921), .B(n1920), .Y(n1930) );
  OAI22X1 U2211 ( .A(\registers[51][3] ), .B(n2288), .C(\registers[49][3] ), 
        .D(n2328), .Y(n1923) );
  OAI22X1 U2212 ( .A(\registers[55][3] ), .B(n2299), .C(\registers[53][3] ), 
        .D(n2294), .Y(n1922) );
  NOR2X1 U2213 ( .A(n1923), .B(n1922), .Y(n1929) );
  NOR2X1 U2214 ( .A(\registers[48][3] ), .B(n2305), .Y(n1924) );
  NOR2X1 U2215 ( .A(n2332), .B(n1924), .Y(n1925) );
  OAI21X1 U2216 ( .A(\registers[50][3] ), .B(n2311), .C(n1925), .Y(n1927) );
  OAI22X1 U2217 ( .A(\registers[54][3] ), .B(n2322), .C(\registers[52][3] ), 
        .D(n2317), .Y(n1926) );
  NOR2X1 U2218 ( .A(n1927), .B(n1926), .Y(n1928) );
  AOI22X1 U2219 ( .A(n1931), .B(n1930), .C(n1929), .D(n1928), .Y(n1949) );
  OAI22X1 U2220 ( .A(\registers[3][3] ), .B(n2288), .C(\registers[1][3] ), .D(
        n2328), .Y(n1933) );
  OAI22X1 U2221 ( .A(\registers[7][3] ), .B(n2299), .C(\registers[5][3] ), .D(
        n2294), .Y(n1932) );
  NOR2X1 U2222 ( .A(n1933), .B(n1932), .Y(n1947) );
  NOR2X1 U2223 ( .A(\registers[0][3] ), .B(n2305), .Y(n1934) );
  NOR2X1 U2224 ( .A(n2280), .B(n1934), .Y(n1935) );
  OAI21X1 U2225 ( .A(\registers[2][3] ), .B(n2311), .C(n1935), .Y(n1937) );
  OAI22X1 U2226 ( .A(\registers[6][3] ), .B(n2322), .C(\registers[4][3] ), .D(
        n2317), .Y(n1936) );
  NOR2X1 U2227 ( .A(n1937), .B(n1936), .Y(n1946) );
  OAI22X1 U2228 ( .A(\registers[19][3] ), .B(n2288), .C(\registers[17][3] ), 
        .D(n2328), .Y(n1939) );
  OAI22X1 U2229 ( .A(\registers[23][3] ), .B(n2299), .C(\registers[21][3] ), 
        .D(n2294), .Y(n1938) );
  NOR2X1 U2230 ( .A(n1939), .B(n1938), .Y(n1945) );
  NOR2X1 U2231 ( .A(\registers[16][3] ), .B(n2305), .Y(n1940) );
  NOR2X1 U2232 ( .A(n2282), .B(n1940), .Y(n1941) );
  OAI21X1 U2233 ( .A(\registers[18][3] ), .B(n2311), .C(n1941), .Y(n1943) );
  OAI22X1 U2234 ( .A(\registers[22][3] ), .B(n2322), .C(\registers[20][3] ), 
        .D(n2317), .Y(n1942) );
  NOR2X1 U2235 ( .A(n1943), .B(n1942), .Y(n1944) );
  AOI22X1 U2236 ( .A(n1947), .B(n1946), .C(n1945), .D(n1944), .Y(n1948) );
  AOI21X1 U2237 ( .A(n1949), .B(n1948), .C(N23), .Y(n1985) );
  OAI22X1 U2238 ( .A(\registers[43][3] ), .B(n2288), .C(\registers[41][3] ), 
        .D(n2328), .Y(n1951) );
  OAI22X1 U2239 ( .A(\registers[47][3] ), .B(n2299), .C(\registers[45][3] ), 
        .D(n2294), .Y(n1950) );
  NOR2X1 U2240 ( .A(n1951), .B(n1950), .Y(n1965) );
  NOR2X1 U2241 ( .A(\registers[40][3] ), .B(n2305), .Y(n1952) );
  NOR2X1 U2242 ( .A(n2331), .B(n1952), .Y(n1953) );
  OAI21X1 U2243 ( .A(\registers[42][3] ), .B(n2311), .C(n1953), .Y(n1955) );
  OAI22X1 U2244 ( .A(\registers[46][3] ), .B(n2322), .C(\registers[44][3] ), 
        .D(n2317), .Y(n1954) );
  NOR2X1 U2245 ( .A(n1955), .B(n1954), .Y(n1964) );
  OAI22X1 U2246 ( .A(\registers[59][3] ), .B(n2288), .C(\registers[57][3] ), 
        .D(n2328), .Y(n1957) );
  OAI22X1 U2247 ( .A(\registers[63][3] ), .B(n2299), .C(\registers[61][3] ), 
        .D(n2294), .Y(n1956) );
  NOR2X1 U2248 ( .A(n1957), .B(n1956), .Y(n1963) );
  NOR2X1 U2249 ( .A(\registers[56][3] ), .B(n2305), .Y(n1958) );
  NOR2X1 U2250 ( .A(n2332), .B(n1958), .Y(n1959) );
  OAI21X1 U2251 ( .A(\registers[58][3] ), .B(n2311), .C(n1959), .Y(n1961) );
  OAI22X1 U2252 ( .A(\registers[62][3] ), .B(n2322), .C(\registers[60][3] ), 
        .D(n2317), .Y(n1960) );
  NOR2X1 U2253 ( .A(n1961), .B(n1960), .Y(n1962) );
  AOI22X1 U2254 ( .A(n1965), .B(n1964), .C(n1963), .D(n1962), .Y(n1983) );
  OAI22X1 U2255 ( .A(\registers[11][3] ), .B(n2288), .C(\registers[9][3] ), 
        .D(n2328), .Y(n1967) );
  OAI22X1 U2256 ( .A(\registers[15][3] ), .B(n2299), .C(\registers[13][3] ), 
        .D(n2294), .Y(n1966) );
  NOR2X1 U2257 ( .A(n1967), .B(n1966), .Y(n1981) );
  NOR2X1 U2258 ( .A(\registers[8][3] ), .B(n2305), .Y(n1968) );
  NOR2X1 U2259 ( .A(n2280), .B(n1968), .Y(n1969) );
  OAI21X1 U2260 ( .A(\registers[10][3] ), .B(n2311), .C(n1969), .Y(n1971) );
  OAI22X1 U2261 ( .A(\registers[14][3] ), .B(n2322), .C(\registers[12][3] ), 
        .D(n2317), .Y(n1970) );
  NOR2X1 U2262 ( .A(n1971), .B(n1970), .Y(n1980) );
  OAI22X1 U2263 ( .A(\registers[27][3] ), .B(n2288), .C(\registers[25][3] ), 
        .D(n2328), .Y(n1973) );
  OAI22X1 U2264 ( .A(\registers[31][3] ), .B(n2299), .C(\registers[29][3] ), 
        .D(n2294), .Y(n1972) );
  NOR2X1 U2265 ( .A(n1973), .B(n1972), .Y(n1979) );
  NOR2X1 U2266 ( .A(\registers[24][3] ), .B(n2305), .Y(n1974) );
  NOR2X1 U2267 ( .A(n2282), .B(n1974), .Y(n1975) );
  OAI21X1 U2268 ( .A(\registers[26][3] ), .B(n2311), .C(n1975), .Y(n1977) );
  OAI22X1 U2269 ( .A(\registers[30][3] ), .B(n2322), .C(\registers[28][3] ), 
        .D(n2317), .Y(n1976) );
  NOR2X1 U2270 ( .A(n1977), .B(n1976), .Y(n1978) );
  AOI22X1 U2271 ( .A(n1981), .B(n1980), .C(n1979), .D(n1978), .Y(n1982) );
  AOI21X1 U2272 ( .A(n1983), .B(n1982), .C(n2283), .Y(n1984) );
  OAI22X1 U2273 ( .A(\registers[35][4] ), .B(n2288), .C(\registers[33][4] ), 
        .D(n2328), .Y(n1987) );
  OAI22X1 U2274 ( .A(\registers[39][4] ), .B(n2299), .C(\registers[37][4] ), 
        .D(n2294), .Y(n1986) );
  NOR2X1 U2275 ( .A(n1987), .B(n1986), .Y(n2001) );
  NOR2X1 U2276 ( .A(\registers[32][4] ), .B(n2305), .Y(n1988) );
  NOR2X1 U2277 ( .A(n2331), .B(n1988), .Y(n1989) );
  OAI21X1 U2278 ( .A(\registers[34][4] ), .B(n2311), .C(n1989), .Y(n1991) );
  OAI22X1 U2279 ( .A(\registers[38][4] ), .B(n2322), .C(\registers[36][4] ), 
        .D(n2317), .Y(n1990) );
  NOR2X1 U2280 ( .A(n1991), .B(n1990), .Y(n2000) );
  OAI22X1 U2281 ( .A(\registers[51][4] ), .B(n2288), .C(\registers[49][4] ), 
        .D(n2328), .Y(n1993) );
  OAI22X1 U2282 ( .A(\registers[55][4] ), .B(n2299), .C(\registers[53][4] ), 
        .D(n2294), .Y(n1992) );
  NOR2X1 U2283 ( .A(n1993), .B(n1992), .Y(n1999) );
  NOR2X1 U2284 ( .A(\registers[48][4] ), .B(n2305), .Y(n1994) );
  NOR2X1 U2285 ( .A(n2332), .B(n1994), .Y(n1995) );
  OAI21X1 U2286 ( .A(\registers[50][4] ), .B(n2311), .C(n1995), .Y(n1997) );
  OAI22X1 U2287 ( .A(\registers[54][4] ), .B(n2322), .C(\registers[52][4] ), 
        .D(n2317), .Y(n1996) );
  NOR2X1 U2288 ( .A(n1997), .B(n1996), .Y(n1998) );
  AOI22X1 U2289 ( .A(n2001), .B(n2000), .C(n1999), .D(n1998), .Y(n2019) );
  OAI22X1 U2290 ( .A(\registers[3][4] ), .B(n2288), .C(\registers[1][4] ), .D(
        n2328), .Y(n2003) );
  OAI22X1 U2291 ( .A(\registers[7][4] ), .B(n2299), .C(\registers[5][4] ), .D(
        n2294), .Y(n2002) );
  NOR2X1 U2292 ( .A(n2003), .B(n2002), .Y(n2017) );
  NOR2X1 U2293 ( .A(\registers[0][4] ), .B(n2305), .Y(n2004) );
  NOR2X1 U2294 ( .A(n2280), .B(n2004), .Y(n2005) );
  OAI21X1 U2295 ( .A(\registers[2][4] ), .B(n2311), .C(n2005), .Y(n2007) );
  OAI22X1 U2296 ( .A(\registers[6][4] ), .B(n2322), .C(\registers[4][4] ), .D(
        n2317), .Y(n2006) );
  NOR2X1 U2297 ( .A(n2007), .B(n2006), .Y(n2016) );
  OAI22X1 U2298 ( .A(\registers[19][4] ), .B(n2288), .C(\registers[17][4] ), 
        .D(n2328), .Y(n2009) );
  OAI22X1 U2299 ( .A(\registers[23][4] ), .B(n2299), .C(\registers[21][4] ), 
        .D(n2294), .Y(n2008) );
  NOR2X1 U2300 ( .A(n2009), .B(n2008), .Y(n2015) );
  NOR2X1 U2301 ( .A(\registers[16][4] ), .B(n2305), .Y(n2010) );
  NOR2X1 U2302 ( .A(n2282), .B(n2010), .Y(n2011) );
  OAI21X1 U2303 ( .A(\registers[18][4] ), .B(n2311), .C(n2011), .Y(n2013) );
  OAI22X1 U2304 ( .A(\registers[22][4] ), .B(n2322), .C(\registers[20][4] ), 
        .D(n2317), .Y(n2012) );
  NOR2X1 U2305 ( .A(n2013), .B(n2012), .Y(n2014) );
  AOI22X1 U2306 ( .A(n2017), .B(n2016), .C(n2015), .D(n2014), .Y(n2018) );
  AOI21X1 U2307 ( .A(n2019), .B(n2018), .C(N23), .Y(n2055) );
  OAI22X1 U2308 ( .A(\registers[43][4] ), .B(n2288), .C(\registers[41][4] ), 
        .D(n2327), .Y(n2021) );
  OAI22X1 U2309 ( .A(\registers[47][4] ), .B(n2299), .C(\registers[45][4] ), 
        .D(n2293), .Y(n2020) );
  NOR2X1 U2310 ( .A(n2021), .B(n2020), .Y(n2035) );
  NOR2X1 U2311 ( .A(\registers[40][4] ), .B(n2304), .Y(n2022) );
  NOR2X1 U2312 ( .A(n2331), .B(n2022), .Y(n2023) );
  OAI21X1 U2313 ( .A(\registers[42][4] ), .B(n2310), .C(n2023), .Y(n2025) );
  OAI22X1 U2314 ( .A(\registers[46][4] ), .B(n2322), .C(\registers[44][4] ), 
        .D(n2316), .Y(n2024) );
  NOR2X1 U2315 ( .A(n2025), .B(n2024), .Y(n2034) );
  OAI22X1 U2316 ( .A(\registers[59][4] ), .B(n2288), .C(\registers[57][4] ), 
        .D(n2327), .Y(n2027) );
  OAI22X1 U2317 ( .A(\registers[63][4] ), .B(n2299), .C(\registers[61][4] ), 
        .D(n2293), .Y(n2026) );
  NOR2X1 U2318 ( .A(n2027), .B(n2026), .Y(n2033) );
  NOR2X1 U2319 ( .A(\registers[56][4] ), .B(n2304), .Y(n2028) );
  NOR2X1 U2320 ( .A(n2332), .B(n2028), .Y(n2029) );
  OAI21X1 U2321 ( .A(\registers[58][4] ), .B(n2310), .C(n2029), .Y(n2031) );
  OAI22X1 U2322 ( .A(\registers[62][4] ), .B(n2322), .C(\registers[60][4] ), 
        .D(n2316), .Y(n2030) );
  NOR2X1 U2323 ( .A(n2031), .B(n2030), .Y(n2032) );
  AOI22X1 U2324 ( .A(n2035), .B(n2034), .C(n2033), .D(n2032), .Y(n2053) );
  OAI22X1 U2325 ( .A(\registers[11][4] ), .B(n2289), .C(\registers[9][4] ), 
        .D(n2327), .Y(n2037) );
  OAI22X1 U2326 ( .A(\registers[15][4] ), .B(n2300), .C(\registers[13][4] ), 
        .D(n2293), .Y(n2036) );
  NOR2X1 U2327 ( .A(n2037), .B(n2036), .Y(n2051) );
  NOR2X1 U2328 ( .A(\registers[8][4] ), .B(n2304), .Y(n2038) );
  NOR2X1 U2329 ( .A(n2280), .B(n2038), .Y(n2039) );
  OAI21X1 U2330 ( .A(\registers[10][4] ), .B(n2310), .C(n2039), .Y(n2041) );
  OAI22X1 U2331 ( .A(\registers[14][4] ), .B(n2323), .C(\registers[12][4] ), 
        .D(n2316), .Y(n2040) );
  NOR2X1 U2332 ( .A(n2041), .B(n2040), .Y(n2050) );
  OAI22X1 U2333 ( .A(\registers[27][4] ), .B(n2289), .C(\registers[25][4] ), 
        .D(n2327), .Y(n2043) );
  OAI22X1 U2334 ( .A(\registers[31][4] ), .B(n2300), .C(\registers[29][4] ), 
        .D(n2293), .Y(n2042) );
  NOR2X1 U2335 ( .A(n2043), .B(n2042), .Y(n2049) );
  NOR2X1 U2336 ( .A(\registers[24][4] ), .B(n2304), .Y(n2044) );
  NOR2X1 U2337 ( .A(n2282), .B(n2044), .Y(n2045) );
  OAI21X1 U2338 ( .A(\registers[26][4] ), .B(n2310), .C(n2045), .Y(n2047) );
  OAI22X1 U2339 ( .A(\registers[30][4] ), .B(n2323), .C(\registers[28][4] ), 
        .D(n2316), .Y(n2046) );
  NOR2X1 U2340 ( .A(n2047), .B(n2046), .Y(n2048) );
  AOI22X1 U2341 ( .A(n2051), .B(n2050), .C(n2049), .D(n2048), .Y(n2052) );
  AOI21X1 U2342 ( .A(n2053), .B(n2052), .C(n2283), .Y(n2054) );
  OAI22X1 U2343 ( .A(\registers[35][5] ), .B(n2289), .C(\registers[33][5] ), 
        .D(n2327), .Y(n2057) );
  OAI22X1 U2344 ( .A(\registers[39][5] ), .B(n2300), .C(\registers[37][5] ), 
        .D(n2293), .Y(n2056) );
  NOR2X1 U2345 ( .A(n2057), .B(n2056), .Y(n2071) );
  NOR2X1 U2346 ( .A(\registers[32][5] ), .B(n2304), .Y(n2058) );
  NOR2X1 U2347 ( .A(n2331), .B(n2058), .Y(n2059) );
  OAI21X1 U2348 ( .A(\registers[34][5] ), .B(n2310), .C(n2059), .Y(n2061) );
  OAI22X1 U2349 ( .A(\registers[38][5] ), .B(n2323), .C(\registers[36][5] ), 
        .D(n2316), .Y(n2060) );
  NOR2X1 U2350 ( .A(n2061), .B(n2060), .Y(n2070) );
  OAI22X1 U2351 ( .A(\registers[51][5] ), .B(n2289), .C(\registers[49][5] ), 
        .D(n2327), .Y(n2063) );
  OAI22X1 U2352 ( .A(\registers[55][5] ), .B(n2300), .C(\registers[53][5] ), 
        .D(n2293), .Y(n2062) );
  NOR2X1 U2353 ( .A(n2063), .B(n2062), .Y(n2069) );
  NOR2X1 U2354 ( .A(\registers[48][5] ), .B(n2304), .Y(n2064) );
  NOR2X1 U2355 ( .A(n2332), .B(n2064), .Y(n2065) );
  OAI21X1 U2356 ( .A(\registers[50][5] ), .B(n2310), .C(n2065), .Y(n2067) );
  OAI22X1 U2357 ( .A(\registers[54][5] ), .B(n2323), .C(\registers[52][5] ), 
        .D(n2316), .Y(n2066) );
  NOR2X1 U2358 ( .A(n2067), .B(n2066), .Y(n2068) );
  AOI22X1 U2359 ( .A(n2071), .B(n2070), .C(n2069), .D(n2068), .Y(n2089) );
  OAI22X1 U2360 ( .A(\registers[3][5] ), .B(n2289), .C(\registers[1][5] ), .D(
        n2327), .Y(n2073) );
  OAI22X1 U2361 ( .A(\registers[7][5] ), .B(n2300), .C(\registers[5][5] ), .D(
        n2293), .Y(n2072) );
  NOR2X1 U2362 ( .A(n2073), .B(n2072), .Y(n2087) );
  NOR2X1 U2363 ( .A(\registers[0][5] ), .B(n2304), .Y(n2074) );
  NOR2X1 U2364 ( .A(n2280), .B(n2074), .Y(n2075) );
  OAI21X1 U2365 ( .A(\registers[2][5] ), .B(n2310), .C(n2075), .Y(n2077) );
  OAI22X1 U2366 ( .A(\registers[6][5] ), .B(n2323), .C(\registers[4][5] ), .D(
        n2316), .Y(n2076) );
  NOR2X1 U2367 ( .A(n2077), .B(n2076), .Y(n2086) );
  OAI22X1 U2368 ( .A(\registers[19][5] ), .B(n2289), .C(\registers[17][5] ), 
        .D(n2327), .Y(n2079) );
  OAI22X1 U2369 ( .A(\registers[23][5] ), .B(n2300), .C(\registers[21][5] ), 
        .D(n2293), .Y(n2078) );
  NOR2X1 U2370 ( .A(n2079), .B(n2078), .Y(n2085) );
  NOR2X1 U2371 ( .A(\registers[16][5] ), .B(n2304), .Y(n2080) );
  NOR2X1 U2372 ( .A(n2282), .B(n2080), .Y(n2081) );
  OAI21X1 U2373 ( .A(\registers[18][5] ), .B(n2310), .C(n2081), .Y(n2083) );
  OAI22X1 U2374 ( .A(\registers[22][5] ), .B(n2323), .C(\registers[20][5] ), 
        .D(n2316), .Y(n2082) );
  NOR2X1 U2375 ( .A(n2083), .B(n2082), .Y(n2084) );
  AOI22X1 U2376 ( .A(n2087), .B(n2086), .C(n2085), .D(n2084), .Y(n2088) );
  AOI21X1 U2377 ( .A(n2089), .B(n2088), .C(N23), .Y(n2125) );
  OAI22X1 U2378 ( .A(\registers[43][5] ), .B(n2289), .C(\registers[41][5] ), 
        .D(n2327), .Y(n2091) );
  OAI22X1 U2379 ( .A(\registers[47][5] ), .B(n2300), .C(\registers[45][5] ), 
        .D(n2293), .Y(n2090) );
  NOR2X1 U2380 ( .A(n2091), .B(n2090), .Y(n2105) );
  NOR2X1 U2381 ( .A(\registers[40][5] ), .B(n2304), .Y(n2092) );
  NOR2X1 U2382 ( .A(n2331), .B(n2092), .Y(n2093) );
  OAI21X1 U2383 ( .A(\registers[42][5] ), .B(n2310), .C(n2093), .Y(n2095) );
  OAI22X1 U2384 ( .A(\registers[46][5] ), .B(n2323), .C(\registers[44][5] ), 
        .D(n2316), .Y(n2094) );
  NOR2X1 U2385 ( .A(n2095), .B(n2094), .Y(n2104) );
  OAI22X1 U2386 ( .A(\registers[59][5] ), .B(n2289), .C(\registers[57][5] ), 
        .D(n2327), .Y(n2097) );
  OAI22X1 U2387 ( .A(\registers[63][5] ), .B(n2300), .C(\registers[61][5] ), 
        .D(n2293), .Y(n2096) );
  NOR2X1 U2388 ( .A(n2097), .B(n2096), .Y(n2103) );
  NOR2X1 U2389 ( .A(\registers[56][5] ), .B(n2304), .Y(n2098) );
  NOR2X1 U2390 ( .A(n2332), .B(n2098), .Y(n2099) );
  OAI21X1 U2391 ( .A(\registers[58][5] ), .B(n2310), .C(n2099), .Y(n2101) );
  OAI22X1 U2392 ( .A(\registers[62][5] ), .B(n2323), .C(\registers[60][5] ), 
        .D(n2316), .Y(n2100) );
  NOR2X1 U2393 ( .A(n2101), .B(n2100), .Y(n2102) );
  AOI22X1 U2394 ( .A(n2105), .B(n2104), .C(n2103), .D(n2102), .Y(n2123) );
  OAI22X1 U2395 ( .A(\registers[11][5] ), .B(n2289), .C(\registers[9][5] ), 
        .D(n2327), .Y(n2107) );
  OAI22X1 U2396 ( .A(\registers[15][5] ), .B(n2300), .C(\registers[13][5] ), 
        .D(n2293), .Y(n2106) );
  NOR2X1 U2397 ( .A(n2107), .B(n2106), .Y(n2121) );
  NOR2X1 U2398 ( .A(\registers[8][5] ), .B(n2304), .Y(n2108) );
  NOR2X1 U2399 ( .A(n2280), .B(n2108), .Y(n2109) );
  OAI21X1 U2400 ( .A(\registers[10][5] ), .B(n2310), .C(n2109), .Y(n2111) );
  OAI22X1 U2401 ( .A(\registers[14][5] ), .B(n2323), .C(\registers[12][5] ), 
        .D(n2316), .Y(n2110) );
  NOR2X1 U2402 ( .A(n2111), .B(n2110), .Y(n2120) );
  OAI22X1 U2403 ( .A(\registers[27][5] ), .B(n2289), .C(\registers[25][5] ), 
        .D(n2327), .Y(n2113) );
  OAI22X1 U2404 ( .A(\registers[31][5] ), .B(n2300), .C(\registers[29][5] ), 
        .D(n2293), .Y(n2112) );
  NOR2X1 U2405 ( .A(n2113), .B(n2112), .Y(n2119) );
  NOR2X1 U2406 ( .A(\registers[24][5] ), .B(n2304), .Y(n2114) );
  NOR2X1 U2407 ( .A(n2282), .B(n2114), .Y(n2115) );
  OAI21X1 U2408 ( .A(\registers[26][5] ), .B(n2310), .C(n2115), .Y(n2117) );
  OAI22X1 U2409 ( .A(\registers[30][5] ), .B(n2323), .C(\registers[28][5] ), 
        .D(n2316), .Y(n2116) );
  NOR2X1 U2410 ( .A(n2117), .B(n2116), .Y(n2118) );
  AOI22X1 U2411 ( .A(n2121), .B(n2120), .C(n2119), .D(n2118), .Y(n2122) );
  AOI21X1 U2412 ( .A(n2123), .B(n2122), .C(n2283), .Y(n2124) );
  OAI22X1 U2413 ( .A(\registers[35][6] ), .B(n2289), .C(\registers[33][6] ), 
        .D(n2326), .Y(n2127) );
  OAI22X1 U2414 ( .A(\registers[39][6] ), .B(n2300), .C(\registers[37][6] ), 
        .D(n2292), .Y(n2126) );
  NOR2X1 U2415 ( .A(n2127), .B(n2126), .Y(n2141) );
  NOR2X1 U2416 ( .A(\registers[32][6] ), .B(n2303), .Y(n2128) );
  NOR2X1 U2417 ( .A(n2331), .B(n2128), .Y(n2129) );
  OAI21X1 U2418 ( .A(\registers[34][6] ), .B(n2309), .C(n2129), .Y(n2131) );
  OAI22X1 U2419 ( .A(\registers[38][6] ), .B(n2323), .C(\registers[36][6] ), 
        .D(n2315), .Y(n2130) );
  NOR2X1 U2420 ( .A(n2131), .B(n2130), .Y(n2140) );
  OAI22X1 U2421 ( .A(\registers[51][6] ), .B(n2289), .C(\registers[49][6] ), 
        .D(n2326), .Y(n2133) );
  OAI22X1 U2422 ( .A(\registers[55][6] ), .B(n2300), .C(\registers[53][6] ), 
        .D(n2292), .Y(n2132) );
  NOR2X1 U2423 ( .A(n2133), .B(n2132), .Y(n2139) );
  NOR2X1 U2424 ( .A(\registers[48][6] ), .B(n2303), .Y(n2134) );
  NOR2X1 U2425 ( .A(n2332), .B(n2134), .Y(n2135) );
  OAI21X1 U2426 ( .A(\registers[50][6] ), .B(n2309), .C(n2135), .Y(n2137) );
  OAI22X1 U2427 ( .A(\registers[54][6] ), .B(n2323), .C(\registers[52][6] ), 
        .D(n2315), .Y(n2136) );
  NOR2X1 U2428 ( .A(n2137), .B(n2136), .Y(n2138) );
  AOI22X1 U2429 ( .A(n2141), .B(n2140), .C(n2139), .D(n2138), .Y(n2159) );
  OAI22X1 U2430 ( .A(\registers[3][6] ), .B(n2289), .C(\registers[1][6] ), .D(
        n2326), .Y(n2143) );
  OAI22X1 U2431 ( .A(\registers[7][6] ), .B(n2300), .C(\registers[5][6] ), .D(
        n2292), .Y(n2142) );
  NOR2X1 U2432 ( .A(n2143), .B(n2142), .Y(n2157) );
  NOR2X1 U2433 ( .A(\registers[0][6] ), .B(n2303), .Y(n2144) );
  NOR2X1 U2434 ( .A(n2280), .B(n2144), .Y(n2145) );
  OAI21X1 U2435 ( .A(\registers[2][6] ), .B(n2309), .C(n2145), .Y(n2147) );
  OAI22X1 U2436 ( .A(\registers[6][6] ), .B(n2323), .C(\registers[4][6] ), .D(
        n2315), .Y(n2146) );
  NOR2X1 U2437 ( .A(n2147), .B(n2146), .Y(n2156) );
  OAI22X1 U2438 ( .A(\registers[19][6] ), .B(n2290), .C(\registers[17][6] ), 
        .D(n2326), .Y(n2149) );
  OAI22X1 U2439 ( .A(\registers[23][6] ), .B(n2301), .C(\registers[21][6] ), 
        .D(n2292), .Y(n2148) );
  NOR2X1 U2440 ( .A(n2149), .B(n2148), .Y(n2155) );
  NOR2X1 U2441 ( .A(\registers[16][6] ), .B(n2303), .Y(n2150) );
  NOR2X1 U2442 ( .A(n2282), .B(n2150), .Y(n2151) );
  OAI21X1 U2443 ( .A(\registers[18][6] ), .B(n2309), .C(n2151), .Y(n2153) );
  OAI22X1 U2444 ( .A(\registers[22][6] ), .B(n2324), .C(\registers[20][6] ), 
        .D(n2315), .Y(n2152) );
  NOR2X1 U2445 ( .A(n2153), .B(n2152), .Y(n2154) );
  AOI22X1 U2446 ( .A(n2157), .B(n2156), .C(n2155), .D(n2154), .Y(n2158) );
  AOI21X1 U2447 ( .A(n2159), .B(n2158), .C(N23), .Y(n2195) );
  OAI22X1 U2448 ( .A(\registers[43][6] ), .B(n2290), .C(\registers[41][6] ), 
        .D(n2326), .Y(n2161) );
  OAI22X1 U2449 ( .A(\registers[47][6] ), .B(n2301), .C(\registers[45][6] ), 
        .D(n2292), .Y(n2160) );
  NOR2X1 U2450 ( .A(n2161), .B(n2160), .Y(n2175) );
  NOR2X1 U2451 ( .A(\registers[40][6] ), .B(n2303), .Y(n2162) );
  NOR2X1 U2452 ( .A(n2331), .B(n2162), .Y(n2163) );
  OAI21X1 U2453 ( .A(\registers[42][6] ), .B(n2309), .C(n2163), .Y(n2165) );
  OAI22X1 U2454 ( .A(\registers[46][6] ), .B(n2324), .C(\registers[44][6] ), 
        .D(n2315), .Y(n2164) );
  NOR2X1 U2455 ( .A(n2165), .B(n2164), .Y(n2174) );
  OAI22X1 U2456 ( .A(\registers[59][6] ), .B(n2290), .C(\registers[57][6] ), 
        .D(n2326), .Y(n2167) );
  OAI22X1 U2457 ( .A(\registers[63][6] ), .B(n2301), .C(\registers[61][6] ), 
        .D(n2292), .Y(n2166) );
  NOR2X1 U2458 ( .A(n2167), .B(n2166), .Y(n2173) );
  NOR2X1 U2459 ( .A(\registers[56][6] ), .B(n2303), .Y(n2168) );
  NOR2X1 U2460 ( .A(n2332), .B(n2168), .Y(n2169) );
  OAI21X1 U2461 ( .A(\registers[58][6] ), .B(n2309), .C(n2169), .Y(n2171) );
  OAI22X1 U2462 ( .A(\registers[62][6] ), .B(n2324), .C(\registers[60][6] ), 
        .D(n2315), .Y(n2170) );
  NOR2X1 U2463 ( .A(n2171), .B(n2170), .Y(n2172) );
  AOI22X1 U2464 ( .A(n2175), .B(n2174), .C(n2173), .D(n2172), .Y(n2193) );
  OAI22X1 U2465 ( .A(\registers[11][6] ), .B(n2290), .C(\registers[9][6] ), 
        .D(n2326), .Y(n2177) );
  OAI22X1 U2466 ( .A(\registers[15][6] ), .B(n2301), .C(\registers[13][6] ), 
        .D(n2292), .Y(n2176) );
  NOR2X1 U2467 ( .A(n2177), .B(n2176), .Y(n2191) );
  NOR2X1 U2468 ( .A(\registers[8][6] ), .B(n2303), .Y(n2178) );
  NOR2X1 U2469 ( .A(n2280), .B(n2178), .Y(n2179) );
  OAI21X1 U2470 ( .A(\registers[10][6] ), .B(n2309), .C(n2179), .Y(n2181) );
  OAI22X1 U2471 ( .A(\registers[14][6] ), .B(n2324), .C(\registers[12][6] ), 
        .D(n2315), .Y(n2180) );
  NOR2X1 U2472 ( .A(n2181), .B(n2180), .Y(n2190) );
  OAI22X1 U2473 ( .A(\registers[27][6] ), .B(n2290), .C(\registers[25][6] ), 
        .D(n2326), .Y(n2183) );
  OAI22X1 U2474 ( .A(\registers[31][6] ), .B(n2301), .C(\registers[29][6] ), 
        .D(n2292), .Y(n2182) );
  NOR2X1 U2475 ( .A(n2183), .B(n2182), .Y(n2189) );
  NOR2X1 U2476 ( .A(\registers[24][6] ), .B(n2303), .Y(n2184) );
  NOR2X1 U2477 ( .A(n2282), .B(n2184), .Y(n2185) );
  OAI21X1 U2478 ( .A(\registers[26][6] ), .B(n2309), .C(n2185), .Y(n2187) );
  OAI22X1 U2479 ( .A(\registers[30][6] ), .B(n2324), .C(\registers[28][6] ), 
        .D(n2315), .Y(n2186) );
  NOR2X1 U2480 ( .A(n2187), .B(n2186), .Y(n2188) );
  AOI22X1 U2481 ( .A(n2191), .B(n2190), .C(n2189), .D(n2188), .Y(n2192) );
  AOI21X1 U2482 ( .A(n2193), .B(n2192), .C(n2283), .Y(n2194) );
  OAI22X1 U2483 ( .A(\registers[35][7] ), .B(n2290), .C(\registers[33][7] ), 
        .D(n2326), .Y(n2197) );
  OAI22X1 U2484 ( .A(\registers[39][7] ), .B(n2301), .C(\registers[37][7] ), 
        .D(n2292), .Y(n2196) );
  NOR2X1 U2485 ( .A(n2197), .B(n2196), .Y(n2211) );
  NOR2X1 U2486 ( .A(\registers[32][7] ), .B(n2303), .Y(n2198) );
  NOR2X1 U2487 ( .A(n2331), .B(n2198), .Y(n2199) );
  OAI21X1 U2488 ( .A(\registers[34][7] ), .B(n2309), .C(n2199), .Y(n2201) );
  OAI22X1 U2489 ( .A(\registers[38][7] ), .B(n2324), .C(\registers[36][7] ), 
        .D(n2315), .Y(n2200) );
  NOR2X1 U2490 ( .A(n2201), .B(n2200), .Y(n2210) );
  OAI22X1 U2491 ( .A(\registers[51][7] ), .B(n2290), .C(\registers[49][7] ), 
        .D(n2326), .Y(n2203) );
  OAI22X1 U2492 ( .A(\registers[55][7] ), .B(n2301), .C(\registers[53][7] ), 
        .D(n2292), .Y(n2202) );
  NOR2X1 U2493 ( .A(n2203), .B(n2202), .Y(n2209) );
  NOR2X1 U2494 ( .A(\registers[48][7] ), .B(n2303), .Y(n2204) );
  NOR2X1 U2495 ( .A(n2332), .B(n2204), .Y(n2205) );
  OAI21X1 U2496 ( .A(\registers[50][7] ), .B(n2309), .C(n2205), .Y(n2207) );
  OAI22X1 U2497 ( .A(\registers[54][7] ), .B(n2324), .C(\registers[52][7] ), 
        .D(n2315), .Y(n2206) );
  NOR2X1 U2498 ( .A(n2207), .B(n2206), .Y(n2208) );
  AOI22X1 U2499 ( .A(n2211), .B(n2210), .C(n2209), .D(n2208), .Y(n2229) );
  OAI22X1 U2500 ( .A(\registers[3][7] ), .B(n2290), .C(\registers[1][7] ), .D(
        n2326), .Y(n2213) );
  OAI22X1 U2501 ( .A(\registers[7][7] ), .B(n2301), .C(\registers[5][7] ), .D(
        n2292), .Y(n2212) );
  NOR2X1 U2502 ( .A(n2213), .B(n2212), .Y(n2227) );
  NOR2X1 U2503 ( .A(\registers[0][7] ), .B(n2303), .Y(n2214) );
  NOR2X1 U2504 ( .A(n2280), .B(n2214), .Y(n2215) );
  OAI21X1 U2505 ( .A(\registers[2][7] ), .B(n2309), .C(n2215), .Y(n2217) );
  OAI22X1 U2506 ( .A(\registers[6][7] ), .B(n2324), .C(\registers[4][7] ), .D(
        n2315), .Y(n2216) );
  NOR2X1 U2507 ( .A(n2217), .B(n2216), .Y(n2226) );
  OAI22X1 U2508 ( .A(\registers[19][7] ), .B(n2290), .C(\registers[17][7] ), 
        .D(n2326), .Y(n2219) );
  OAI22X1 U2509 ( .A(\registers[23][7] ), .B(n2301), .C(\registers[21][7] ), 
        .D(n2292), .Y(n2218) );
  NOR2X1 U2510 ( .A(n2219), .B(n2218), .Y(n2225) );
  NOR2X1 U2511 ( .A(\registers[16][7] ), .B(n2303), .Y(n2220) );
  NOR2X1 U2512 ( .A(n2282), .B(n2220), .Y(n2221) );
  OAI21X1 U2513 ( .A(\registers[18][7] ), .B(n2309), .C(n2221), .Y(n2223) );
  OAI22X1 U2514 ( .A(\registers[22][7] ), .B(n2324), .C(\registers[20][7] ), 
        .D(n2315), .Y(n2222) );
  NOR2X1 U2515 ( .A(n2223), .B(n2222), .Y(n2224) );
  AOI22X1 U2516 ( .A(n2227), .B(n2226), .C(n2225), .D(n2224), .Y(n2228) );
  AOI21X1 U2517 ( .A(n2229), .B(n2228), .C(N23), .Y(n2279) );
  OAI22X1 U2518 ( .A(\registers[45][7] ), .B(n2291), .C(\registers[43][7] ), 
        .D(n2290), .Y(n2231) );
  OAI21X1 U2519 ( .A(\registers[47][7] ), .B(n2301), .C(n534), .Y(n2230) );
  NOR2X1 U2520 ( .A(n2231), .B(n2230), .Y(n2247) );
  NOR2X1 U2521 ( .A(\registers[40][7] ), .B(n2302), .Y(n2233) );
  NOR2X1 U2522 ( .A(\registers[42][7] ), .B(n2308), .Y(n2232) );
  NOR2X1 U2523 ( .A(n2233), .B(n2232), .Y(n2234) );
  OAI21X1 U2524 ( .A(\registers[44][7] ), .B(n2314), .C(n2234), .Y(n2236) );
  OAI22X1 U2525 ( .A(\registers[41][7] ), .B(n2325), .C(\registers[46][7] ), 
        .D(n2324), .Y(n2235) );
  NOR2X1 U2526 ( .A(n2236), .B(n2235), .Y(n2246) );
  OAI22X1 U2527 ( .A(\registers[61][7] ), .B(n2291), .C(\registers[59][7] ), 
        .D(n2290), .Y(n2238) );
  OAI21X1 U2528 ( .A(\registers[63][7] ), .B(n2301), .C(n535), .Y(n2237) );
  NOR2X1 U2529 ( .A(n2238), .B(n2237), .Y(n2245) );
  NOR2X1 U2530 ( .A(\registers[56][7] ), .B(n2302), .Y(n2240) );
  NOR2X1 U2531 ( .A(\registers[58][7] ), .B(n2308), .Y(n2239) );
  NOR2X1 U2532 ( .A(n2240), .B(n2239), .Y(n2241) );
  OAI21X1 U2533 ( .A(\registers[60][7] ), .B(n2314), .C(n2241), .Y(n2243) );
  OAI22X1 U2534 ( .A(\registers[57][7] ), .B(n2325), .C(\registers[62][7] ), 
        .D(n2324), .Y(n2242) );
  NOR2X1 U2535 ( .A(n2243), .B(n2242), .Y(n2244) );
  AOI22X1 U2536 ( .A(n2247), .B(n2246), .C(n2245), .D(n2244), .Y(n2277) );
  OAI22X1 U2537 ( .A(\registers[13][7] ), .B(n2291), .C(\registers[11][7] ), 
        .D(n2290), .Y(n2250) );
  OAI21X1 U2538 ( .A(\registers[15][7] ), .B(n2301), .C(n2248), .Y(n2249) );
  NOR2X1 U2539 ( .A(n2250), .B(n2249), .Y(n2275) );
  NOR2X1 U2540 ( .A(\registers[8][7] ), .B(n2302), .Y(n2252) );
  NOR2X1 U2541 ( .A(\registers[10][7] ), .B(n2308), .Y(n2251) );
  NOR2X1 U2542 ( .A(n2252), .B(n2251), .Y(n2253) );
  OAI21X1 U2543 ( .A(\registers[12][7] ), .B(n2314), .C(n2253), .Y(n2255) );
  OAI22X1 U2544 ( .A(\registers[9][7] ), .B(n2325), .C(\registers[14][7] ), 
        .D(n2324), .Y(n2254) );
  NOR2X1 U2545 ( .A(n2255), .B(n2254), .Y(n2274) );
  OAI22X1 U2546 ( .A(\registers[29][7] ), .B(n2291), .C(\registers[27][7] ), 
        .D(n2290), .Y(n2261) );
  OAI21X1 U2547 ( .A(\registers[31][7] ), .B(n2301), .C(n2258), .Y(n2260) );
  NOR2X1 U2548 ( .A(n2261), .B(n2260), .Y(n2273) );
  NOR2X1 U2549 ( .A(\registers[24][7] ), .B(n2302), .Y(n2265) );
  NOR2X1 U2550 ( .A(\registers[26][7] ), .B(n2308), .Y(n2264) );
  NOR2X1 U2551 ( .A(n2265), .B(n2264), .Y(n2266) );
  OAI21X1 U2552 ( .A(\registers[28][7] ), .B(n2314), .C(n2266), .Y(n2271) );
  OAI22X1 U2553 ( .A(\registers[25][7] ), .B(n2325), .C(\registers[30][7] ), 
        .D(n2324), .Y(n2270) );
  NOR2X1 U2554 ( .A(n2271), .B(n2270), .Y(n2272) );
  AOI22X1 U2555 ( .A(n2275), .B(n2274), .C(n2273), .D(n2272), .Y(n2276) );
  AOI21X1 U2556 ( .A(n2277), .B(n2276), .C(n2283), .Y(n2278) );
  INVX2 U2557 ( .A(N24), .Y(n2281) );
  INVX2 U2558 ( .A(N23), .Y(n2283) );
  INVX2 U2559 ( .A(N21), .Y(n2284) );
  INVX2 U2560 ( .A(N20), .Y(n2285) );
  NOR2X1 U2561 ( .A(buffer_occupancy[1]), .B(buffer_occupancy[0]), .Y(n2457)
         );
  AOI21X1 U2562 ( .A(buffer_occupancy[0]), .B(buffer_occupancy[1]), .C(n2457), 
        .Y(n2456) );
  NAND2X1 U2563 ( .A(n2457), .B(n2464), .Y(n2458) );
  OAI21X1 U2564 ( .A(n2457), .B(n2464), .C(n2458), .Y(N47) );
  NOR2X1 U2565 ( .A(n2458), .B(buffer_occupancy[3]), .Y(n2460) );
  AOI21X1 U2566 ( .A(n2458), .B(buffer_occupancy[3]), .C(n2460), .Y(n2459) );
  NAND2X1 U2567 ( .A(n2460), .B(n2463), .Y(n2461) );
  OAI21X1 U2568 ( .A(n2460), .B(n2463), .C(n2461), .Y(N49) );
  XNOR2X1 U2569 ( .A(buffer_occupancy[5]), .B(n2461), .Y(N50) );
  NOR2X1 U2570 ( .A(buffer_occupancy[5]), .B(n2461), .Y(n2462) );
  XOR2X1 U2571 ( .A(buffer_occupancy[6]), .B(n2462), .Y(N51) );
  INVX2 U2572 ( .A(buffer_occupancy[4]), .Y(n2463) );
  INVX2 U2573 ( .A(buffer_occupancy[2]), .Y(n2464) );
  INVX2 U2574 ( .A(buffer_occupancy[0]), .Y(N45) );
  INVX2 U2575 ( .A(n2459), .Y(N48) );
  INVX2 U2576 ( .A(n2456), .Y(N46) );
  INVX2 U2577 ( .A(n1226), .Y(n2529) );
  INVX2 U2578 ( .A(store_rx_packet_data), .Y(n2531) );
  INVX2 U2579 ( .A(N44), .Y(n2533) );
  INVX2 U2580 ( .A(N43), .Y(n2534) );
  INVX2 U2581 ( .A(N42), .Y(n2535) );
  INVX2 U2582 ( .A(N41), .Y(n2536) );
  INVX2 U2583 ( .A(N40), .Y(n2537) );
  INVX2 U2584 ( .A(N39), .Y(n2538) );
  INVX2 U2585 ( .A(wpointer[0]), .Y(n2539) );
  INVX2 U2586 ( .A(wpointer[1]), .Y(n2540) );
  INVX2 U2587 ( .A(wpointer[2]), .Y(n2541) );
  INVX2 U2588 ( .A(wpointer[3]), .Y(n2542) );
  INVX2 U2589 ( .A(wpointer[4]), .Y(n2543) );
  INVX2 U2590 ( .A(wpointer[5]), .Y(n2544) );
endmodule


module tx_control_fsm ( clk, n_rst, next_byte, eop_done, tx_packet, 
        buffer_occupancy, send_eop, manual_load, initiate, packet_select, 
        tx_transfer_active, tx_error, get_tx_packet_data, enable_timer, 
        clear_timer );
  input [3:0] tx_packet;
  input [6:0] buffer_occupancy;
  output [1:0] packet_select;
  input clk, n_rst, next_byte, eop_done;
  output send_eop, manual_load, initiate, tx_transfer_active, tx_error,
         get_tx_packet_data, enable_timer, clear_timer;
  wire   n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41,
         n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55,
         n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69,
         n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n5, n6, n7, n8, n10,
         n12, n14, n16, n17, n19, n20, n21, n22, n23, n24, n25, n26, n27;
  wire   [3:0] state;

  DFFSR \state_reg[0]  ( .D(n79), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[0])
         );
  DFFSR \state_reg[1]  ( .D(n76), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[1])
         );
  DFFSR \state_reg[2]  ( .D(n77), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[2])
         );
  DFFSR \state_reg[3]  ( .D(n78), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[3])
         );
  AND2X2 U7 ( .A(n37), .B(n38), .Y(n36) );
  AND2X2 U8 ( .A(n38), .B(n52), .Y(n51) );
  AND2X2 U9 ( .A(state[1]), .B(n64), .Y(tx_error) );
  AND2X2 U10 ( .A(n75), .B(n65), .Y(n39) );
  AND2X2 U11 ( .A(n73), .B(n75), .Y(get_tx_packet_data) );
  NAND3X1 U35 ( .A(n28), .B(n20), .C(n10), .Y(tx_transfer_active) );
  OAI21X1 U36 ( .A(n5), .B(n19), .C(n31), .Y(n76) );
  OAI21X1 U37 ( .A(n32), .B(n33), .C(n5), .Y(n31) );
  OAI21X1 U38 ( .A(tx_packet[0]), .B(n34), .C(n35), .Y(n33) );
  OAI21X1 U39 ( .A(n7), .B(n19), .C(n36), .Y(n32) );
  OAI21X1 U40 ( .A(n12), .B(n39), .C(n23), .Y(n37) );
  OAI21X1 U41 ( .A(n5), .B(n21), .C(n40), .Y(n77) );
  OAI21X1 U42 ( .A(n41), .B(n42), .C(n5), .Y(n40) );
  OAI21X1 U43 ( .A(n23), .B(n28), .C(n6), .Y(n42) );
  OAI22X1 U44 ( .A(n21), .B(n7), .C(n44), .D(tx_packet[0]), .Y(n43) );
  NAND3X1 U45 ( .A(n46), .B(n47), .C(n48), .Y(n45) );
  NOR2X1 U46 ( .A(buffer_occupancy[0]), .B(n49), .Y(n48) );
  OR2X1 U47 ( .A(buffer_occupancy[2]), .B(buffer_occupancy[1]), .Y(n49) );
  NOR2X1 U48 ( .A(buffer_occupancy[6]), .B(buffer_occupancy[5]), .Y(n47) );
  NOR2X1 U49 ( .A(buffer_occupancy[4]), .B(buffer_occupancy[3]), .Y(n46) );
  NAND3X1 U50 ( .A(n50), .B(n16), .C(n51), .Y(n41) );
  OAI21X1 U51 ( .A(n5), .B(n22), .C(n53), .Y(n78) );
  OAI21X1 U52 ( .A(n54), .B(n55), .C(n5), .Y(n53) );
  OAI21X1 U53 ( .A(n7), .B(n22), .C(n50), .Y(n55) );
  OAI21X1 U54 ( .A(n5), .B(n14), .C(n56), .Y(n79) );
  OAI21X1 U55 ( .A(n57), .B(n58), .C(n5), .Y(n56) );
  OAI21X1 U56 ( .A(n44), .B(n27), .C(n35), .Y(n58) );
  AOI21X1 U57 ( .A(n24), .B(tx_error), .C(n59), .Y(n35) );
  NAND2X1 U58 ( .A(n29), .B(n52), .Y(n59) );
  OAI21X1 U59 ( .A(n7), .B(n14), .C(n60), .Y(n57) );
  NOR2X1 U60 ( .A(get_tx_packet_data), .B(manual_load), .Y(n60) );
  OAI22X1 U61 ( .A(n24), .B(n17), .C(n62), .D(n63), .Y(n61) );
  NAND2X1 U62 ( .A(n44), .B(n50), .Y(n63) );
  NAND3X1 U63 ( .A(n17), .B(n8), .C(n28), .Y(n62) );
  NAND2X1 U64 ( .A(n64), .B(n65), .Y(n28) );
  NAND3X1 U65 ( .A(n27), .B(n26), .C(n67), .Y(n66) );
  NOR2X1 U66 ( .A(tx_packet[3]), .B(tx_packet[2]), .Y(n67) );
  OAI21X1 U67 ( .A(eop_done), .B(n29), .C(n69), .Y(n68) );
  NOR2X1 U68 ( .A(n70), .B(n71), .Y(n69) );
  AOI21X1 U69 ( .A(n72), .B(n52), .C(next_byte), .Y(n71) );
  NOR2X1 U70 ( .A(n39), .B(packet_select[0]), .Y(n72) );
  AOI22X1 U71 ( .A(tx_packet[1]), .B(n25), .C(n44), .D(n34), .Y(n70) );
  AOI22X1 U72 ( .A(state[0]), .B(tx_error), .C(n64), .D(n73), .Y(n44) );
  NOR2X1 U73 ( .A(state[2]), .B(state[3]), .Y(n64) );
  NOR2X1 U74 ( .A(n20), .B(n17), .Y(manual_load) );
  NAND3X1 U75 ( .A(n52), .B(n38), .C(n10), .Y(enable_timer) );
  NAND3X1 U76 ( .A(n29), .B(n30), .C(n34), .Y(n54) );
  NAND3X1 U77 ( .A(state[1]), .B(state[0]), .C(n74), .Y(n34) );
  NOR2X1 U78 ( .A(get_tx_packet_data), .B(n39), .Y(n30) );
  NOR2X1 U79 ( .A(state[0]), .B(state[1]), .Y(n73) );
  NAND3X1 U80 ( .A(n75), .B(n14), .C(state[1]), .Y(n29) );
  NAND2X1 U81 ( .A(n74), .B(n65), .Y(n38) );
  NOR2X1 U82 ( .A(n14), .B(state[1]), .Y(n65) );
  NAND3X1 U83 ( .A(state[1]), .B(n14), .C(n74), .Y(n52) );
  NOR2X1 U84 ( .A(n21), .B(state[3]), .Y(n74) );
  NAND3X1 U85 ( .A(n75), .B(state[0]), .C(state[1]), .Y(n50) );
  NOR2X1 U86 ( .A(n22), .B(state[2]), .Y(n75) );
  INVX2 U12 ( .A(n68), .Y(n5) );
  INVX2 U13 ( .A(n43), .Y(n6) );
  INVX2 U14 ( .A(n61), .Y(n7) );
  INVX2 U15 ( .A(enable_timer), .Y(n8) );
  INVX2 U16 ( .A(n30), .Y(packet_select[1]) );
  INVX2 U17 ( .A(n54), .Y(n10) );
  INVX2 U18 ( .A(n38), .Y(initiate) );
  INVX2 U19 ( .A(n28), .Y(n12) );
  INVX2 U20 ( .A(n29), .Y(send_eop) );
  INVX2 U21 ( .A(state[0]), .Y(n14) );
  INVX2 U22 ( .A(n34), .Y(packet_select[0]) );
  INVX2 U23 ( .A(manual_load), .Y(n16) );
  INVX2 U24 ( .A(n73), .Y(n17) );
  INVX2 U25 ( .A(n50), .Y(clear_timer) );
  INVX2 U26 ( .A(state[1]), .Y(n19) );
  INVX2 U27 ( .A(n74), .Y(n20) );
  INVX2 U28 ( .A(state[2]), .Y(n21) );
  INVX2 U29 ( .A(state[3]), .Y(n22) );
  INVX2 U30 ( .A(n45), .Y(n23) );
  INVX2 U31 ( .A(n66), .Y(n24) );
  INVX2 U32 ( .A(tx_packet[2]), .Y(n25) );
  INVX2 U33 ( .A(tx_packet[1]), .Y(n26) );
  INVX2 U34 ( .A(tx_packet[0]), .Y(n27) );
endmodule


module flex_counter_tx ( clk, n_rst, clear, count_enable, rollover_val, 
        count_out, rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   N13, N14, N15, N16, N17, n25, n26, n27, n28, n29, n30, n31, n32, n33,
         n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47,
         n48, n49, n50, n51, n52, n53, n54, n1, n2, n3, n4, n5, n6, n7, n8, n9,
         n10, n16, n17, n18, n19;

  DFFSR \count_out_reg[0]  ( .D(n54), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \count_out_reg[3]  ( .D(n51), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR \count_out_reg[1]  ( .D(n53), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(n52), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR rollover_flag_reg ( .D(n50), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rollover_flag) );
  OAI21X1 U18 ( .A(n25), .B(n26), .C(n27), .Y(n50) );
  NAND2X1 U19 ( .A(rollover_flag), .B(n28), .Y(n27) );
  NAND3X1 U20 ( .A(n29), .B(n30), .C(n31), .Y(n26) );
  XNOR2X1 U21 ( .A(count_out[2]), .B(N15), .Y(n31) );
  XNOR2X1 U22 ( .A(count_out[3]), .B(N16), .Y(n30) );
  XNOR2X1 U23 ( .A(count_out[1]), .B(N14), .Y(n29) );
  NAND3X1 U24 ( .A(n32), .B(n33), .C(n34), .Y(n25) );
  NOR2X1 U25 ( .A(N17), .B(n6), .Y(n34) );
  XNOR2X1 U26 ( .A(count_out[0]), .B(N13), .Y(n32) );
  OAI22X1 U27 ( .A(n10), .B(n18), .C(n35), .D(n36), .Y(n51) );
  XNOR2X1 U28 ( .A(count_out[3]), .B(n37), .Y(n35) );
  NOR2X1 U29 ( .A(n17), .B(n8), .Y(n37) );
  OAI21X1 U30 ( .A(n38), .B(n17), .C(n39), .Y(n52) );
  NAND3X1 U31 ( .A(n40), .B(n17), .C(n7), .Y(n39) );
  AOI21X1 U32 ( .A(n7), .B(n8), .C(n28), .Y(n38) );
  NOR2X1 U33 ( .A(n16), .B(n9), .Y(n40) );
  OAI21X1 U34 ( .A(n41), .B(n16), .C(n42), .Y(n53) );
  NAND3X1 U35 ( .A(count_out[0]), .B(n16), .C(n7), .Y(n42) );
  AOI21X1 U36 ( .A(n7), .B(n9), .C(n28), .Y(n41) );
  NAND2X1 U37 ( .A(n33), .B(n43), .Y(n36) );
  OAI21X1 U38 ( .A(n9), .B(n18), .C(n44), .Y(n54) );
  OAI21X1 U39 ( .A(n6), .B(n9), .C(n33), .Y(n44) );
  NAND3X1 U40 ( .A(n45), .B(n46), .C(n47), .Y(n43) );
  NOR2X1 U41 ( .A(n48), .B(n49), .Y(n47) );
  XNOR2X1 U42 ( .A(rollover_val[0]), .B(n9), .Y(n49) );
  XNOR2X1 U43 ( .A(rollover_val[3]), .B(n10), .Y(n48) );
  XNOR2X1 U44 ( .A(count_out[2]), .B(rollover_val[2]), .Y(n46) );
  XNOR2X1 U45 ( .A(count_out[1]), .B(rollover_val[1]), .Y(n45) );
  NOR2X1 U46 ( .A(clear), .B(n33), .Y(n28) );
  NOR2X1 U47 ( .A(n19), .B(clear), .Y(n33) );
  NOR2X1 U8 ( .A(rollover_val[1]), .B(rollover_val[0]), .Y(n2) );
  AOI21X1 U9 ( .A(rollover_val[0]), .B(rollover_val[1]), .C(n2), .Y(n1) );
  NAND2X1 U10 ( .A(n2), .B(n5), .Y(n3) );
  OAI21X1 U11 ( .A(n2), .B(n5), .C(n3), .Y(N15) );
  NOR2X1 U12 ( .A(n3), .B(rollover_val[3]), .Y(N17) );
  AOI21X1 U13 ( .A(n3), .B(rollover_val[3]), .C(N17), .Y(n4) );
  INVX2 U14 ( .A(rollover_val[2]), .Y(n5) );
  INVX2 U15 ( .A(rollover_val[0]), .Y(N13) );
  INVX2 U16 ( .A(n1), .Y(N14) );
  INVX2 U17 ( .A(n4), .Y(N16) );
  INVX2 U48 ( .A(n43), .Y(n6) );
  INVX2 U49 ( .A(n36), .Y(n7) );
  INVX2 U50 ( .A(n40), .Y(n8) );
  INVX2 U51 ( .A(count_out[0]), .Y(n9) );
  INVX2 U52 ( .A(count_out[3]), .Y(n10) );
  INVX2 U53 ( .A(count_out[1]), .Y(n16) );
  INVX2 U54 ( .A(count_out[2]), .Y(n17) );
  INVX2 U55 ( .A(n28), .Y(n18) );
  INVX2 U56 ( .A(count_enable), .Y(n19) );
endmodule


module flex_counter_tx_7_DW01_inc_0 ( A, SUM );
  input [6:0] A;
  output [6:0] SUM;

  wire   [6:2] carry;

  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  INVX2 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[6]), .B(A[6]), .Y(SUM[6]) );
endmodule


module flex_counter_tx_7 ( clk, n_rst, clear, count_enable, rollover_val, 
        count_out, rollover_flag );
  input [6:0] rollover_val;
  output [6:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   N16, N17, N18, N19, N20, N21, N22, N23, N28, N29, N30, N31, N32, N33,
         N34, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41,
         n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55,
         n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69,
         n70, n71, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n19, n20, n21, n22,
         n23, n24, n25, n26, n27, n28, n72, n73;

  DFFSR \count_out_reg[0]  ( .D(n71), .CLK(clk), .R(n1), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \count_out_reg[1]  ( .D(n70), .CLK(clk), .R(n1), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(n69), .CLK(clk), .R(n1), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \count_out_reg[3]  ( .D(n68), .CLK(clk), .R(n1), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR \count_out_reg[4]  ( .D(n67), .CLK(clk), .R(n1), .S(1'b1), .Q(
        count_out[4]) );
  DFFSR \count_out_reg[5]  ( .D(n66), .CLK(clk), .R(n1), .S(1'b1), .Q(
        count_out[5]) );
  DFFSR \count_out_reg[6]  ( .D(n65), .CLK(clk), .R(n1), .S(1'b1), .Q(
        count_out[6]) );
  DFFSR rollover_flag_reg ( .D(n64), .CLK(clk), .R(n1), .S(1'b1), .Q(
        rollover_flag) );
  OAI21X1 U22 ( .A(n29), .B(n30), .C(n31), .Y(n64) );
  NAND2X1 U23 ( .A(rollover_flag), .B(n72), .Y(n31) );
  NAND3X1 U24 ( .A(n33), .B(n34), .C(n35), .Y(n30) );
  NOR2X1 U25 ( .A(n36), .B(n37), .Y(n35) );
  XNOR2X1 U26 ( .A(n22), .B(N17), .Y(n37) );
  XNOR2X1 U27 ( .A(n23), .B(N18), .Y(n36) );
  XNOR2X1 U28 ( .A(count_out[5]), .B(N21), .Y(n34) );
  NOR2X1 U29 ( .A(n38), .B(n39), .Y(n33) );
  XNOR2X1 U30 ( .A(n21), .B(N16), .Y(n39) );
  XNOR2X1 U31 ( .A(n27), .B(N22), .Y(n38) );
  NAND3X1 U32 ( .A(n40), .B(n28), .C(n41), .Y(n29) );
  NOR2X1 U33 ( .A(n42), .B(n43), .Y(n41) );
  XNOR2X1 U34 ( .A(n25), .B(N20), .Y(n43) );
  XNOR2X1 U35 ( .A(n24), .B(N19), .Y(n42) );
  NOR2X1 U36 ( .A(N23), .B(n44), .Y(n40) );
  OAI21X1 U37 ( .A(n27), .B(n32), .C(n45), .Y(n65) );
  NAND2X1 U38 ( .A(N34), .B(n46), .Y(n45) );
  OAI21X1 U39 ( .A(n26), .B(n32), .C(n47), .Y(n66) );
  NAND2X1 U40 ( .A(N33), .B(n46), .Y(n47) );
  OAI21X1 U41 ( .A(n25), .B(n32), .C(n48), .Y(n67) );
  NAND2X1 U42 ( .A(N32), .B(n46), .Y(n48) );
  OAI21X1 U43 ( .A(n24), .B(n32), .C(n49), .Y(n68) );
  NAND2X1 U44 ( .A(N31), .B(n46), .Y(n49) );
  OAI21X1 U45 ( .A(n23), .B(n32), .C(n50), .Y(n69) );
  NAND2X1 U46 ( .A(N30), .B(n46), .Y(n50) );
  OAI21X1 U47 ( .A(n22), .B(n32), .C(n51), .Y(n70) );
  NAND2X1 U48 ( .A(N29), .B(n46), .Y(n51) );
  OAI21X1 U49 ( .A(n21), .B(n32), .C(n52), .Y(n71) );
  AOI22X1 U50 ( .A(n44), .B(n28), .C(N28), .D(n46), .Y(n52) );
  NOR2X1 U51 ( .A(n53), .B(n44), .Y(n46) );
  NOR2X1 U52 ( .A(n54), .B(n55), .Y(n44) );
  NAND3X1 U53 ( .A(n56), .B(n57), .C(n58), .Y(n55) );
  XNOR2X1 U54 ( .A(count_out[6]), .B(rollover_val[6]), .Y(n58) );
  XNOR2X1 U55 ( .A(count_out[5]), .B(rollover_val[5]), .Y(n57) );
  XNOR2X1 U56 ( .A(count_out[1]), .B(rollover_val[1]), .Y(n56) );
  NAND3X1 U57 ( .A(n59), .B(n60), .C(n61), .Y(n54) );
  NOR2X1 U58 ( .A(n62), .B(n63), .Y(n61) );
  XNOR2X1 U59 ( .A(rollover_val[4]), .B(n25), .Y(n63) );
  XNOR2X1 U60 ( .A(rollover_val[3]), .B(n24), .Y(n62) );
  XNOR2X1 U61 ( .A(count_out[2]), .B(rollover_val[2]), .Y(n60) );
  XNOR2X1 U62 ( .A(count_out[0]), .B(rollover_val[0]), .Y(n59) );
  NAND2X1 U63 ( .A(n73), .B(n53), .Y(n32) );
  NAND2X1 U64 ( .A(count_enable), .B(n73), .Y(n53) );
  flex_counter_tx_7_DW01_inc_0 r306 ( .A(count_out), .SUM({N34, N33, N32, N31, 
        N30, N29, N28}) );
  INVX2 U9 ( .A(n2), .Y(n1) );
  INVX2 U12 ( .A(n_rst), .Y(n2) );
  NOR2X1 U13 ( .A(rollover_val[1]), .B(rollover_val[0]), .Y(n4) );
  AOI21X1 U14 ( .A(rollover_val[0]), .B(rollover_val[1]), .C(n4), .Y(n3) );
  NAND2X1 U15 ( .A(n4), .B(n19), .Y(n5) );
  OAI21X1 U16 ( .A(n4), .B(n19), .C(n5), .Y(N18) );
  NOR2X1 U17 ( .A(n5), .B(rollover_val[3]), .Y(n7) );
  AOI21X1 U18 ( .A(n5), .B(rollover_val[3]), .C(n7), .Y(n6) );
  NAND2X1 U19 ( .A(n7), .B(n10), .Y(n8) );
  OAI21X1 U20 ( .A(n7), .B(n10), .C(n8), .Y(N20) );
  XNOR2X1 U21 ( .A(rollover_val[5]), .B(n8), .Y(N21) );
  NOR3X1 U65 ( .A(rollover_val[5]), .B(rollover_val[6]), .C(n8), .Y(N23) );
  OAI21X1 U66 ( .A(rollover_val[5]), .B(n8), .C(rollover_val[6]), .Y(n9) );
  NAND2X1 U67 ( .A(n20), .B(n9), .Y(N22) );
  INVX2 U68 ( .A(rollover_val[4]), .Y(n10) );
  INVX2 U69 ( .A(rollover_val[2]), .Y(n19) );
  INVX2 U70 ( .A(rollover_val[0]), .Y(N16) );
  INVX2 U71 ( .A(n6), .Y(N19) );
  INVX2 U72 ( .A(n3), .Y(N17) );
  INVX2 U73 ( .A(N23), .Y(n20) );
  INVX2 U74 ( .A(count_out[0]), .Y(n21) );
  INVX2 U75 ( .A(count_out[1]), .Y(n22) );
  INVX2 U76 ( .A(count_out[2]), .Y(n23) );
  INVX2 U77 ( .A(count_out[3]), .Y(n24) );
  INVX2 U78 ( .A(count_out[4]), .Y(n25) );
  INVX2 U79 ( .A(count_out[5]), .Y(n26) );
  INVX2 U80 ( .A(count_out[6]), .Y(n27) );
  INVX2 U81 ( .A(n53), .Y(n28) );
  INVX2 U82 ( .A(n32), .Y(n72) );
  INVX2 U83 ( .A(clear), .Y(n73) );
endmodule


module tx_timer ( clk, n_rst, clear_timer, enable_timer, next_byte, 
        shift_enable, new_bit, load_enable );
  input clk, n_rst, clear_timer, enable_timer;
  output next_byte, shift_enable, new_bit, load_enable;
  wire   n4, n5, n6, n7, n8, n1, n2, n3;
  wire   [3:0] bit_cycle_count;
  wire   [6:0] byte_count_out;

  NOR2X1 U6 ( .A(n4), .B(n5), .Y(shift_enable) );
  NAND2X1 U7 ( .A(bit_cycle_count[2]), .B(bit_cycle_count[1]), .Y(n5) );
  NAND2X1 U8 ( .A(bit_cycle_count[0]), .B(n3), .Y(n4) );
  NOR2X1 U9 ( .A(n6), .B(n1), .Y(load_enable) );
  NOR2X1 U10 ( .A(byte_count_out[0]), .B(n6), .Y(next_byte) );
  OR2X1 U11 ( .A(n7), .B(n8), .Y(n6) );
  NAND3X1 U12 ( .A(byte_count_out[4]), .B(byte_count_out[3]), .C(
        byte_count_out[5]), .Y(n8) );
  NAND3X1 U13 ( .A(byte_count_out[1]), .B(n2), .C(byte_count_out[2]), .Y(n7)
         );
  flex_counter_tx bit_period_tracker ( .clk(clk), .n_rst(n_rst), .clear(
        clear_timer), .count_enable(enable_timer), .rollover_val({1'b1, 1'b0, 
        1'b0, 1'b0}), .count_out(bit_cycle_count), .rollover_flag(new_bit) );
  flex_counter_tx_7 byte_complete_tracker ( .clk(clk), .n_rst(n_rst), .clear(
        clear_timer), .count_enable(enable_timer), .rollover_val({1'b1, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .count_out(byte_count_out) );
  INVX2 U3 ( .A(byte_count_out[0]), .Y(n1) );
  INVX2 U4 ( .A(byte_count_out[6]), .Y(n2) );
  INVX2 U5 ( .A(bit_cycle_count[3]), .Y(n3) );
endmodule


module tx_encoder ( clk, n_rst, serial_out, new_bit, initiate, send_eop, 
        Dplus_out, Dminus_out, eop_done );
  input clk, n_rst, serial_out, new_bit, initiate, send_eop;
  output Dplus_out, Dminus_out, eop_done;
  wire   next_dp, n1, n2, n3, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42,
         n43, n4, n10, n11, n12, n13, n14, n15, n16, n17, n18;
  wire   [2:0] state;

  DFFSR \state_reg[0]  ( .D(n43), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[0])
         );
  DFFSR \state_reg[2]  ( .D(n41), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[2])
         );
  DFFSR \state_reg[1]  ( .D(n42), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[1])
         );
  DFFSR Dplus_out_reg ( .D(n40), .CLK(clk), .R(1'b1), .S(n_rst), .Q(Dplus_out)
         );
  DFFSR Dminus_out_reg ( .D(n39), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        Dminus_out) );
  NOR2X1 U3 ( .A(state[0]), .B(state[1]), .Y(n1) );
  XOR2X1 U4 ( .A(n18), .B(n1), .Y(n3) );
  OAI21X1 U5 ( .A(state[0]), .B(new_bit), .C(state[1]), .Y(n2) );
  OAI22X1 U6 ( .A(n4), .B(n3), .C(n16), .D(n2), .Y(next_dp) );
  OAI21X1 U22 ( .A(n4), .B(n19), .C(n20), .Y(n39) );
  NAND3X1 U23 ( .A(n11), .B(n21), .C(Dminus_out), .Y(n20) );
  AOI22X1 U24 ( .A(n15), .B(Dminus_out), .C(n23), .D(n21), .Y(n19) );
  XNOR2X1 U25 ( .A(Dminus_out), .B(n24), .Y(n23) );
  NAND3X1 U26 ( .A(n13), .B(n10), .C(n25), .Y(n24) );
  OAI21X1 U27 ( .A(n27), .B(n28), .C(n29), .Y(n40) );
  OAI21X1 U28 ( .A(n15), .B(n27), .C(next_dp), .Y(n29) );
  NAND2X1 U29 ( .A(Dplus_out), .B(n21), .Y(n28) );
  OAI21X1 U30 ( .A(n26), .B(n30), .C(n25), .Y(n27) );
  AOI22X1 U31 ( .A(new_bit), .B(n4), .C(n10), .D(n16), .Y(n30) );
  NOR2X1 U32 ( .A(initiate), .B(new_bit), .Y(n26) );
  OAI21X1 U33 ( .A(n15), .B(n31), .C(n22), .Y(n41) );
  NAND3X1 U34 ( .A(n25), .B(n12), .C(n4), .Y(n22) );
  AOI21X1 U35 ( .A(send_eop), .B(n25), .C(n4), .Y(n31) );
  XOR2X1 U36 ( .A(n17), .B(state[0]), .Y(n25) );
  OAI21X1 U37 ( .A(n32), .B(n17), .C(n33), .Y(n42) );
  NAND2X1 U38 ( .A(new_bit), .B(n34), .Y(n33) );
  OAI21X1 U39 ( .A(state[0]), .B(n35), .C(n36), .Y(n34) );
  OAI21X1 U40 ( .A(n32), .B(n14), .C(n37), .Y(n43) );
  NAND3X1 U41 ( .A(n4), .B(n14), .C(new_bit), .Y(n37) );
  AOI21X1 U42 ( .A(n35), .B(n36), .C(n12), .Y(n32) );
  NAND3X1 U43 ( .A(state[0]), .B(n17), .C(n4), .Y(n36) );
  NAND2X1 U44 ( .A(n4), .B(state[1]), .Y(n35) );
  NOR2X1 U45 ( .A(n12), .B(n38), .Y(eop_done) );
  NAND2X1 U46 ( .A(n15), .B(n4), .Y(n38) );
  NAND2X1 U47 ( .A(state[1]), .B(state[0]), .Y(n21) );
  BUFX2 U7 ( .A(state[2]), .Y(n4) );
  INVX2 U13 ( .A(serial_out), .Y(n10) );
  INVX2 U14 ( .A(n22), .Y(n11) );
  INVX2 U15 ( .A(new_bit), .Y(n12) );
  INVX2 U16 ( .A(n26), .Y(n13) );
  INVX2 U17 ( .A(state[0]), .Y(n14) );
  INVX2 U18 ( .A(n21), .Y(n15) );
  INVX2 U19 ( .A(n4), .Y(n16) );
  INVX2 U20 ( .A(state[1]), .Y(n17) );
  INVX2 U21 ( .A(Dplus_out), .Y(n18) );
endmodule


module flex_pts_sr_tx_NUM_BITS8_SHIFT_MSB0 ( clk, n_rst, shift_enable, 
        load_enable, parallel_in, serial_out );
  input [7:0] parallel_in;
  input clk, n_rst, shift_enable, load_enable;
  output serial_out;
  wire   n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31,
         n32, n33, n34, n35, n9, n10, n11, n12, n13, n14, n15, n16, n17, n36,
         n37, n38;
  wire   [7:1] state;

  DFFSR \state_reg[7]  ( .D(n29), .CLK(clk), .R(1'b1), .S(n10), .Q(state[7])
         );
  DFFSR \state_reg[6]  ( .D(n30), .CLK(clk), .R(1'b1), .S(n10), .Q(state[6])
         );
  DFFSR \state_reg[5]  ( .D(n31), .CLK(clk), .R(1'b1), .S(n10), .Q(state[5])
         );
  DFFSR \state_reg[4]  ( .D(n32), .CLK(clk), .R(1'b1), .S(n10), .Q(state[4])
         );
  DFFSR \state_reg[3]  ( .D(n33), .CLK(clk), .R(1'b1), .S(n10), .Q(state[3])
         );
  DFFSR \state_reg[2]  ( .D(n34), .CLK(clk), .R(1'b1), .S(n10), .Q(state[2])
         );
  DFFSR \state_reg[1]  ( .D(n35), .CLK(clk), .R(1'b1), .S(n10), .Q(state[1])
         );
  DFFSR \state_reg[0]  ( .D(n28), .CLK(clk), .R(1'b1), .S(n10), .Q(serial_out)
         );
  OAI21X1 U20 ( .A(n37), .B(n36), .C(n18), .Y(n28) );
  AOI22X1 U21 ( .A(parallel_in[0]), .B(n9), .C(state[1]), .D(n19), .Y(n18) );
  OAI21X1 U22 ( .A(n20), .B(n38), .C(n21), .Y(n29) );
  AOI21X1 U23 ( .A(state[7]), .B(n20), .C(n19), .Y(n21) );
  OAI21X1 U24 ( .A(n37), .B(n12), .C(n22), .Y(n30) );
  AOI22X1 U25 ( .A(parallel_in[6]), .B(n9), .C(state[7]), .D(n19), .Y(n22) );
  OAI21X1 U26 ( .A(n37), .B(n13), .C(n23), .Y(n31) );
  AOI22X1 U27 ( .A(parallel_in[5]), .B(n9), .C(state[6]), .D(n19), .Y(n23) );
  OAI21X1 U28 ( .A(n37), .B(n14), .C(n24), .Y(n32) );
  AOI22X1 U29 ( .A(parallel_in[4]), .B(n9), .C(state[5]), .D(n19), .Y(n24) );
  OAI21X1 U30 ( .A(n37), .B(n15), .C(n25), .Y(n33) );
  AOI22X1 U31 ( .A(parallel_in[3]), .B(n9), .C(state[4]), .D(n19), .Y(n25) );
  OAI21X1 U32 ( .A(n37), .B(n16), .C(n26), .Y(n34) );
  AOI22X1 U33 ( .A(parallel_in[2]), .B(n9), .C(state[3]), .D(n19), .Y(n26) );
  OAI21X1 U34 ( .A(n17), .B(n37), .C(n27), .Y(n35) );
  AOI22X1 U35 ( .A(parallel_in[1]), .B(n9), .C(state[2]), .D(n19), .Y(n27) );
  NOR2X1 U36 ( .A(n20), .B(n9), .Y(n19) );
  NOR2X1 U37 ( .A(n9), .B(shift_enable), .Y(n20) );
  INVX2 U11 ( .A(n11), .Y(n10) );
  INVX2 U12 ( .A(n_rst), .Y(n11) );
  BUFX2 U13 ( .A(load_enable), .Y(n9) );
  INVX2 U14 ( .A(state[6]), .Y(n12) );
  INVX2 U15 ( .A(state[5]), .Y(n13) );
  INVX2 U16 ( .A(state[4]), .Y(n14) );
  INVX2 U17 ( .A(state[3]), .Y(n15) );
  INVX2 U18 ( .A(state[2]), .Y(n16) );
  INVX2 U19 ( .A(state[1]), .Y(n17) );
  INVX2 U38 ( .A(serial_out), .Y(n36) );
  INVX2 U39 ( .A(n20), .Y(n37) );
  INVX2 U40 ( .A(parallel_in[7]), .Y(n38) );
endmodule


module tx_shift_register ( clk, n_rst, parallel_in, load_enable, shift_enable, 
        manual_load, serial_out );
  input [7:0] parallel_in;
  input clk, n_rst, load_enable, shift_enable, manual_load;
  output serial_out;
  wire   load;

  OR2X1 U1 ( .A(load_enable), .B(manual_load), .Y(load) );
  flex_pts_sr_tx_NUM_BITS8_SHIFT_MSB0 pts_shift_reg ( .clk(clk), .n_rst(n_rst), 
        .shift_enable(shift_enable), .load_enable(load), .parallel_in(
        parallel_in), .serial_out(serial_out) );
endmodule


module tx_pid_byte ( tx_packet, pid_byte );
  input [3:0] tx_packet;
  output [7:0] pid_byte;

  assign pid_byte[3] = tx_packet[3];
  assign pid_byte[2] = tx_packet[2];
  assign pid_byte[1] = tx_packet[1];
  assign pid_byte[0] = tx_packet[0];

  INVX2 U1 ( .A(tx_packet[3]), .Y(pid_byte[7]) );
  INVX2 U2 ( .A(tx_packet[2]), .Y(pid_byte[6]) );
  INVX2 U3 ( .A(tx_packet[1]), .Y(pid_byte[5]) );
  INVX2 U4 ( .A(tx_packet[0]), .Y(pid_byte[4]) );
endmodule


module tx_sync_byte ( sync_byte );
  output [7:0] sync_byte;

  assign sync_byte[7] = 1'b1;
  assign sync_byte[0] = 1'b0;
  assign sync_byte[1] = 1'b0;
  assign sync_byte[2] = 1'b0;
  assign sync_byte[3] = 1'b0;
  assign sync_byte[4] = 1'b0;
  assign sync_byte[5] = 1'b0;
  assign sync_byte[6] = 1'b0;

endmodule


module tx_mux ( sync_byte, pid_byte, tx_packet_data, packet_select, 
        parallel_in );
  input [7:0] sync_byte;
  input [7:0] pid_byte;
  input [7:0] tx_packet_data;
  input [1:0] packet_select;
  output [7:0] parallel_in;
  wire   n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n1, n2, n3, n4,
         n5, n6, n7, n8, n9;

  AND2X2 U1 ( .A(packet_select[1]), .B(n1), .Y(n13) );
  OAI21X1 U11 ( .A(n10), .B(n3), .C(n11), .Y(parallel_in[7]) );
  AOI22X1 U12 ( .A(sync_byte[7]), .B(n12), .C(tx_packet_data[7]), .D(n13), .Y(
        n11) );
  OAI21X1 U13 ( .A(n10), .B(n5), .C(n14), .Y(parallel_in[6]) );
  AOI22X1 U14 ( .A(sync_byte[6]), .B(n12), .C(tx_packet_data[6]), .D(n13), .Y(
        n14) );
  OAI21X1 U15 ( .A(n10), .B(n7), .C(n15), .Y(parallel_in[5]) );
  AOI22X1 U16 ( .A(sync_byte[5]), .B(n12), .C(tx_packet_data[5]), .D(n13), .Y(
        n15) );
  OAI21X1 U17 ( .A(n10), .B(n9), .C(n16), .Y(parallel_in[4]) );
  AOI22X1 U18 ( .A(sync_byte[4]), .B(n12), .C(tx_packet_data[4]), .D(n13), .Y(
        n16) );
  OAI21X1 U19 ( .A(n10), .B(n2), .C(n17), .Y(parallel_in[3]) );
  AOI22X1 U20 ( .A(sync_byte[3]), .B(n12), .C(tx_packet_data[3]), .D(n13), .Y(
        n17) );
  OAI21X1 U21 ( .A(n10), .B(n4), .C(n18), .Y(parallel_in[2]) );
  AOI22X1 U22 ( .A(sync_byte[2]), .B(n12), .C(tx_packet_data[2]), .D(n13), .Y(
        n18) );
  OAI21X1 U23 ( .A(n10), .B(n6), .C(n19), .Y(parallel_in[1]) );
  AOI22X1 U24 ( .A(sync_byte[1]), .B(n12), .C(tx_packet_data[1]), .D(n13), .Y(
        n19) );
  OAI21X1 U25 ( .A(n10), .B(n8), .C(n20), .Y(parallel_in[0]) );
  AOI22X1 U26 ( .A(sync_byte[0]), .B(n12), .C(tx_packet_data[0]), .D(n13), .Y(
        n20) );
  XNOR2X1 U27 ( .A(packet_select[0]), .B(packet_select[1]), .Y(n12) );
  OR2X1 U28 ( .A(n1), .B(packet_select[1]), .Y(n10) );
  INVX2 U2 ( .A(packet_select[0]), .Y(n1) );
  INVX2 U3 ( .A(pid_byte[3]), .Y(n2) );
  INVX2 U4 ( .A(pid_byte[7]), .Y(n3) );
  INVX2 U5 ( .A(pid_byte[2]), .Y(n4) );
  INVX2 U6 ( .A(pid_byte[6]), .Y(n5) );
  INVX2 U7 ( .A(pid_byte[1]), .Y(n6) );
  INVX2 U8 ( .A(pid_byte[5]), .Y(n7) );
  INVX2 U9 ( .A(pid_byte[0]), .Y(n8) );
  INVX2 U10 ( .A(pid_byte[4]), .Y(n9) );
endmodule


module usb_tx ( clk, n_rst, tx_packet, buffer_occupancy, tx_packet_data, 
        tx_transfer_active, tx_error, get_tx_packet_data, Dplus_out, 
        Dminus_out );
  input [3:0] tx_packet;
  input [6:0] buffer_occupancy;
  input [7:0] tx_packet_data;
  input clk, n_rst;
  output tx_transfer_active, tx_error, get_tx_packet_data, Dplus_out,
         Dminus_out;
  wire   next_byte, eop_done, send_eop, manual_load, initiate, enable_timer,
         clear_timer, shift_enable, new_bit, load_enable, serial_out;
  wire   [1:0] packet_select;
  wire   [7:0] parallel_in;
  wire   [7:0] pid_byte;
  wire   [7:0] sync_byte;

  tx_control_fsm TX_CONTROL_FSM ( .clk(clk), .n_rst(n_rst), .next_byte(
        next_byte), .eop_done(eop_done), .tx_packet(tx_packet), 
        .buffer_occupancy(buffer_occupancy), .send_eop(send_eop), 
        .manual_load(manual_load), .initiate(initiate), .packet_select(
        packet_select), .tx_transfer_active(tx_transfer_active), .tx_error(
        tx_error), .get_tx_packet_data(get_tx_packet_data), .enable_timer(
        enable_timer), .clear_timer(clear_timer) );
  tx_timer TX_TIMER ( .clk(clk), .n_rst(n_rst), .clear_timer(clear_timer), 
        .enable_timer(enable_timer), .next_byte(next_byte), .shift_enable(
        shift_enable), .new_bit(new_bit), .load_enable(load_enable) );
  tx_encoder TX_ENCODER ( .clk(clk), .n_rst(n_rst), .serial_out(serial_out), 
        .new_bit(new_bit), .initiate(initiate), .send_eop(send_eop), 
        .Dplus_out(Dplus_out), .Dminus_out(Dminus_out), .eop_done(eop_done) );
  tx_shift_register TX_SHIFT_REGISTER ( .clk(clk), .n_rst(n_rst), 
        .parallel_in(parallel_in), .load_enable(load_enable), .shift_enable(
        shift_enable), .manual_load(manual_load), .serial_out(serial_out) );
  tx_pid_byte TX_PID_BYTE ( .tx_packet(tx_packet), .pid_byte(pid_byte) );
  tx_sync_byte TX_SYNC_BYTE (  );
  tx_mux TX_MUX ( .sync_byte({1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), 
        .pid_byte(pid_byte), .tx_packet_data(tx_packet_data), .packet_select(
        packet_select), .parallel_in(parallel_in) );
endmodule


module rx_sync_high ( clk, n_rst, async_in, sync_out );
  input clk, n_rst, async_in;
  output sync_out;
  wire   temp;

  DFFSR temp_reg ( .D(async_in), .CLK(clk), .R(1'b1), .S(n_rst), .Q(temp) );
  DFFSR sync_out_reg ( .D(temp), .CLK(clk), .R(1'b1), .S(n_rst), .Q(sync_out)
         );
endmodule


module rx_sync_low ( clk, n_rst, async_in, sync_out );
  input clk, n_rst, async_in;
  output sync_out;
  wire   temp;

  DFFSR temp_reg ( .D(async_in), .CLK(clk), .R(n_rst), .S(1'b1), .Q(temp) );
  DFFSR sync_out_reg ( .D(temp), .CLK(clk), .R(n_rst), .S(1'b1), .Q(sync_out)
         );
endmodule


module rx_edge_detector ( clk, n_rst, dplus_sync, d_edge );
  input clk, n_rst, dplus_sync;
  output d_edge;
  wire   dplus_prev;

  DFFSR dplus_prev_reg ( .D(dplus_sync), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        dplus_prev) );
  XOR2X1 U4 ( .A(dplus_sync), .B(dplus_prev), .Y(d_edge) );
endmodule


module rx_decoder ( shift_en, clk, n_rst, dplus_sync, rcving, d_orig );
  input shift_en, clk, n_rst, dplus_sync, rcving;
  output d_orig;
  wire   d_in1, d_in2, n1, n2, n4, n5, n7, n8, n3, n6, n10, n12;

  DFFSR d_in1_reg ( .D(n10), .CLK(clk), .R(1'b1), .S(n_rst), .Q(d_in1) );
  DFFSR d_in2_reg ( .D(n6), .CLK(clk), .R(n_rst), .S(1'b1), .Q(d_in2) );
  AOI22X1 U3 ( .A(n2), .B(d_in2), .C(n12), .D(d_in1), .Y(n1) );
  AOI22X1 U5 ( .A(n2), .B(d_in1), .C(n12), .D(dplus_sync), .Y(n4) );
  NAND2X1 U7 ( .A(shift_en), .B(rcving), .Y(n2) );
  OAI22X1 U8 ( .A(n5), .B(n3), .C(shift_en), .D(n7), .Y(d_orig) );
  XNOR2X1 U9 ( .A(d_in1), .B(n8), .Y(n7) );
  XNOR2X1 U10 ( .A(dplus_sync), .B(n8), .Y(n5) );
  AOI22X1 U11 ( .A(n3), .B(d_in2), .C(shift_en), .D(d_in1), .Y(n8) );
  INVX2 U2 ( .A(shift_en), .Y(n3) );
  INVX2 U4 ( .A(n1), .Y(n6) );
  INVX2 U6 ( .A(n4), .Y(n10) );
  INVX2 U12 ( .A(n2), .Y(n12) );
endmodule


module rx_flex_counter_NUM_CNT_BITS4_1 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   N4, N5, N6, N7, N8, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31,
         n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45,
         n1, n2, n3, n4, n5, n6, n12, n13, n14, n15, n16, n17, n18, n19, n20;

  DFFSR rollover_flag_reg ( .D(n13), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rollover_flag) );
  DFFSR \count_out_reg[2]  ( .D(n43), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \count_out_reg[3]  ( .D(n42), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR \count_out_reg[0]  ( .D(n45), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \count_out_reg[1]  ( .D(n44), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  OAI22X1 U19 ( .A(n16), .B(n20), .C(n22), .D(n23), .Y(n42) );
  XNOR2X1 U20 ( .A(count_out[3]), .B(n24), .Y(n22) );
  NOR2X1 U21 ( .A(n15), .B(n17), .Y(n24) );
  OAI21X1 U22 ( .A(n25), .B(n15), .C(n26), .Y(n43) );
  NAND3X1 U23 ( .A(n27), .B(n15), .C(n6), .Y(n26) );
  AOI21X1 U24 ( .A(n6), .B(n17), .C(n28), .Y(n25) );
  NOR2X1 U25 ( .A(n19), .B(n18), .Y(n27) );
  OAI21X1 U26 ( .A(n29), .B(n19), .C(n30), .Y(n44) );
  NAND3X1 U27 ( .A(count_out[0]), .B(n19), .C(n6), .Y(n30) );
  AOI21X1 U28 ( .A(n6), .B(n18), .C(n28), .Y(n29) );
  OAI21X1 U29 ( .A(n14), .B(n12), .C(n31), .Y(n23) );
  OAI21X1 U30 ( .A(n18), .B(n20), .C(n32), .Y(n45) );
  OAI21X1 U31 ( .A(n33), .B(n18), .C(n31), .Y(n32) );
  NOR2X1 U32 ( .A(n14), .B(n12), .Y(n33) );
  AOI22X1 U33 ( .A(n31), .B(n14), .C(rollover_flag), .D(n28), .Y(n34) );
  NAND3X1 U34 ( .A(n36), .B(n37), .C(n38), .Y(n35) );
  NOR2X1 U35 ( .A(n39), .B(n40), .Y(n38) );
  XNOR2X1 U36 ( .A(n15), .B(N6), .Y(n40) );
  XNOR2X1 U37 ( .A(n19), .B(N5), .Y(n39) );
  XNOR2X1 U38 ( .A(count_out[3]), .B(N7), .Y(n37) );
  NOR2X1 U39 ( .A(N8), .B(n41), .Y(n36) );
  XNOR2X1 U40 ( .A(n18), .B(N4), .Y(n41) );
  NOR2X1 U41 ( .A(n28), .B(clear), .Y(n31) );
  NOR2X1 U42 ( .A(clear), .B(count_enable), .Y(n28) );
  NOR2X1 U7 ( .A(rollover_val[1]), .B(rollover_val[0]), .Y(n2) );
  AOI21X1 U9 ( .A(rollover_val[0]), .B(rollover_val[1]), .C(n2), .Y(n1) );
  NAND2X1 U10 ( .A(n2), .B(n5), .Y(n3) );
  OAI21X1 U11 ( .A(n2), .B(n5), .C(n3), .Y(N6) );
  NOR2X1 U12 ( .A(n3), .B(rollover_val[3]), .Y(N8) );
  AOI21X1 U13 ( .A(n3), .B(rollover_val[3]), .C(N8), .Y(n4) );
  INVX2 U14 ( .A(rollover_val[2]), .Y(n5) );
  INVX2 U15 ( .A(rollover_val[0]), .Y(N4) );
  INVX2 U16 ( .A(n1), .Y(N5) );
  INVX2 U17 ( .A(n4), .Y(N7) );
  INVX2 U18 ( .A(n23), .Y(n6) );
  INVX2 U43 ( .A(rollover_flag), .Y(n12) );
  INVX2 U44 ( .A(n34), .Y(n13) );
  INVX2 U45 ( .A(n35), .Y(n14) );
  INVX2 U46 ( .A(count_out[2]), .Y(n15) );
  INVX2 U47 ( .A(count_out[3]), .Y(n16) );
  INVX2 U48 ( .A(n27), .Y(n17) );
  INVX2 U49 ( .A(count_out[0]), .Y(n18) );
  INVX2 U50 ( .A(count_out[1]), .Y(n19) );
  INVX2 U51 ( .A(n28), .Y(n20) );
endmodule


module rx_flex_counter_NUM_CNT_BITS4_0 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   N4, N5, N6, N7, N8, n1, n2, n3, n4, n5, n6, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n45, n46, n47, n48, n49, n50, n51, n52, n53,
         n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67;

  DFFSR rollover_flag_reg ( .D(n13), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rollover_flag) );
  DFFSR \count_out_reg[2]  ( .D(n46), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \count_out_reg[3]  ( .D(n47), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR \count_out_reg[0]  ( .D(n21), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \count_out_reg[1]  ( .D(n45), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  OAI22X1 U19 ( .A(n16), .B(n20), .C(n67), .D(n66), .Y(n47) );
  XNOR2X1 U20 ( .A(count_out[3]), .B(n65), .Y(n67) );
  NOR2X1 U21 ( .A(n15), .B(n17), .Y(n65) );
  OAI21X1 U22 ( .A(n64), .B(n15), .C(n63), .Y(n46) );
  NAND3X1 U23 ( .A(n62), .B(n15), .C(n6), .Y(n63) );
  AOI21X1 U24 ( .A(n6), .B(n17), .C(n61), .Y(n64) );
  NOR2X1 U25 ( .A(n19), .B(n18), .Y(n62) );
  OAI21X1 U26 ( .A(n60), .B(n19), .C(n59), .Y(n45) );
  NAND3X1 U27 ( .A(count_out[0]), .B(n19), .C(n6), .Y(n59) );
  AOI21X1 U28 ( .A(n6), .B(n18), .C(n61), .Y(n60) );
  OAI21X1 U29 ( .A(n14), .B(n12), .C(n58), .Y(n66) );
  OAI21X1 U30 ( .A(n18), .B(n20), .C(n57), .Y(n21) );
  OAI21X1 U31 ( .A(n56), .B(n18), .C(n58), .Y(n57) );
  NOR2X1 U32 ( .A(n14), .B(n12), .Y(n56) );
  AOI22X1 U33 ( .A(n58), .B(n14), .C(rollover_flag), .D(n61), .Y(n55) );
  NAND3X1 U34 ( .A(n53), .B(n52), .C(n51), .Y(n54) );
  NOR2X1 U35 ( .A(n50), .B(n49), .Y(n51) );
  XNOR2X1 U36 ( .A(n15), .B(N6), .Y(n49) );
  XNOR2X1 U37 ( .A(n19), .B(N5), .Y(n50) );
  XNOR2X1 U38 ( .A(count_out[3]), .B(N7), .Y(n52) );
  NOR2X1 U39 ( .A(N8), .B(n48), .Y(n53) );
  XNOR2X1 U40 ( .A(n18), .B(N4), .Y(n48) );
  NOR2X1 U41 ( .A(n61), .B(clear), .Y(n58) );
  NOR2X1 U42 ( .A(clear), .B(count_enable), .Y(n61) );
  NOR2X1 U7 ( .A(rollover_val[1]), .B(rollover_val[0]), .Y(n2) );
  AOI21X1 U9 ( .A(rollover_val[0]), .B(rollover_val[1]), .C(n2), .Y(n1) );
  NAND2X1 U10 ( .A(n2), .B(n5), .Y(n3) );
  OAI21X1 U11 ( .A(n2), .B(n5), .C(n3), .Y(N6) );
  NOR2X1 U12 ( .A(n3), .B(rollover_val[3]), .Y(N8) );
  AOI21X1 U13 ( .A(n3), .B(rollover_val[3]), .C(N8), .Y(n4) );
  INVX2 U14 ( .A(rollover_val[2]), .Y(n5) );
  INVX2 U15 ( .A(rollover_val[0]), .Y(N4) );
  INVX2 U16 ( .A(n1), .Y(N5) );
  INVX2 U17 ( .A(n4), .Y(N7) );
  INVX2 U18 ( .A(n66), .Y(n6) );
  INVX2 U43 ( .A(rollover_flag), .Y(n12) );
  INVX2 U44 ( .A(n55), .Y(n13) );
  INVX2 U45 ( .A(n54), .Y(n14) );
  INVX2 U46 ( .A(count_out[2]), .Y(n15) );
  INVX2 U47 ( .A(count_out[3]), .Y(n16) );
  INVX2 U48 ( .A(n62), .Y(n17) );
  INVX2 U49 ( .A(count_out[0]), .Y(n18) );
  INVX2 U50 ( .A(count_out[1]), .Y(n19) );
  INVX2 U51 ( .A(n61), .Y(n20) );
endmodule


module rising_edge_detector ( clk, n_rst, dplus_sync, d_edge );
  input clk, n_rst, dplus_sync;
  output d_edge;
  wire   dplus_prev, n2;

  DFFSR dplus_prev_reg ( .D(dplus_sync), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        dplus_prev) );
  NOR2X1 U5 ( .A(dplus_prev), .B(n2), .Y(d_edge) );
  INVX2 U4 ( .A(dplus_sync), .Y(n2) );
endmodule


module rx_flex_counter_NUM_CNT_BITS7_DW01_inc_0 ( A, SUM );
  input [6:0] A;
  output [6:0] SUM;

  wire   [6:2] carry;

  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  INVX2 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[6]), .B(A[6]), .Y(SUM[6]) );
endmodule


module rx_flex_counter_NUM_CNT_BITS7 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [6:0] rollover_val;
  output [6:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   N4, N5, N6, N7, N8, N9, N10, N11, N15, N16, N17, N18, N19, N20, N21,
         n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39,
         n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53,
         n54, n55, n56, n1, n2, n3, n4, n5, n6, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n57, n58, n59, n60;

  DFFSR rollover_flag_reg ( .D(n56), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rollover_flag) );
  DFFSR \count_out_reg[0]  ( .D(n55), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \count_out_reg[1]  ( .D(n54), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(n53), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \count_out_reg[3]  ( .D(n52), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR \count_out_reg[4]  ( .D(n51), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[4]) );
  DFFSR \count_out_reg[5]  ( .D(n50), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[5]) );
  DFFSR \count_out_reg[6]  ( .D(n49), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[6]) );
  OAI21X1 U23 ( .A(n60), .B(n19), .C(n26), .Y(n49) );
  NAND2X1 U24 ( .A(N21), .B(n27), .Y(n26) );
  OAI21X1 U25 ( .A(n59), .B(n19), .C(n28), .Y(n50) );
  NAND2X1 U26 ( .A(N20), .B(n27), .Y(n28) );
  OAI21X1 U27 ( .A(n58), .B(n19), .C(n29), .Y(n51) );
  NAND2X1 U28 ( .A(N19), .B(n27), .Y(n29) );
  OAI21X1 U29 ( .A(n57), .B(n19), .C(n30), .Y(n52) );
  NAND2X1 U30 ( .A(N18), .B(n27), .Y(n30) );
  OAI21X1 U31 ( .A(n25), .B(n19), .C(n31), .Y(n53) );
  NAND2X1 U32 ( .A(N17), .B(n27), .Y(n31) );
  OAI21X1 U33 ( .A(n24), .B(n19), .C(n32), .Y(n54) );
  NAND2X1 U34 ( .A(N16), .B(n27), .Y(n32) );
  OAI21X1 U35 ( .A(n22), .B(n19), .C(n33), .Y(n55) );
  AOI22X1 U36 ( .A(n34), .B(n35), .C(N15), .D(n27), .Y(n33) );
  AOI21X1 U37 ( .A(n23), .B(rollover_flag), .C(n20), .Y(n27) );
  NOR2X1 U38 ( .A(n36), .B(n21), .Y(n34) );
  OAI22X1 U39 ( .A(n20), .B(n23), .C(n21), .D(n19), .Y(n56) );
  NOR2X1 U40 ( .A(n38), .B(n39), .Y(n36) );
  NAND3X1 U41 ( .A(n40), .B(n41), .C(n42), .Y(n39) );
  NOR2X1 U42 ( .A(n43), .B(n44), .Y(n42) );
  XOR2X1 U43 ( .A(count_out[5]), .B(N9), .Y(n44) );
  XOR2X1 U44 ( .A(count_out[0]), .B(N4), .Y(n43) );
  XOR2X1 U45 ( .A(n25), .B(N6), .Y(n41) );
  XOR2X1 U46 ( .A(n24), .B(N5), .Y(n40) );
  NAND3X1 U47 ( .A(n45), .B(n46), .C(n47), .Y(n38) );
  NOR2X1 U48 ( .A(N11), .B(n48), .Y(n47) );
  XOR2X1 U49 ( .A(count_out[3]), .B(N7), .Y(n48) );
  XOR2X1 U50 ( .A(n58), .B(N8), .Y(n46) );
  XOR2X1 U51 ( .A(n60), .B(N10), .Y(n45) );
  NOR2X1 U52 ( .A(n37), .B(clear), .Y(n35) );
  NOR2X1 U53 ( .A(clear), .B(count_enable), .Y(n37) );
  rx_flex_counter_NUM_CNT_BITS7_DW01_inc_0 r302 ( .A(count_out), .SUM({N21, 
        N20, N19, N18, N17, N16, N15}) );
  NOR2X1 U7 ( .A(rollover_val[1]), .B(rollover_val[0]), .Y(n2) );
  AOI21X1 U12 ( .A(rollover_val[0]), .B(rollover_val[1]), .C(n2), .Y(n1) );
  NAND2X1 U13 ( .A(n2), .B(n17), .Y(n3) );
  OAI21X1 U14 ( .A(n2), .B(n17), .C(n3), .Y(N6) );
  NOR2X1 U15 ( .A(n3), .B(rollover_val[3]), .Y(n5) );
  AOI21X1 U16 ( .A(n3), .B(rollover_val[3]), .C(n5), .Y(n4) );
  NAND2X1 U17 ( .A(n5), .B(n16), .Y(n6) );
  OAI21X1 U18 ( .A(n5), .B(n16), .C(n6), .Y(N8) );
  XNOR2X1 U19 ( .A(rollover_val[5]), .B(n6), .Y(N9) );
  NOR3X1 U20 ( .A(rollover_val[5]), .B(rollover_val[6]), .C(n6), .Y(N11) );
  OAI21X1 U21 ( .A(rollover_val[5]), .B(n6), .C(rollover_val[6]), .Y(n15) );
  NAND2X1 U22 ( .A(n18), .B(n15), .Y(N10) );
  INVX2 U54 ( .A(rollover_val[4]), .Y(n16) );
  INVX2 U55 ( .A(rollover_val[2]), .Y(n17) );
  INVX2 U56 ( .A(rollover_val[0]), .Y(N4) );
  INVX2 U57 ( .A(N11), .Y(n18) );
  INVX2 U58 ( .A(n4), .Y(N7) );
  INVX2 U59 ( .A(n1), .Y(N5) );
  INVX2 U60 ( .A(n37), .Y(n19) );
  INVX2 U61 ( .A(n35), .Y(n20) );
  INVX2 U62 ( .A(rollover_flag), .Y(n21) );
  INVX2 U63 ( .A(count_out[0]), .Y(n22) );
  INVX2 U64 ( .A(n36), .Y(n23) );
  INVX2 U65 ( .A(count_out[1]), .Y(n24) );
  INVX2 U66 ( .A(count_out[2]), .Y(n25) );
  INVX2 U67 ( .A(count_out[3]), .Y(n57) );
  INVX2 U68 ( .A(count_out[4]), .Y(n58) );
  INVX2 U69 ( .A(count_out[5]), .Y(n59) );
  INVX2 U70 ( .A(count_out[6]), .Y(n60) );
endmodule


module rx_timer ( clk, n_rst, receiving, shift_en, packet_received, 
        max_data_received, count_out_bit );
  output [3:0] count_out_bit;
  input clk, n_rst, receiving;
  output shift_en, packet_received, max_data_received;
  wire   rollover_flag, n3, n4, n1, n2, n6;
  wire   [3:0] count_out_10bit;

  NAND3X1 U5 ( .A(count_out_10bit[1]), .B(count_out_10bit[0]), .C(n4), .Y(n3)
         );
  NOR2X1 U6 ( .A(count_out_10bit[3]), .B(count_out_10bit[2]), .Y(n4) );
  rx_flex_counter_NUM_CNT_BITS4_1 ten_bit_count ( .clk(clk), .n_rst(n1), 
        .clear(n6), .count_enable(receiving), .rollover_val({1'b1, 1'b0, 1'b0, 
        1'b0}), .count_out(count_out_10bit) );
  rx_flex_counter_NUM_CNT_BITS4_0 nine_bit_count ( .clk(clk), .n_rst(n1), 
        .clear(n6), .count_enable(shift_en), .rollover_val({1'b1, 1'b0, 1'b0, 
        1'b0}), .count_out(count_out_bit), .rollover_flag(rollover_flag) );
  rising_edge_detector rise ( .clk(clk), .n_rst(n1), .dplus_sync(rollover_flag), .d_edge(packet_received) );
  rx_flex_counter_NUM_CNT_BITS7 six_four_byte_count ( .clk(clk), .n_rst(n1), 
        .clear(n6), .count_enable(packet_received), .rollover_val({1'b1, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b1, 1'b0}), .rollover_flag(max_data_received) );
  INVX2 U3 ( .A(n2), .Y(n1) );
  INVX2 U4 ( .A(n_rst), .Y(n2) );
  INVX2 U7 ( .A(n3), .Y(shift_en) );
  INVX2 U8 ( .A(receiving), .Y(n6) );
endmodule


module rx_flex_stp_sr_NUM_BITS8_SHIFT_MSB0 ( clk, n_rst, serial_in, 
        shift_enable, parallel_out );
  output [7:0] parallel_out;
  input clk, n_rst, serial_in, shift_enable;
  wire   n3, n10, n12, n14, n16, n18, n20, n22, n24, n26, n1, n2, n4, n5, n6,
         n7, n8, n9, n27, n28;

  DFFSR \parallel_out_reg[7]  ( .D(n26), .CLK(clk), .R(1'b1), .S(n1), .Q(
        parallel_out[7]) );
  DFFSR \parallel_out_reg[6]  ( .D(n24), .CLK(clk), .R(1'b1), .S(n1), .Q(
        parallel_out[6]) );
  DFFSR \parallel_out_reg[5]  ( .D(n22), .CLK(clk), .R(1'b1), .S(n1), .Q(
        parallel_out[5]) );
  DFFSR \parallel_out_reg[4]  ( .D(n20), .CLK(clk), .R(1'b1), .S(n1), .Q(
        parallel_out[4]) );
  DFFSR \parallel_out_reg[3]  ( .D(n18), .CLK(clk), .R(1'b1), .S(n1), .Q(
        parallel_out[3]) );
  DFFSR \parallel_out_reg[2]  ( .D(n16), .CLK(clk), .R(1'b1), .S(n1), .Q(
        parallel_out[2]) );
  DFFSR \parallel_out_reg[1]  ( .D(n14), .CLK(clk), .R(1'b1), .S(n1), .Q(
        parallel_out[1]) );
  DFFSR \parallel_out_reg[0]  ( .D(n12), .CLK(clk), .R(1'b1), .S(n1), .Q(
        parallel_out[0]) );
  OAI21X1 U2 ( .A(n28), .B(n4), .C(n3), .Y(n12) );
  NAND2X1 U3 ( .A(parallel_out[0]), .B(n4), .Y(n3) );
  OAI22X1 U4 ( .A(n4), .B(n27), .C(shift_enable), .D(n28), .Y(n14) );
  OAI22X1 U6 ( .A(n4), .B(n9), .C(shift_enable), .D(n27), .Y(n16) );
  OAI22X1 U8 ( .A(n4), .B(n8), .C(shift_enable), .D(n9), .Y(n18) );
  OAI22X1 U10 ( .A(n4), .B(n7), .C(shift_enable), .D(n8), .Y(n20) );
  OAI22X1 U12 ( .A(n4), .B(n6), .C(shift_enable), .D(n7), .Y(n22) );
  OAI22X1 U14 ( .A(n4), .B(n5), .C(shift_enable), .D(n6), .Y(n24) );
  OAI21X1 U17 ( .A(shift_enable), .B(n5), .C(n10), .Y(n26) );
  NAND2X1 U18 ( .A(serial_in), .B(shift_enable), .Y(n10) );
  INVX2 U5 ( .A(n2), .Y(n1) );
  INVX2 U7 ( .A(n_rst), .Y(n2) );
  INVX2 U9 ( .A(shift_enable), .Y(n4) );
  INVX2 U11 ( .A(parallel_out[7]), .Y(n5) );
  INVX2 U13 ( .A(parallel_out[6]), .Y(n6) );
  INVX2 U15 ( .A(parallel_out[5]), .Y(n7) );
  INVX2 U16 ( .A(parallel_out[4]), .Y(n8) );
  INVX2 U19 ( .A(parallel_out[3]), .Y(n9) );
  INVX2 U28 ( .A(parallel_out[2]), .Y(n27) );
  INVX2 U29 ( .A(parallel_out[1]), .Y(n28) );
endmodule


module rx_eop_detector ( clk, n_rst, dplus_sync, dminus_sync, receiving, eop
 );
  input clk, n_rst, dplus_sync, dminus_sync, receiving;
  output eop;
  wire   N2, n1;
  assign eop = N2;

  AND2X2 U1 ( .A(n1), .B(receiving), .Y(N2) );
  XNOR2X1 U2 ( .A(dplus_sync), .B(dminus_sync), .Y(n1) );
endmodule


module rx_rcu ( clk, n_rst, eop, byte_received, d_edge, max_bytes_received, 
        rcv_data, buffer_occupancy, count_bytes, flush, store_rx_packet_data, 
        rx_data_ready, rx_transfer_active, rx_error, rx_packet_data, rx_packet, 
        clear_byte_received );
  input [7:0] rcv_data;
  input [6:0] buffer_occupancy;
  input [3:0] count_bytes;
  output [7:0] rx_packet_data;
  output [3:0] rx_packet;
  input clk, n_rst, eop, byte_received, d_edge, max_bytes_received;
  output flush, store_rx_packet_data, rx_data_ready, rx_transfer_active,
         rx_error, clear_byte_received;
  wire   err_flag, next_err_flag, n1, n2, n3, n4, n5, n52, n53, n54, n55, n56,
         n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70,
         n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84,
         n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98,
         n99, n100, n101, n102, n103, n104, n105, n106, n107, n108, n109, n110,
         n111, n112, n113, n114, n115, n116, n117, n118, n119, n120, n121,
         n122, n123, n124, n125, n126, n127, n128, n129, n130, n131, n132,
         n133, n134, n135, n136, n137, n138, n139, n140, n6, n7, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n30, n31,
         n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45,
         n46, n47, n48, n49, n50, n51;
  wire   [4:0] state;
  wire   [4:0] next_state;

  DFFSR \state_reg[0]  ( .D(next_state[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[0]) );
  DFFSR \state_reg[1]  ( .D(next_state[1]), .CLK(clk), .R(1'b1), .S(n_rst), 
        .Q(state[1]) );
  DFFSR \state_reg[3]  ( .D(next_state[3]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[3]) );
  DFFSR \state_reg[4]  ( .D(next_state[4]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[4]) );
  DFFSR \state_reg[2]  ( .D(next_state[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[2]) );
  DFFSR err_flag_reg ( .D(next_err_flag), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        err_flag) );
  NAND2X1 U3 ( .A(state[0]), .B(n37), .Y(n5) );
  NOR2X1 U4 ( .A(state[2]), .B(state[3]), .Y(n1) );
  NAND2X1 U5 ( .A(state[4]), .B(n1), .Y(n4) );
  OAI21X1 U6 ( .A(state[1]), .B(state[0]), .C(n1), .Y(n2) );
  OAI21X1 U7 ( .A(n32), .B(state[4]), .C(err_flag), .Y(n3) );
  OAI21X1 U8 ( .A(n5), .B(n4), .C(n3), .Y(rx_error) );
  NAND3X1 U55 ( .A(n52), .B(n53), .C(n6), .Y(rx_transfer_active) );
  OAI21X1 U56 ( .A(state[0]), .B(n55), .C(n41), .Y(n52) );
  NAND2X1 U57 ( .A(n42), .B(n39), .Y(n55) );
  NOR2X1 U58 ( .A(n6), .B(n51), .Y(rx_packet_data[7]) );
  NOR2X1 U59 ( .A(n6), .B(n50), .Y(rx_packet_data[6]) );
  NOR2X1 U60 ( .A(n6), .B(n49), .Y(rx_packet_data[5]) );
  NOR2X1 U61 ( .A(n6), .B(n48), .Y(rx_packet_data[4]) );
  NOR2X1 U62 ( .A(n6), .B(n47), .Y(rx_packet_data[3]) );
  NOR2X1 U63 ( .A(n6), .B(n46), .Y(rx_packet_data[2]) );
  NOR2X1 U64 ( .A(n6), .B(n45), .Y(rx_packet_data[1]) );
  NOR2X1 U65 ( .A(n6), .B(n44), .Y(rx_packet_data[0]) );
  NOR2X1 U66 ( .A(n28), .B(store_rx_packet_data), .Y(n54) );
  OR2X1 U67 ( .A(n23), .B(rx_data_ready), .Y(store_rx_packet_data) );
  NOR2X1 U68 ( .A(n56), .B(n47), .Y(rx_packet[3]) );
  NOR2X1 U69 ( .A(n56), .B(n46), .Y(rx_packet[2]) );
  NOR2X1 U70 ( .A(n56), .B(n45), .Y(rx_packet[1]) );
  NOR2X1 U71 ( .A(n56), .B(n44), .Y(rx_packet[0]) );
  NOR2X1 U72 ( .A(n25), .B(n35), .Y(n56) );
  OAI21X1 U73 ( .A(n15), .B(n7), .C(n57), .Y(next_err_flag) );
  OAI21X1 U74 ( .A(n58), .B(n59), .C(err_flag), .Y(n57) );
  NAND2X1 U75 ( .A(next_state[0]), .B(next_state[1]), .Y(n59) );
  OR2X1 U76 ( .A(n60), .B(n61), .Y(next_state[1]) );
  OAI21X1 U77 ( .A(byte_received), .B(n22), .C(n17), .Y(n61) );
  OAI21X1 U78 ( .A(n63), .B(n41), .C(n64), .Y(n60) );
  AOI21X1 U79 ( .A(byte_received), .B(n65), .C(n30), .Y(n64) );
  OAI21X1 U80 ( .A(eop), .B(n67), .C(n68), .Y(n65) );
  AOI21X1 U81 ( .A(d_edge), .B(n31), .C(n69), .Y(n63) );
  OR2X1 U82 ( .A(next_state[2]), .B(next_state[3]), .Y(n58) );
  NAND3X1 U83 ( .A(n70), .B(n33), .C(n20), .Y(next_state[3]) );
  OAI21X1 U84 ( .A(n72), .B(n44), .C(n73), .Y(n71) );
  NAND2X1 U85 ( .A(n75), .B(n17), .Y(next_state[2]) );
  OAI21X1 U86 ( .A(n72), .B(n77), .C(n70), .Y(n76) );
  NOR2X1 U87 ( .A(n78), .B(n79), .Y(n70) );
  OAI22X1 U88 ( .A(n19), .B(n80), .C(n81), .D(eop), .Y(n78) );
  NAND3X1 U89 ( .A(n21), .B(n46), .C(n25), .Y(n72) );
  AOI22X1 U90 ( .A(n82), .B(n21), .C(byte_received), .D(n62), .Y(n75) );
  OAI21X1 U91 ( .A(eop), .B(n83), .C(n84), .Y(n62) );
  OAI21X1 U92 ( .A(n85), .B(n86), .C(n67), .Y(n82) );
  NAND2X1 U93 ( .A(n87), .B(n88), .Y(next_state[0]) );
  NOR2X1 U94 ( .A(n89), .B(n90), .Y(n88) );
  OAI21X1 U95 ( .A(byte_received), .B(n91), .C(n92), .Y(n90) );
  OAI21X1 U96 ( .A(n43), .B(n45), .C(n25), .Y(n92) );
  NAND2X1 U97 ( .A(rcv_data[1]), .B(n44), .Y(n77) );
  NOR2X1 U98 ( .A(n93), .B(n74), .Y(n91) );
  NAND2X1 U99 ( .A(n68), .B(n84), .Y(n74) );
  NAND3X1 U100 ( .A(n36), .B(n42), .C(state[3]), .Y(n84) );
  NAND3X1 U101 ( .A(state[0]), .B(n37), .C(n40), .Y(n68) );
  OAI21X1 U102 ( .A(n66), .B(n94), .C(n95), .Y(n89) );
  NOR2X1 U103 ( .A(n23), .B(n24), .Y(n95) );
  NAND2X1 U104 ( .A(d_edge), .B(n41), .Y(n94) );
  NAND3X1 U105 ( .A(n31), .B(n42), .C(state[1]), .Y(n66) );
  NOR2X1 U106 ( .A(n96), .B(n14), .Y(n87) );
  AOI21X1 U107 ( .A(byte_received), .B(n26), .C(n98), .Y(n97) );
  OAI21X1 U108 ( .A(n99), .B(n100), .C(n101), .Y(n96) );
  OAI21X1 U109 ( .A(n102), .B(n103), .C(n21), .Y(n101) );
  NAND2X1 U110 ( .A(n104), .B(n53), .Y(n103) );
  NAND3X1 U111 ( .A(n105), .B(n16), .C(n106), .Y(next_state[4]) );
  AOI21X1 U112 ( .A(state[4]), .B(n107), .C(n108), .Y(n106) );
  OAI21X1 U113 ( .A(n109), .B(n110), .C(n111), .Y(n108) );
  OAI21X1 U114 ( .A(n112), .B(n113), .C(eop), .Y(n111) );
  NAND2X1 U115 ( .A(n85), .B(n53), .Y(n113) );
  OR2X1 U116 ( .A(n28), .B(rx_data_ready), .Y(n112) );
  NAND2X1 U117 ( .A(n104), .B(n114), .Y(rx_data_ready) );
  NAND2X1 U118 ( .A(n44), .B(n45), .Y(n110) );
  OAI21X1 U119 ( .A(d_edge), .B(n69), .C(n53), .Y(n107) );
  NAND2X1 U120 ( .A(n38), .B(state[0]), .Y(n53) );
  OAI21X1 U121 ( .A(n115), .B(n99), .C(n116), .Y(n102) );
  AOI21X1 U122 ( .A(n117), .B(n118), .C(n35), .Y(n116) );
  NAND3X1 U123 ( .A(n36), .B(n39), .C(state[2]), .Y(n119) );
  NOR2X1 U124 ( .A(n31), .B(n120), .Y(n118) );
  NAND2X1 U125 ( .A(n37), .B(n41), .Y(n120) );
  NOR2X1 U126 ( .A(n42), .B(n39), .Y(n117) );
  AOI22X1 U127 ( .A(max_bytes_received), .B(byte_received), .C(d_edge), .D(
        max_bytes_received), .Y(n115) );
  AOI21X1 U128 ( .A(n24), .B(n86), .C(n98), .Y(n105) );
  NAND3X1 U129 ( .A(n121), .B(n122), .C(n123), .Y(n98) );
  AOI22X1 U130 ( .A(n25), .B(rcv_data[2]), .C(n26), .D(n19), .Y(n123) );
  NAND3X1 U131 ( .A(state[3]), .B(state[1]), .C(n27), .Y(n80) );
  OAI21X1 U132 ( .A(n93), .B(n125), .C(eop), .Y(n122) );
  NAND2X1 U133 ( .A(n81), .B(n109), .Y(n125) );
  NAND2X1 U134 ( .A(n83), .B(n67), .Y(n93) );
  NAND3X1 U135 ( .A(n126), .B(state[2]), .C(n127), .Y(n67) );
  NOR2X1 U136 ( .A(state[4]), .B(n31), .Y(n127) );
  NAND3X1 U137 ( .A(n42), .B(n39), .C(n36), .Y(n83) );
  NAND3X1 U138 ( .A(n28), .B(n128), .C(eop), .Y(n121) );
  NAND3X1 U139 ( .A(count_bytes[3]), .B(n18), .C(n129), .Y(n128) );
  NOR2X1 U140 ( .A(count_bytes[2]), .B(count_bytes[1]), .Y(n129) );
  NAND3X1 U141 ( .A(n31), .B(n37), .C(n40), .Y(n81) );
  NAND3X1 U142 ( .A(n73), .B(n104), .C(n130), .Y(clear_byte_received) );
  AOI21X1 U143 ( .A(n131), .B(n21), .C(n79), .Y(n130) );
  OAI21X1 U144 ( .A(n99), .B(n100), .C(n132), .Y(n79) );
  NAND3X1 U145 ( .A(n34), .B(d_edge), .C(n124), .Y(n132) );
  NAND2X1 U146 ( .A(n124), .B(byte_received), .Y(n100) );
  NOR2X1 U147 ( .A(eop), .B(max_bytes_received), .Y(n124) );
  NAND3X1 U148 ( .A(n31), .B(n41), .C(n38), .Y(n99) );
  NAND2X1 U149 ( .A(n126), .B(n42), .Y(n69) );
  OAI21X1 U150 ( .A(n85), .B(n86), .C(n133), .Y(n131) );
  NOR2X1 U151 ( .A(n34), .B(n25), .Y(n133) );
  NAND3X1 U152 ( .A(state[1]), .B(n39), .C(n27), .Y(n109) );
  NAND3X1 U153 ( .A(state[2]), .B(n36), .C(state[3]), .Y(n114) );
  NAND3X1 U154 ( .A(state[0]), .B(n41), .C(state[1]), .Y(n134) );
  OR2X1 U155 ( .A(n135), .B(n136), .Y(n86) );
  NAND3X1 U156 ( .A(rcv_data[7]), .B(n44), .C(n137), .Y(n136) );
  NOR2X1 U157 ( .A(rcv_data[2]), .B(rcv_data[1]), .Y(n137) );
  NAND3X1 U158 ( .A(n47), .B(n48), .C(n138), .Y(n135) );
  NOR2X1 U159 ( .A(rcv_data[6]), .B(rcv_data[5]), .Y(n138) );
  NAND2X1 U160 ( .A(n126), .B(n27), .Y(n85) );
  NOR2X1 U161 ( .A(state[3]), .B(state[1]), .Y(n126) );
  NAND3X1 U162 ( .A(state[3]), .B(n37), .C(n27), .Y(n104) );
  NAND3X1 U163 ( .A(n31), .B(n41), .C(state[2]), .Y(n139) );
  NAND3X1 U164 ( .A(state[1]), .B(n31), .C(n40), .Y(n73) );
  NAND3X1 U165 ( .A(n42), .B(n41), .C(state[3]), .Y(n140) );
  BUFX2 U9 ( .A(n54), .Y(n6) );
  INVX2 U10 ( .A(next_state[0]), .Y(n7) );
  INVX2 U17 ( .A(n97), .Y(n14) );
  INVX2 U18 ( .A(next_state[4]), .Y(n15) );
  INVX2 U19 ( .A(n102), .Y(n16) );
  INVX2 U20 ( .A(n76), .Y(n17) );
  INVX2 U21 ( .A(count_bytes[0]), .Y(n18) );
  INVX2 U22 ( .A(n124), .Y(n19) );
  INVX2 U23 ( .A(n71), .Y(n20) );
  INVX2 U24 ( .A(eop), .Y(n21) );
  INVX2 U25 ( .A(n62), .Y(n22) );
  INVX2 U26 ( .A(n73), .Y(n23) );
  INVX2 U27 ( .A(n85), .Y(n24) );
  INVX2 U28 ( .A(n109), .Y(n25) );
  INVX2 U29 ( .A(n80), .Y(n26) );
  INVX2 U30 ( .A(n139), .Y(n27) );
  INVX2 U31 ( .A(n99), .Y(n28) );
  INVX2 U32 ( .A(n81), .Y(flush) );
  INVX2 U33 ( .A(n66), .Y(n30) );
  INVX2 U34 ( .A(state[0]), .Y(n31) );
  INVX2 U35 ( .A(n2), .Y(n32) );
  INVX2 U36 ( .A(n74), .Y(n33) );
  INVX2 U37 ( .A(n114), .Y(n34) );
  INVX2 U38 ( .A(n119), .Y(n35) );
  INVX2 U39 ( .A(n134), .Y(n36) );
  INVX2 U40 ( .A(state[1]), .Y(n37) );
  INVX2 U41 ( .A(n69), .Y(n38) );
  INVX2 U42 ( .A(state[3]), .Y(n39) );
  INVX2 U43 ( .A(n140), .Y(n40) );
  INVX2 U44 ( .A(state[4]), .Y(n41) );
  INVX2 U45 ( .A(state[2]), .Y(n42) );
  INVX2 U46 ( .A(n77), .Y(n43) );
  INVX2 U47 ( .A(rcv_data[0]), .Y(n44) );
  INVX2 U48 ( .A(rcv_data[1]), .Y(n45) );
  INVX2 U49 ( .A(rcv_data[2]), .Y(n46) );
  INVX2 U50 ( .A(rcv_data[3]), .Y(n47) );
  INVX2 U51 ( .A(rcv_data[4]), .Y(n48) );
  INVX2 U52 ( .A(rcv_data[5]), .Y(n49) );
  INVX2 U53 ( .A(rcv_data[6]), .Y(n50) );
  INVX2 U54 ( .A(rcv_data[7]), .Y(n51) );
endmodule


module usb_rx ( clk, n_rst, dplus_in, dminus_in, buffer_occupancy, 
        rx_transfer_active, rx_error, flush, store_rx_packet_data, 
        rx_data_ready, rx_packet, rx_packet_data );
  input [6:0] buffer_occupancy;
  output [3:0] rx_packet;
  output [7:0] rx_packet_data;
  input clk, n_rst, dplus_in, dminus_in;
  output rx_transfer_active, rx_error, flush, store_rx_packet_data,
         rx_data_ready;
  wire   dplus_sync, dminus_sync, d_edge, shift_en, d_orig, byte_received,
         max_data_bytes_received, eop, n1, n3, n4, n5, n6, n7, n8, n9, n2, n11,
         n13, n15, n17, n19, n21, n23, n25, n26;
  wire   [3:0] count_bytes;
  wire   [7:0] temp_hold;
  wire   [7:0] rcv_fifo;

  DFFSR \rcv_fifo_reg[0]  ( .D(n26), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rcv_fifo[0]) );
  DFFSR \rcv_fifo_reg[1]  ( .D(n25), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rcv_fifo[1]) );
  DFFSR \rcv_fifo_reg[2]  ( .D(n23), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rcv_fifo[2]) );
  DFFSR \rcv_fifo_reg[3]  ( .D(n21), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rcv_fifo[3]) );
  DFFSR \rcv_fifo_reg[4]  ( .D(n19), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rcv_fifo[4]) );
  DFFSR \rcv_fifo_reg[5]  ( .D(n17), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rcv_fifo[5]) );
  DFFSR \rcv_fifo_reg[6]  ( .D(n15), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rcv_fifo[6]) );
  DFFSR \rcv_fifo_reg[7]  ( .D(n13), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rcv_fifo[7]) );
  AOI22X1 U3 ( .A(rcv_fifo[7]), .B(n2), .C(temp_hold[7]), .D(n11), .Y(n1) );
  AOI22X1 U5 ( .A(rcv_fifo[6]), .B(n2), .C(temp_hold[6]), .D(n11), .Y(n3) );
  AOI22X1 U7 ( .A(rcv_fifo[5]), .B(n2), .C(temp_hold[5]), .D(byte_received), 
        .Y(n4) );
  AOI22X1 U9 ( .A(rcv_fifo[4]), .B(n2), .C(temp_hold[4]), .D(byte_received), 
        .Y(n5) );
  AOI22X1 U11 ( .A(rcv_fifo[3]), .B(n2), .C(temp_hold[3]), .D(byte_received), 
        .Y(n6) );
  AOI22X1 U13 ( .A(rcv_fifo[2]), .B(n2), .C(temp_hold[2]), .D(byte_received), 
        .Y(n7) );
  AOI22X1 U15 ( .A(rcv_fifo[1]), .B(n2), .C(temp_hold[1]), .D(byte_received), 
        .Y(n8) );
  AOI22X1 U17 ( .A(rcv_fifo[0]), .B(n2), .C(temp_hold[0]), .D(byte_received), 
        .Y(n9) );
  rx_sync_high sync_h ( .clk(clk), .n_rst(n_rst), .async_in(dplus_in), 
        .sync_out(dplus_sync) );
  rx_sync_low sync_l ( .clk(clk), .n_rst(n_rst), .async_in(dminus_in), 
        .sync_out(dminus_sync) );
  rx_edge_detector EDG ( .clk(clk), .n_rst(n_rst), .dplus_sync(dplus_sync), 
        .d_edge(d_edge) );
  rx_decoder dec ( .shift_en(shift_en), .clk(clk), .n_rst(n_rst), .dplus_sync(
        dplus_sync), .rcving(rx_transfer_active), .d_orig(d_orig) );
  rx_timer tim ( .clk(clk), .n_rst(n_rst), .receiving(rx_transfer_active), 
        .shift_en(shift_en), .packet_received(byte_received), 
        .max_data_received(max_data_bytes_received), .count_out_bit(
        count_bytes) );
  rx_flex_stp_sr_NUM_BITS8_SHIFT_MSB0 shift_register ( .clk(clk), .n_rst(n_rst), .serial_in(d_orig), .shift_enable(shift_en), .parallel_out(temp_hold) );
  rx_eop_detector eop_detec ( .clk(clk), .n_rst(n_rst), .dplus_sync(dplus_sync), .dminus_sync(dminus_sync), .receiving(rx_transfer_active), .eop(eop) );
  rx_rcu state ( .clk(clk), .n_rst(n_rst), .eop(eop), .byte_received(n11), 
        .d_edge(d_edge), .max_bytes_received(max_data_bytes_received), 
        .rcv_data(rcv_fifo), .buffer_occupancy(buffer_occupancy), 
        .count_bytes(count_bytes), .flush(flush), .store_rx_packet_data(
        store_rx_packet_data), .rx_data_ready(rx_data_ready), 
        .rx_transfer_active(rx_transfer_active), .rx_error(rx_error), 
        .rx_packet_data(rx_packet_data), .rx_packet(rx_packet) );
  INVX2 U2 ( .A(n2), .Y(n11) );
  INVX2 U4 ( .A(byte_received), .Y(n2) );
  INVX2 U6 ( .A(n1), .Y(n13) );
  INVX2 U8 ( .A(n3), .Y(n15) );
  INVX2 U10 ( .A(n4), .Y(n17) );
  INVX2 U12 ( .A(n5), .Y(n19) );
  INVX2 U14 ( .A(n6), .Y(n21) );
  INVX2 U16 ( .A(n7), .Y(n23) );
  INVX2 U18 ( .A(n8), .Y(n25) );
  INVX2 U27 ( .A(n9), .Y(n26) );
endmodule


module usb_endpoint ( clk, n_rst, hsel, haddr, htrans, hsize, hwrite, hwdata, 
        dplus_in, dminus_in, hrdata, hresp, hready, d_mode, dplus_out, 
        dminus_out );
  input [3:0] haddr;
  input [1:0] htrans;
  input [1:0] hsize;
  input [31:0] hwdata;
  output [31:0] hrdata;
  input clk, n_rst, hsel, hwrite, dplus_in, dminus_in;
  output hresp, hready, d_mode, dplus_out, dminus_out;
  wire   rx_data_ready, rx_transfer_active, rx_error, tx_transfer_active,
         tx_error, store_tx_data, get_rx_data, clear, flush,
         store_rx_packet_data, get_tx_packet_data;
  wire   [7:0] rx_data;
  wire   [3:0] rx_packet;
  wire   [6:0] buffer_occupancy;
  wire   [7:0] tx_data;
  wire   [3:0] tx_packet;
  wire   [7:0] rx_packet_data;
  wire   [7:0] tx_packet_data;

  ahb_slave SLAVE ( .clk(clk), .n_rst(n_rst), .hsel(hsel), .hwrite(hwrite), 
        .htrans(htrans), .hsize(hsize), .haddr(haddr), .hwdata(hwdata), 
        .rx_data(rx_data), .rx_data_ready(rx_data_ready), .rx_transfer_active(
        rx_transfer_active), .rx_error(rx_error), .tx_transfer_active(
        tx_transfer_active), .tx_error(tx_error), .rx_packet(rx_packet), 
        .buffer_occupancy(buffer_occupancy), .tx_data(tx_data), 
        .store_tx_data(store_tx_data), .get_rx_data(get_rx_data), .hready(
        hready), .hresp(hresp), .tx_packet(tx_packet), .clear(clear), .hrdata(
        hrdata), .d_mode(d_mode) );
  fifo_data_buffer FIFO_BUFFER ( .clear(clear), .flush(flush), .clk(clk), 
        .n_rst(n_rst), .store_tx_data(store_tx_data), .store_rx_packet_data(
        store_rx_packet_data), .get_rx_data(get_rx_data), .get_tx_packet_data(
        get_tx_packet_data), .tx_data(tx_data), .rx_packet_data(rx_packet_data), .rx_data(rx_data), .tx_packet_data(tx_packet_data), .buffer_occupancy(
        buffer_occupancy) );
  usb_tx TX_USB ( .clk(clk), .n_rst(n_rst), .tx_packet(tx_packet), 
        .buffer_occupancy(buffer_occupancy), .tx_packet_data(tx_packet_data), 
        .tx_transfer_active(tx_transfer_active), .tx_error(tx_error), 
        .get_tx_packet_data(get_tx_packet_data), .Dplus_out(dplus_out), 
        .Dminus_out(dminus_out) );
  usb_rx RX_USB ( .clk(clk), .n_rst(n_rst), .dplus_in(dplus_in), .dminus_in(
        dminus_in), .buffer_occupancy(buffer_occupancy), .rx_transfer_active(
        rx_transfer_active), .rx_error(rx_error), .flush(flush), 
        .store_rx_packet_data(store_rx_packet_data), .rx_data_ready(
        rx_data_ready), .rx_packet(rx_packet), .rx_packet_data(rx_packet_data)
         );
endmodule

