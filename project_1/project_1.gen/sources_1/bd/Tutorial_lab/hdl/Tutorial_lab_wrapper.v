//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.1 (win64) Build 3526262 Mon Apr 18 15:48:16 MDT 2022
//Date        : Thu Jan 11 23:33:00 2024
//Host        : winvdi2005 running 64-bit major release  (build 9200)
//Command     : generate_target Tutorial_lab_wrapper.bd
//Design      : Tutorial_lab_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module Tutorial_lab_wrapper
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

  wire [31:0]a;
  wire add;
  wire [31:0]b;
  wire c_out;
  wire [31:0]s;

  Tutorial_lab Tutorial_lab_i
       (.a(a),
        .add(add),
        .b(b),
        .c_out(c_out),
        .s(s));
endmodule
