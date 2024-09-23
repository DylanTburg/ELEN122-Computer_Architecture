`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/11/2024 11:25:00 PM
// Design Name: 
// Module Name: adder_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module adder_tb;
    reg add;
    reg [31:0]a;
    reg [31:0]b;
    wire [31:0]s;
    wire c_out;
    
    Tutorial_lab uut(
        .add(add),
        .a(a),
        .b(b),
        .s(s),
        .c_out(c_out)
        );
        
    initial begin
    add = 0;
    a = 0;
    b = 0;
    #100
    a = 10;
    b = 20;
    add = 1;
    #200
    a = 200;
    b = 100;
    add = 0;
    end
endmodule
