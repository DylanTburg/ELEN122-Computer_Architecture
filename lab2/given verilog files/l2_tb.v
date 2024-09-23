`timescale 1ns / 1ps

module l2_tb();

    reg clk, exec;
    //standins for the switch data
    reg [3:0] ext_data;
    reg [1:0] xaddr, yaddr, op;
    
    wire extern, gout, ain, gin, rdx, rdy, wrx, add_sub;
    wire [3:0] smstate; 
    wire [3:0] a_out_data;
    wire [3:0] g_out_data;
    wire [3:0] adder_out;
    
    l2_SM sm(.clk(clk),
             .execute(exec),
             .operation(op),
             ._Extern(extern),
             .Gout(gout),
             .Ain(ain),
             .Gin(gin),
             .RdX(rdx),
             .RdY(rdy),
             .WrX(wrx),
             .add_sub(add_sub),
             .cur_state(smstate));
       
    wire [3:0] rf_datain, rf_dataout;
    wire [6:0] seg;
    wire [7:0] an;   
    RF rf(.fpga_clk(clk),
           .DataIn(rf_datain),
           .AddrX(xaddr),
           .AddrY(yaddr),
           .RdX(rdx),
           .RdY(rdy),
           .WrX(wrx),
           .sm_state(smstate),
           .Dataout(rf_dataout),
           .seg(seg),
           .an(an));
           
     A a(.Ain(rf_dataout),
         .load_en(ain),
         .Aout(a_out_data));
         
     A g(.Ain(adder_out),
         .load_en(gin),
         .Aout(g_out_data));
         
     l2_adder adder(.in_A(a_out_data),
                    .in_B(rf_dataout),
                    .add_sub(add_sub),
                    .adder_out(adder_out));
                    
     modified_mux m(.input_data(ext_data),
                .G_data(g_out_data),
                .Gout(gout),
                ._Extern(extern),
                .mux_output(rf_datain));
                   
    
    // clock generation
    initial begin
        clk = 0;
    end    
    always #1 clk = !clk;
    
    // insturction test bench
    always   
    begin
        // initialization
        exec = 0;
        ext_data = 4'b0000;
        xaddr = 2'b00;
        yaddr = 2'b00;
        op = 2'b00;
        #2;
        
        // load 1 to reg 0 
        exec = 1;
        ext_data = 4'b0001;
        xaddr = 2'b00;
        yaddr = 2'b00;
        op = 2'b00;
        #6;           
        // end of load 1 to reg 0
        // now, r0 = 1
        exec = 0;
        #2;
        
        // load 2 to reg 1
        exec = 1;
        ext_data = 4'b0010;
        xaddr = 2'b01;
        yaddr = 2'b00;
        op = 2'b00;
        #6;         
        // end of load 2 to reg 1
        // now r1 = 2
        exec = 0;
        #2;     
  
        // load 4 to reg 2
        exec = 1;
        ext_data = 4'b0100;
        xaddr = 2'b10;
        yaddr = 2'b00;
        op = 2'b00;
        #6;         
        // end of load 4 to reg 2
        // now r2 = 4
        exec = 0;
        #2;  
 
       // load 8 to reg 3
        exec = 1;
        ext_data = 4'b1000;
        xaddr = 2'b11;
        yaddr = 2'b00;
        op = 2'b00;
        #6;         
        // end of load 8 to reg 3
        // now r3 = 8
        exec = 0;
        #2; 
        
        // move r3 to r2
        exec = 1;
        ext_data = 4'b1000;
        xaddr = 2'b10;
        yaddr = 2'b11;
        op = 2'b01;
        #10;         
        // end of move r3 to r2
        // now r2 = 8
        exec = 0;
        #2;        
        
        //  add: r2 = r2 + r1
        exec = 1;
        ext_data = 4'b1000;
        xaddr = 2'b10;
        yaddr = 2'b01;
        op = 2'b11;
        #10;         
        // end of r2 = r2 + r1
        // now r2 = 10
        exec = 0;
        #2;           
   
        //  sub: r3 = r3 - r0
        exec = 1;
        ext_data = 4'b1000;
        xaddr = 2'b11;
        yaddr = 2'b00;
        op = 2'b10;
        #10;         
        // end of r3 = r3 - r0
        // now r3 = 7
        exec = 0;
        #2;      
        
   end     
    
endmodule
