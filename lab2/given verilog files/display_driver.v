`timescale 1ns / 1ps

//////////////////////////////////////////////////
//		Adapted from the ELEN 33 labs	//
//		developed by Andy Wolfe and	//
//		the corresponding Verilog modules //
//            	written by Nick Mikstas           //
//////////////////////////////////////////////////

module display_driver
    (
    input fpga_clk,
    input [6:0]display_digit0,
    input [6:0]display_digit1,
    input [6:0]display_digit2,
    input [6:0]display_digit3,
    input [6:0]display_digit7, //adding a state digit
    
    //7 segment outputs.
    output reg [6:0]seg = 7'b0000000,
    output [7:0]an
    );
    
    //7 segment display regs and wires.
    reg [16:0]clk_div = 17'h00000;
    reg [7:0]an_driver = 8'b11111110;
    reg ce1k = 1'b0;
    reg temp;
    
    //Assign anode to drive.
    assign an = an_driver;
              
    //Create 1kHz clock enable
    always @(posedge fpga_clk) begin
        clk_div <= clk_div + 1'b1;
        
        //Count to 100000 and reset.
        if(clk_div == 17'd99999) begin
            clk_div <= 0;
            ce1k <= 1'b1;
        end
        
        //Reset.
        else begin
            ce1k <= 1'b0;
        end
        
        //Drive the next anode. Only cycle thru 5 "assertions"
	   // since there are only four digits to drive
        if(ce1k) begin
            an_driver[0] <= an_driver[7];
            an_driver[7] <= an_driver[3];
            an_driver[3] <= an_driver[2];
            an_driver[2] <= an_driver[1];
            an_driver[1] <= an_driver[0];
            
            /*
            //serial method
            temp = an_driver[7];
            an_driver[7] = an_driver[3];
            an_driver[3] = an_driver[2];
            an_driver[2] = an_driver[1];
            an_driver[0] = temp;
            */
        end
    end 
    
    //Choose which part of number to display.
    always @(*) begin
        case(an_driver)
            8'b11111110 : seg = display_digit0;
            8'b11111101 : seg = display_digit1;
            8'b11111011 : seg = display_digit2;
            8'b11110111 : seg = display_digit3;
            8'b01111111 : seg = display_digit7;
            default : seg = 7'b0000000;       
        endcase
    end
    
endmodule