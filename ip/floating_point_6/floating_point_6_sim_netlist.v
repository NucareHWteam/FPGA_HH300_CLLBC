// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Fri Aug  2 13:25:00 2024
// Host        : LAPTOP-14KJUI8Q running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Vproject_Vivado/HH300_renewal/2.HH300_renewal_CLYC_2400603_Temptable/HH300_Renewal.srcs/sources_1/ip/floating_point_6/floating_point_6_sim_netlist.v
// Design      : floating_point_6
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a15tcsg324-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "floating_point_6,floating_point_v7_1_7,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "floating_point_v7_1_7,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module floating_point_6
   (aclk,
    aclken,
    s_axis_a_tvalid,
    s_axis_a_tdata,
    s_axis_b_tvalid,
    s_axis_b_tdata,
    m_axis_result_tvalid,
    m_axis_result_tdata);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 aclk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME aclk_intf, ASSOCIATED_BUSIF S_AXIS_OPERATION:M_AXIS_RESULT:S_AXIS_C:S_AXIS_B:S_AXIS_A, ASSOCIATED_RESET aresetn, ASSOCIATED_CLKEN aclken, FREQ_HZ 10000000, PHASE 0.000, INSERT_VIP 0" *) input aclk;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 aclken_intf CE" *) (* x_interface_parameter = "XIL_INTERFACENAME aclken_intf, POLARITY ACTIVE_LOW" *) input aclken;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_A TVALID" *) (* x_interface_parameter = "XIL_INTERFACENAME S_AXIS_A, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 0, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0" *) input s_axis_a_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_A TDATA" *) input [31:0]s_axis_a_tdata;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_B TVALID" *) (* x_interface_parameter = "XIL_INTERFACENAME S_AXIS_B, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 0, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0" *) input s_axis_b_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_B TDATA" *) input [31:0]s_axis_b_tdata;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_RESULT TVALID" *) (* x_interface_parameter = "XIL_INTERFACENAME M_AXIS_RESULT, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 0, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0" *) output m_axis_result_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_RESULT TDATA" *) output [7:0]m_axis_result_tdata;

  wire aclk;
  wire aclken;
  wire [7:0]m_axis_result_tdata;
  wire m_axis_result_tvalid;
  wire [31:0]s_axis_a_tdata;
  wire s_axis_a_tvalid;
  wire [31:0]s_axis_b_tdata;
  wire s_axis_b_tvalid;
  wire NLW_U0_m_axis_result_tlast_UNCONNECTED;
  wire NLW_U0_s_axis_a_tready_UNCONNECTED;
  wire NLW_U0_s_axis_b_tready_UNCONNECTED;
  wire NLW_U0_s_axis_c_tready_UNCONNECTED;
  wire NLW_U0_s_axis_operation_tready_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_result_tuser_UNCONNECTED;

  (* C_ACCUM_INPUT_MSB = "32" *) 
  (* C_ACCUM_LSB = "-31" *) 
  (* C_ACCUM_MSB = "32" *) 
  (* C_A_FRACTION_WIDTH = "16" *) 
  (* C_A_TDATA_WIDTH = "32" *) 
  (* C_A_TUSER_WIDTH = "1" *) 
  (* C_A_WIDTH = "32" *) 
  (* C_BRAM_USAGE = "0" *) 
  (* C_B_FRACTION_WIDTH = "16" *) 
  (* C_B_TDATA_WIDTH = "32" *) 
  (* C_B_TUSER_WIDTH = "1" *) 
  (* C_B_WIDTH = "32" *) 
  (* C_COMPARE_OPERATION = "4" *) 
  (* C_C_FRACTION_WIDTH = "16" *) 
  (* C_C_TDATA_WIDTH = "32" *) 
  (* C_C_TUSER_WIDTH = "1" *) 
  (* C_C_WIDTH = "32" *) 
  (* C_FIXED_DATA_UNSIGNED = "0" *) 
  (* C_HAS_ABSOLUTE = "0" *) 
  (* C_HAS_ACCUMULATOR_A = "0" *) 
  (* C_HAS_ACCUMULATOR_S = "0" *) 
  (* C_HAS_ACCUM_INPUT_OVERFLOW = "0" *) 
  (* C_HAS_ACCUM_OVERFLOW = "0" *) 
  (* C_HAS_ACLKEN = "1" *) 
  (* C_HAS_ADD = "0" *) 
  (* C_HAS_ARESETN = "0" *) 
  (* C_HAS_A_TLAST = "0" *) 
  (* C_HAS_A_TUSER = "0" *) 
  (* C_HAS_B = "1" *) 
  (* C_HAS_B_TLAST = "0" *) 
  (* C_HAS_B_TUSER = "0" *) 
  (* C_HAS_C = "0" *) 
  (* C_HAS_COMPARE = "1" *) 
  (* C_HAS_C_TLAST = "0" *) 
  (* C_HAS_C_TUSER = "0" *) 
  (* C_HAS_DIVIDE = "0" *) 
  (* C_HAS_DIVIDE_BY_ZERO = "0" *) 
  (* C_HAS_EXPONENTIAL = "0" *) 
  (* C_HAS_FIX_TO_FLT = "0" *) 
  (* C_HAS_FLT_TO_FIX = "0" *) 
  (* C_HAS_FLT_TO_FLT = "0" *) 
  (* C_HAS_FMA = "0" *) 
  (* C_HAS_FMS = "0" *) 
  (* C_HAS_INVALID_OP = "0" *) 
  (* C_HAS_LOGARITHM = "0" *) 
  (* C_HAS_MULTIPLY = "0" *) 
  (* C_HAS_OPERATION = "0" *) 
  (* C_HAS_OPERATION_TLAST = "0" *) 
  (* C_HAS_OPERATION_TUSER = "0" *) 
  (* C_HAS_OVERFLOW = "0" *) 
  (* C_HAS_RECIP = "0" *) 
  (* C_HAS_RECIP_SQRT = "0" *) 
  (* C_HAS_RESULT_TLAST = "0" *) 
  (* C_HAS_RESULT_TUSER = "0" *) 
  (* C_HAS_SQRT = "0" *) 
  (* C_HAS_SUBTRACT = "0" *) 
  (* C_HAS_UNDERFLOW = "0" *) 
  (* C_LATENCY = "2" *) 
  (* C_MULT_USAGE = "0" *) 
  (* C_OPERATION_TDATA_WIDTH = "8" *) 
  (* C_OPERATION_TUSER_WIDTH = "1" *) 
  (* C_OPTIMIZATION = "1" *) 
  (* C_RATE = "1" *) 
  (* C_RESULT_FRACTION_WIDTH = "0" *) 
  (* C_RESULT_TDATA_WIDTH = "8" *) 
  (* C_RESULT_TUSER_WIDTH = "1" *) 
  (* C_RESULT_WIDTH = "1" *) 
  (* C_THROTTLE_SCHEME = "3" *) 
  (* C_TLAST_RESOLUTION = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  floating_point_6_floating_point_v7_1_7 U0
       (.aclk(aclk),
        .aclken(aclken),
        .aresetn(1'b1),
        .m_axis_result_tdata(m_axis_result_tdata),
        .m_axis_result_tlast(NLW_U0_m_axis_result_tlast_UNCONNECTED),
        .m_axis_result_tready(1'b0),
        .m_axis_result_tuser(NLW_U0_m_axis_result_tuser_UNCONNECTED[0]),
        .m_axis_result_tvalid(m_axis_result_tvalid),
        .s_axis_a_tdata(s_axis_a_tdata),
        .s_axis_a_tlast(1'b0),
        .s_axis_a_tready(NLW_U0_s_axis_a_tready_UNCONNECTED),
        .s_axis_a_tuser(1'b0),
        .s_axis_a_tvalid(s_axis_a_tvalid),
        .s_axis_b_tdata(s_axis_b_tdata),
        .s_axis_b_tlast(1'b0),
        .s_axis_b_tready(NLW_U0_s_axis_b_tready_UNCONNECTED),
        .s_axis_b_tuser(1'b0),
        .s_axis_b_tvalid(s_axis_b_tvalid),
        .s_axis_c_tdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axis_c_tlast(1'b0),
        .s_axis_c_tready(NLW_U0_s_axis_c_tready_UNCONNECTED),
        .s_axis_c_tuser(1'b0),
        .s_axis_c_tvalid(1'b0),
        .s_axis_operation_tdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axis_operation_tlast(1'b0),
        .s_axis_operation_tready(NLW_U0_s_axis_operation_tready_UNCONNECTED),
        .s_axis_operation_tuser(1'b0),
        .s_axis_operation_tvalid(1'b0));
endmodule

(* C_ACCUM_INPUT_MSB = "32" *) (* C_ACCUM_LSB = "-31" *) (* C_ACCUM_MSB = "32" *) 
(* C_A_FRACTION_WIDTH = "16" *) (* C_A_TDATA_WIDTH = "32" *) (* C_A_TUSER_WIDTH = "1" *) 
(* C_A_WIDTH = "32" *) (* C_BRAM_USAGE = "0" *) (* C_B_FRACTION_WIDTH = "16" *) 
(* C_B_TDATA_WIDTH = "32" *) (* C_B_TUSER_WIDTH = "1" *) (* C_B_WIDTH = "32" *) 
(* C_COMPARE_OPERATION = "4" *) (* C_C_FRACTION_WIDTH = "16" *) (* C_C_TDATA_WIDTH = "32" *) 
(* C_C_TUSER_WIDTH = "1" *) (* C_C_WIDTH = "32" *) (* C_FIXED_DATA_UNSIGNED = "0" *) 
(* C_HAS_ABSOLUTE = "0" *) (* C_HAS_ACCUMULATOR_A = "0" *) (* C_HAS_ACCUMULATOR_S = "0" *) 
(* C_HAS_ACCUM_INPUT_OVERFLOW = "0" *) (* C_HAS_ACCUM_OVERFLOW = "0" *) (* C_HAS_ACLKEN = "1" *) 
(* C_HAS_ADD = "0" *) (* C_HAS_ARESETN = "0" *) (* C_HAS_A_TLAST = "0" *) 
(* C_HAS_A_TUSER = "0" *) (* C_HAS_B = "1" *) (* C_HAS_B_TLAST = "0" *) 
(* C_HAS_B_TUSER = "0" *) (* C_HAS_C = "0" *) (* C_HAS_COMPARE = "1" *) 
(* C_HAS_C_TLAST = "0" *) (* C_HAS_C_TUSER = "0" *) (* C_HAS_DIVIDE = "0" *) 
(* C_HAS_DIVIDE_BY_ZERO = "0" *) (* C_HAS_EXPONENTIAL = "0" *) (* C_HAS_FIX_TO_FLT = "0" *) 
(* C_HAS_FLT_TO_FIX = "0" *) (* C_HAS_FLT_TO_FLT = "0" *) (* C_HAS_FMA = "0" *) 
(* C_HAS_FMS = "0" *) (* C_HAS_INVALID_OP = "0" *) (* C_HAS_LOGARITHM = "0" *) 
(* C_HAS_MULTIPLY = "0" *) (* C_HAS_OPERATION = "0" *) (* C_HAS_OPERATION_TLAST = "0" *) 
(* C_HAS_OPERATION_TUSER = "0" *) (* C_HAS_OVERFLOW = "0" *) (* C_HAS_RECIP = "0" *) 
(* C_HAS_RECIP_SQRT = "0" *) (* C_HAS_RESULT_TLAST = "0" *) (* C_HAS_RESULT_TUSER = "0" *) 
(* C_HAS_SQRT = "0" *) (* C_HAS_SUBTRACT = "0" *) (* C_HAS_UNDERFLOW = "0" *) 
(* C_LATENCY = "2" *) (* C_MULT_USAGE = "0" *) (* C_OPERATION_TDATA_WIDTH = "8" *) 
(* C_OPERATION_TUSER_WIDTH = "1" *) (* C_OPTIMIZATION = "1" *) (* C_RATE = "1" *) 
(* C_RESULT_FRACTION_WIDTH = "0" *) (* C_RESULT_TDATA_WIDTH = "8" *) (* C_RESULT_TUSER_WIDTH = "1" *) 
(* C_RESULT_WIDTH = "1" *) (* C_THROTTLE_SCHEME = "3" *) (* C_TLAST_RESOLUTION = "0" *) 
(* C_XDEVICEFAMILY = "artix7" *) (* ORIG_REF_NAME = "floating_point_v7_1_7" *) (* downgradeipidentifiedwarnings = "yes" *) 
module floating_point_6_floating_point_v7_1_7
   (aclk,
    aclken,
    aresetn,
    s_axis_a_tvalid,
    s_axis_a_tready,
    s_axis_a_tdata,
    s_axis_a_tuser,
    s_axis_a_tlast,
    s_axis_b_tvalid,
    s_axis_b_tready,
    s_axis_b_tdata,
    s_axis_b_tuser,
    s_axis_b_tlast,
    s_axis_c_tvalid,
    s_axis_c_tready,
    s_axis_c_tdata,
    s_axis_c_tuser,
    s_axis_c_tlast,
    s_axis_operation_tvalid,
    s_axis_operation_tready,
    s_axis_operation_tdata,
    s_axis_operation_tuser,
    s_axis_operation_tlast,
    m_axis_result_tvalid,
    m_axis_result_tready,
    m_axis_result_tdata,
    m_axis_result_tuser,
    m_axis_result_tlast);
  input aclk;
  input aclken;
  input aresetn;
  input s_axis_a_tvalid;
  output s_axis_a_tready;
  input [31:0]s_axis_a_tdata;
  input [0:0]s_axis_a_tuser;
  input s_axis_a_tlast;
  input s_axis_b_tvalid;
  output s_axis_b_tready;
  input [31:0]s_axis_b_tdata;
  input [0:0]s_axis_b_tuser;
  input s_axis_b_tlast;
  input s_axis_c_tvalid;
  output s_axis_c_tready;
  input [31:0]s_axis_c_tdata;
  input [0:0]s_axis_c_tuser;
  input s_axis_c_tlast;
  input s_axis_operation_tvalid;
  output s_axis_operation_tready;
  input [7:0]s_axis_operation_tdata;
  input [0:0]s_axis_operation_tuser;
  input s_axis_operation_tlast;
  output m_axis_result_tvalid;
  input m_axis_result_tready;
  output [7:0]m_axis_result_tdata;
  output [0:0]m_axis_result_tuser;
  output m_axis_result_tlast;

  wire \<const0> ;
  wire \<const1> ;
  wire aclk;
  wire aclken;
  wire [0:0]\^m_axis_result_tdata ;
  wire m_axis_result_tvalid;
  wire [31:0]s_axis_a_tdata;
  wire s_axis_a_tvalid;
  wire [31:0]s_axis_b_tdata;
  wire s_axis_b_tvalid;
  wire NLW_i_synth_m_axis_result_tlast_UNCONNECTED;
  wire NLW_i_synth_s_axis_a_tready_UNCONNECTED;
  wire NLW_i_synth_s_axis_b_tready_UNCONNECTED;
  wire NLW_i_synth_s_axis_c_tready_UNCONNECTED;
  wire NLW_i_synth_s_axis_operation_tready_UNCONNECTED;
  wire [7:1]NLW_i_synth_m_axis_result_tdata_UNCONNECTED;
  wire [0:0]NLW_i_synth_m_axis_result_tuser_UNCONNECTED;

  assign m_axis_result_tdata[7] = \<const0> ;
  assign m_axis_result_tdata[6] = \<const0> ;
  assign m_axis_result_tdata[5] = \<const0> ;
  assign m_axis_result_tdata[4] = \<const0> ;
  assign m_axis_result_tdata[3] = \<const0> ;
  assign m_axis_result_tdata[2] = \<const0> ;
  assign m_axis_result_tdata[1] = \<const0> ;
  assign m_axis_result_tdata[0] = \^m_axis_result_tdata [0];
  assign m_axis_result_tlast = \<const0> ;
  assign m_axis_result_tuser[0] = \<const0> ;
  assign s_axis_a_tready = \<const1> ;
  assign s_axis_b_tready = \<const1> ;
  assign s_axis_c_tready = \<const1> ;
  assign s_axis_operation_tready = \<const1> ;
  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  (* C_ACCUM_INPUT_MSB = "32" *) 
  (* C_ACCUM_LSB = "-31" *) 
  (* C_ACCUM_MSB = "32" *) 
  (* C_A_FRACTION_WIDTH = "16" *) 
  (* C_A_TDATA_WIDTH = "32" *) 
  (* C_A_TUSER_WIDTH = "1" *) 
  (* C_A_WIDTH = "32" *) 
  (* C_BRAM_USAGE = "0" *) 
  (* C_B_FRACTION_WIDTH = "16" *) 
  (* C_B_TDATA_WIDTH = "32" *) 
  (* C_B_TUSER_WIDTH = "1" *) 
  (* C_B_WIDTH = "32" *) 
  (* C_COMPARE_OPERATION = "4" *) 
  (* C_C_FRACTION_WIDTH = "16" *) 
  (* C_C_TDATA_WIDTH = "32" *) 
  (* C_C_TUSER_WIDTH = "1" *) 
  (* C_C_WIDTH = "32" *) 
  (* C_FIXED_DATA_UNSIGNED = "0" *) 
  (* C_HAS_ABSOLUTE = "0" *) 
  (* C_HAS_ACCUMULATOR_A = "0" *) 
  (* C_HAS_ACCUMULATOR_S = "0" *) 
  (* C_HAS_ACCUM_INPUT_OVERFLOW = "0" *) 
  (* C_HAS_ACCUM_OVERFLOW = "0" *) 
  (* C_HAS_ACLKEN = "1" *) 
  (* C_HAS_ADD = "0" *) 
  (* C_HAS_ARESETN = "0" *) 
  (* C_HAS_A_TLAST = "0" *) 
  (* C_HAS_A_TUSER = "0" *) 
  (* C_HAS_B = "1" *) 
  (* C_HAS_B_TLAST = "0" *) 
  (* C_HAS_B_TUSER = "0" *) 
  (* C_HAS_C = "0" *) 
  (* C_HAS_COMPARE = "1" *) 
  (* C_HAS_C_TLAST = "0" *) 
  (* C_HAS_C_TUSER = "0" *) 
  (* C_HAS_DIVIDE = "0" *) 
  (* C_HAS_DIVIDE_BY_ZERO = "0" *) 
  (* C_HAS_EXPONENTIAL = "0" *) 
  (* C_HAS_FIX_TO_FLT = "0" *) 
  (* C_HAS_FLT_TO_FIX = "0" *) 
  (* C_HAS_FLT_TO_FLT = "0" *) 
  (* C_HAS_FMA = "0" *) 
  (* C_HAS_FMS = "0" *) 
  (* C_HAS_INVALID_OP = "0" *) 
  (* C_HAS_LOGARITHM = "0" *) 
  (* C_HAS_MULTIPLY = "0" *) 
  (* C_HAS_OPERATION = "0" *) 
  (* C_HAS_OPERATION_TLAST = "0" *) 
  (* C_HAS_OPERATION_TUSER = "0" *) 
  (* C_HAS_OVERFLOW = "0" *) 
  (* C_HAS_RECIP = "0" *) 
  (* C_HAS_RECIP_SQRT = "0" *) 
  (* C_HAS_RESULT_TLAST = "0" *) 
  (* C_HAS_RESULT_TUSER = "0" *) 
  (* C_HAS_SQRT = "0" *) 
  (* C_HAS_SUBTRACT = "0" *) 
  (* C_HAS_UNDERFLOW = "0" *) 
  (* C_LATENCY = "2" *) 
  (* C_MULT_USAGE = "0" *) 
  (* C_OPERATION_TDATA_WIDTH = "8" *) 
  (* C_OPERATION_TUSER_WIDTH = "1" *) 
  (* C_OPTIMIZATION = "1" *) 
  (* C_RATE = "1" *) 
  (* C_RESULT_FRACTION_WIDTH = "0" *) 
  (* C_RESULT_TDATA_WIDTH = "8" *) 
  (* C_RESULT_TUSER_WIDTH = "1" *) 
  (* C_RESULT_WIDTH = "1" *) 
  (* C_THROTTLE_SCHEME = "3" *) 
  (* C_TLAST_RESOLUTION = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  floating_point_6_floating_point_v7_1_7_viv i_synth
       (.aclk(aclk),
        .aclken(aclken),
        .aresetn(1'b0),
        .m_axis_result_tdata({NLW_i_synth_m_axis_result_tdata_UNCONNECTED[7:1],\^m_axis_result_tdata }),
        .m_axis_result_tlast(NLW_i_synth_m_axis_result_tlast_UNCONNECTED),
        .m_axis_result_tready(1'b0),
        .m_axis_result_tuser(NLW_i_synth_m_axis_result_tuser_UNCONNECTED[0]),
        .m_axis_result_tvalid(m_axis_result_tvalid),
        .s_axis_a_tdata(s_axis_a_tdata),
        .s_axis_a_tlast(1'b0),
        .s_axis_a_tready(NLW_i_synth_s_axis_a_tready_UNCONNECTED),
        .s_axis_a_tuser(1'b0),
        .s_axis_a_tvalid(s_axis_a_tvalid),
        .s_axis_b_tdata(s_axis_b_tdata),
        .s_axis_b_tlast(1'b0),
        .s_axis_b_tready(NLW_i_synth_s_axis_b_tready_UNCONNECTED),
        .s_axis_b_tuser(1'b0),
        .s_axis_b_tvalid(s_axis_b_tvalid),
        .s_axis_c_tdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axis_c_tlast(1'b0),
        .s_axis_c_tready(NLW_i_synth_s_axis_c_tready_UNCONNECTED),
        .s_axis_c_tuser(1'b0),
        .s_axis_c_tvalid(1'b0),
        .s_axis_operation_tdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axis_operation_tlast(1'b0),
        .s_axis_operation_tready(NLW_i_synth_s_axis_operation_tready_UNCONNECTED),
        .s_axis_operation_tuser(1'b0),
        .s_axis_operation_tvalid(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2015"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
Htz50jQwzDqBz0sJUkiNYd41xyVM9gKOaU0qGZ3Dh5hlksE2EYyEMJ5TEQ9/fgf9ddxIsjO99VQF
+SFeP6Zn0A==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
urFaskumfugPrlLKzxdNiluIVgeqUIta5Ygb2si9wpVVYrLD91tJNNSmQFBFcqkPxRC+c4hD38Ih
TeDFc8GMIYSykN35NKncGdLDKf9vckkVDU3LUXMKQhtPwflso3LHvVPdVeqdB1jrilIuRztti1RI
laiZ1el6FSAEM187MEU=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PvQ88O6pn4jd1LlqGMa9u1BhYjCMtSlUDLe77WTjK3x2SjSwkYeJAu8exgSjIKGDB0c9KAZ5QgBh
O2hhbS38Sxr5ENIpMK1iL4mQbE/L1ISVzBhpDCkuB361Z4PHflp+vx13vEh5tLAh0HJLrwVDs7ds
sd3Qx6haRw1rAhBzVOOqg95qdCsfCbYxXUJwnA/LYkOiiBEhr3OshfBWeDvDfiKFTWQDf02hPqv9
6YZkraVjegL5nDxNvVPdCY9avFl3udmu7t95XadRhaDNIJy8jeNzwFN/FVO/oObzjMEUzywVPlvq
bTHWxVvkKvJpHnOq7NZQFDuZ0/qYeTzUSazDiw==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QjJIGhz07yYt4U6yvYPbKhHbSWpYqJt31FtbOojSFxXMwF6NZLEiZaIIIWPV6Zrpv3zZaTzpDHNW
kJ44ChH50pS/w4eHwz9Rkhlf4zPqFDJ5K1BQ2PO9A7b9fdIumeVxFOqpdXTuFrmYXmXg74Z5p4Qr
ksZfH+582hrj7NleSVKltv+ZWT4Q2EcUpSasTqpQ/WWAaWXsuDmY/TF1A7Dn1Kp+1XiQRoeerC4i
RKqsy9lvEi726kApiGrFx8VTItw8VUccosa36zsWsAoOGUVwk/xs2YnwU40wT2VKLz6TbH/jt/qq
MlBDlF578tL/zpkYMfCtPnkljmp6ESneGZQymw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2017_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
AYCQHSpmU8XcndTGK7EswczC2JHPTpOl/QkpC7inAetwAToyr/QbvaJy+dRBnenEogfr9kuwBk7R
FveKksvT6WqZ9X80UkxZvUAwAlQZtlhUh9wAEAtlVzXtPdJQLZD0mVp3JWNUuyle4RNCRlOdu65V
OhrIaCQ4das2LWAtVGidm3mOjabJ3/vs8Uhgte4K5jML5uhlgfNHfgy11XvCCXijRSyX4Vfl1Oop
zJoBd2Ac2Vffqs5QBY26wU2c+wUC2mDxUUvNFcenq/S+AagI5R9KNFIC69BcIUTpebsT41vZRXiL
59qYxSXnKAO9JTQnZ8Bwm4dPmQARUaLnQxiLXw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
Oj7XWa8zrsMCrFj1f7b6A6AylDgxLQhfw+MQu06gYsEvOQkxZ6fwujchNWvGwSwpEYmCNyKYhErO
GKfeD3W1lEuLvC5IyY/by6+zv9p6klEsQVOxtkr1GxMytbtDPPgqw2nY3P37+GNSs+JpH8Jur2Iv
LAUwD5ZYVKID5fHuFVw=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
NdYEll1opWwDyBdIK+m1ZLwghhUVo+JQ4mOYvEMCoy5ztuZ0zDLOT4oJ1pcstOx8dqQ9dSL9Ia2F
kzcsXtCf0Kflv8nq7QUdu3g94NQjczIRI/6Ju1LmL+jwrBbAEGnkHoHpZzc7ySY7tiEG0ekBhKBW
5BwubTXyHpteV9cxJSsd1nKnhdFnbeRZYV/XkgPriJsRTXvgi0oAjclpplkt93pTpKsFn+n8kNdT
scUv0wQpOi75aw0fvEV7M9sXiTsTrVIAQA4ciZlxDEJNqo9hUSpcOTiCjdNhF1oSGEKtdhZH+0eP
O7uUJYO323HSOcTu8GMgBa38JF0Tr0gJlqAcpQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
HL6OY9mn5FeX9Z94CriShXoAfWNVum0jWwJ8Ze6RTXw3PaZ+NAIjH6KjvhS/cyEGdPY3AqDrbZ8W
ndzDHguot6f6IydmtFCZ3Au2xrhPp/DZCKN0SBlzej8c4PvCk5/xK2GyLpBfeea2xYbo790BOMVv
X6cGcykgKXubXNEfjiWYwmxqa8l5Ynky+8uDKZ9rL9DPeqxkyLdx4TgywpIhXgkpJSYxpSRAQiIz
2qKE0UFjioxNLUlWmMUMoCA1Am3jk7RRglPRlHdMV6rwHc9ESMsYL+0i4CGVQQTjkZxTu0a16pTy
AwnMUDOpYAH0UV5IGRfroC+Glo3ICWta0nAyww==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
dIoT8aVVNS0bS9QQI49nzFVuUH2P4O2o1qfEgfuQvnnkeN877zQ+ya3Jjg32jGQljF9x4+ZHYOPX
RG4LdM0U2Xc67b+DsYGcGSr/4HRealNfXGbuU1Hq09N84I2KNaT25N3CvaAWQjAoYLly/1b4O17K
u3zCw0C/lAhv2wHfwGa8P5jqPgIcOB2+tyUL1oso+7jL6Ac9pV/u4drTl/nJOu5whwKLc0MJXgdt
5IkT8eGtx1YX/3GDSaRICmzil7iDPEEWdlechA+w9BScbh6XDA1AyhWu9Hfn//vuYvnVy97oJJfK
I4U+PyNfkVFg2DW7P3BbrWu44RGJA6kJ+FHM3A==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 49696)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
