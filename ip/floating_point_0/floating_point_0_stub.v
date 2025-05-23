// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Fri Jul 28 10:14:25 2023
// Host        : LAPTOP-14KJUI8Q running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Vproject_Vivado/HH300_renewal/1.HH300_renewal_230727/HH300_Renewal.srcs/sources_1/ip/floating_point_0/floating_point_0_stub.v
// Design      : floating_point_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a15tcsg324-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "floating_point_v7_1_7,Vivado 2018.3" *)
module floating_point_0(aclk, aclken, s_axis_a_tvalid, s_axis_a_tdata, 
  m_axis_result_tvalid, m_axis_result_tdata)
/* synthesis syn_black_box black_box_pad_pin="aclk,aclken,s_axis_a_tvalid,s_axis_a_tdata[23:0],m_axis_result_tvalid,m_axis_result_tdata[31:0]" */;
  input aclk;
  input aclken;
  input s_axis_a_tvalid;
  input [23:0]s_axis_a_tdata;
  output m_axis_result_tvalid;
  output [31:0]m_axis_result_tdata;
endmodule
