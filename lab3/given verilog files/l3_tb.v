`timescale 1ns / 1ps

module l3_tb();

    /* clock and instruction control */
    reg clk, exec;

    /* instruction: to be generated in the testbench part */
    reg [0:10] instr;   
    /*  4 different fields in an instruction */
    wire [0:2] opcode;  /* instr [0:2] */
    wire [1:0] reg_x;   /* instr [3:4] */
    wire [1:0] reg_y;   /* instr [5:6] */
    wire [3:0] imm;     /* instr [7:10] */
    
    /* control state machine outputs */
    wire extern, gout, iout, ain, gin, dpin, rdx, rdy, wrx, add_sub;
    
    /* state machine states */
    wire [3:0] smstate; 
    
    /* latch a output */
    wire [3:0] a_out_data;
    /* latch g output */
    wire [3:0] g_out_data;
    /* latch dp output */
    wire [3:0] dp_out_data;
        
    /* mux 2 output */
    wire [3:0] mux2_output;
    
    /* adder output */
    wire [3:0] adder_out;
    

    
    l3_SM sm(.clk(clk),
             .execute(exec),
             .operation(opcode),
             ._Extern(extern),
             .Gout(gout),
             .Iout(iout),
             .Ain(ain),
             .Gin(gin),
             .DPin(dpin),
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
           .AddrX(reg_x),
           .AddrY(reg_y),
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
        
	/* TODO 5: add DP latch */ 
	 A dp(.Ain(rf_dataout),
         .load_en(dpin),
         .Aout(dp_out_data));
         
	/* TODO 6: add a 2-to-1 MUX, use # for parameterizing */ 
	mux_2_to_1 #(4) m2(.in0(rf_dataout), .in1(imm), .sel(iout), .mux_output(mux2_output));
     
     l2_adder adder(.in_A(a_out_data),
                    .in_B(mux2_output), /* TODO 7: modify the connection of the 2nd operand in Adder */ 
                    .add_sub(add_sub),
                    .adder_out(adder_out));
                    
     modified_mux m1(.input_data(imm),
                .G_data(g_out_data),
                .Gout(gout),
                ._Extern(extern),
                .mux_output(rf_datain));
  
    
    // clock generation
    initial begin
        clk = 0;
    end    
    always #1 clk = !clk;
    

    assign opcode = instr[0:2];
    assign reg_x = instr[3:4];
    assign reg_y = instr[5:6];
    assign imm = instr[7:10];
    
    // insturction test bench
    always   
    begin
        // initialization
        exec = 0;
        //  op = 3'b000, reg_x = 2'b00, reg_y = 2'b00, imm = 4'b0000
        instr = 11'b00000000000;       
        #2;
        
        // load 1 to reg 0 
        exec = 1;
        // op = 3'b000, reg_x = 2'b00, reg_y = 2'b00, imm = 4'b0001
        instr = 11'b00000000001;  
        #6;           
        // end of load 1 to reg 0
        // now, r0 = 1
        exec = 0;
        #2;
        
        // load 2 to reg 1
        exec = 1;
        // op = 3'b000, reg_x = 2'b01, reg_y = 2'b00, imm = 4'b0010
        instr = 11'b00001000010;      
        #6;         
        // end of load 2 to reg 1
        // now r1 = 2
        exec = 0;
        #2;     
  
        // load 4 to reg 2
        exec = 1;
        // op = 3'b000, reg_x = 2'b10, reg_y = 2'b00, imm = 4'b0100
        instr = 11'b00010000100;     
        #6;         
        // end of load 4 to reg 2
        // now r2 = 4
        exec = 0;
        #2;  
 
       // load 8 to reg 3
        exec = 1;
        // op = 3'b000, reg_x = 2'b11, reg_y = 2'b00, imm = 4'b1000
        instr = 11'b00011001000;      
        #6;         
        // end of load 8 to reg 3
        // now r3 = 8
        exec = 0;
        #2; 
        
        // move r3 to r2
        exec = 1;
        // op = 3'b001, reg_x = 2'b10, reg_y = 2'b11, imm = 4'b1000;
        instr = 11'b00110111000;
        #10;         
        // end of move r3 to r2
        // now r2 = 8
        exec = 0;
        #2;        
        
        //  add: r2 = r2 + r1
        exec = 1;
        // op = 3'b011, reg_x = 2'b10, reg_y = 2'b01, imm = 4'b1000;
        instr = 11'b01110011000;       
        #10;         
        // end of r2 = r2 + r1
        // now r2 = 10
        exec = 0;
        #2;           
   
        //  sub: r3 = r3 - r0
        exec = 1; 
        // op = 3'b010, reg_x = 2'b11, reg_y = 2'b00, imm = 4'b1000
        instr = 11'b01011001000;
        #10;         
        // end of r3 = r3 - r0
        // now r3 = 7
        exec = 0;
        #2;      
        
	/* TODO 8: add more test sequences for addi, subi, and disp */
        
        // addi: r3 = r3 + 8
        exec=1;
        // op = 3'b111, reg_x = 2'b11, reg_y = 2'b11, imm = 4'b1000 
        instr =  11'b11111111000;
        #10;
        // end of r3 = r3 + 8
        // r3 = 15
        exec = 0;
        #2;
        
        // subi: r3 = r3 - 5
        exec=1;
        // op = 3'b110, reg_x = 2'b11, reg_y = 2'b11, imm = 4'b0101 
        instr =  11'b11011110101;
        #10;
        // end of r3 = r3 - 5
        // r3 = 10
        exec = 0;
        #2;
        
        // disp: r3 
        exec=1;
        // op = 3'b100, reg_x = 2'b11, reg_y = 2'b11, imm = 4'b0000 
        instr =  11'b10011110000;
        #6;
        // end of display r3
        // r3 = 10
        exec = 0;
        #2;
   end     
    
endmodule
