// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Wed Oct 27 00:11:53 2021
// Host        : DESKTOP-98UFVIK running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               f:/coa/soc_sram_func/run_vivado/mycpu/mycpu.srcs/sources_1/ip/clk_pll/clk_pll_stub.v
// Design      : clk_pll
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_pll(cpu_clk, timer_clk, clk_in1_p, clk_in1_n)
/* synthesis syn_black_box black_box_pad_pin="cpu_clk,timer_clk,clk_in1_p,clk_in1_n" */;
  output cpu_clk;
  output timer_clk;
  input clk_in1_p;
  input clk_in1_n;
endmodule
