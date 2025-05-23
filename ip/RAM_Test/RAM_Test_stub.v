// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Mon Apr  7 08:53:10 2025
// Host        : LAPTOP-14KJUI8Q running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Vproject_Vivado/4.HH300_renewal/3.CLLBC/940017/HH300_Renewal.srcs/sources_1/ip/RAM_Test/RAM_Test_stub.v
// Design      : RAM_Test
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a15tcsg324-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_2,Vivado 2018.3" *)
module RAM_Test(clka, wea, addra, dina, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[11:0],dina[10:0],douta[10:0]" */;
  input clka;
  input [0:0]wea;
  input [11:0]addra;
  input [10:0]dina;
  output [10:0]douta;
endmodule
