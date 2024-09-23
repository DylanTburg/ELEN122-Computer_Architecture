`timescale 1ns / 1ps

module l4_tb();

    /* clock and instruction control */
    reg clk, rst;
    /* PC enable */
    wire pc_en;  // control logic -> PC
    /* Instruction latch enable */
    wire il_en;  // control logic -> Latch I
    /* PC out: current instruction address */
    wire [7:0] pc_out;  // PC -> MEM
    /* Instruction memoery out */
    wire [15:0] imem_out; // MEM -> instr
    /* instruction: to be generated in the testbench part */
    wire [15:0] instr;   

    /*  4 different fields in an instruction */
    wire [0:3] opcode;  /* instr [15:13] */
    wire [0:1] reg_x;   /* instr [12:11] */
    wire [0:1] reg_y;   /* instr [10:9] */
    wire [0:3] imm;     /* instr [8:10] */
    
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
    
    
    
    l4_SM sm(.clk(clk),
             .reset(rst),
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
             .pc_en(pc_en),
             .ILin(il_en),
             .cur_state(smstate));
       
    wire [3:0] rf_datain, rf_dataout;
    wire [6:0] seg;
    wire [7:0] an; 
 
    /* TODO #1 
       1) instantiate the three modules: l4_PC, l4_MEM, and A (16-bit latch)     
       2) connect them each other properly using the declared signals (pc_out, imem_out, and isntr)
       3) connect the control logic singals (rst, pc_en, and il_en) properly to PC and Latch I. 
    */
    /* program counter */
    l4_PC pc (
	.clk(clk),
	.countEn(pc_en),
	.reset(rst),
	.Address(pc_out));
	
    /* instruction memory */
    l4_MEM imem(
	.count(pc_out),
	.Data(imem_out));
    
    /* instruction latch */
    A #(.bit_width(16)) ilatch(.Ain(imem_out),
          .load_en(il_en),
          .Aout(instr));

    /* end of TODO #1 */

    /* instruction decode */
    assign opcode = instr[15:13];
    assign reg_x = instr[12:11];
    assign reg_y = instr[10:9];
    assign imm = instr[8:5];
    
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
           
     A #(.bit_width(4)) a(.Ain(rf_dataout),
         .load_en(ain),
         .Aout(a_out_data));
         
     A #(.bit_width(4)) g(.Ain(adder_out),
         .load_en(gin),
         .Aout(g_out_data));
         
     A #(.bit_width(4)) dp(.Ain(rf_dataout),
          .load_en(dpin),
          .Aout(dp_out_data));
         

     
     l2_adder adder(.in_A(a_out_data),
                    .in_B(mux2_output),
                    .add_sub(add_sub),
                    .adder_out(adder_out));
                    
     modified_mux m1(.input_data(imm),
                .G_data(g_out_data),
                .Gout(gout),
                ._Extern(extern),
                .mux_output(rf_datain));
  
     mux_2_to_1     #(.bit_width(4))
                    m2( .in0(rf_dataout),
                    .in1(imm),
                    .sel(iout),
                    .mux_output(mux2_output));                 
    
    // clock generation
    initial begin
        clk = 0;
    end    
    always #1 clk = !clk;
    
    // reset generation
    always begin
        rst = 1; #2;
        rst = 0; #200;
    end

    
endmodule
