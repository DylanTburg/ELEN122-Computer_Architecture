//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.1 (win64) Build 3526262 Mon Apr 18 15:48:16 MDT 2022
//Date        : Thu Jan 11 23:33:00 2024
//Host        : winvdi2005 running 64-bit major release  (build 9200)
//Command     : generate_target Tutorial_lab.bd
//Design      : Tutorial_lab
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "Tutorial_lab,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=Tutorial_lab,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "Tutorial_lab.hwdef" *) 
module Tutorial_lab
   (a,
    add,
    b,
    c_out,
    s);
  input [31:0]a;
  input add;
  input [31:0]b;
  output c_out;
  output [31:0]s;

  wire [31:0]a_1;
  wire add_1;
  wire [31:0]b_1;
  wire c_addsub_0_C_OUT;
  wire [31:0]c_addsub_0_S;

  assign a_1 = a[31:0];
  assign add_1 = add;
  assign b_1 = b[31:0];
  assign c_out = c_addsub_0_C_OUT;
  assign s[31:0] = c_addsub_0_S;
  Tutorial_lab_c_addsub_0_1 c_addsub_0
       (.A(a_1),
        .ADD(add_1),
        .B(b_1),
        .C_OUT(c_addsub_0_C_OUT),
        .S(c_addsub_0_S));
endmodule
