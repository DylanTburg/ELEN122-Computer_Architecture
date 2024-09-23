module l7_TB();
    /* top-level design file for lab 7 */

    reg clk, rst;   // clock and reset
    
    reg reg_en;     /* register enable signals */

	wire [3:0] reg_src1;
	wire [3:0] reg_src2;
	wire [3:0] imm;
	
	/* control signals */
	
	/* control signals used in the 2nd stage (DEC) */
	wire imm_sel;      /* imm mux selection signal */
	wire dp_en;        /* disp register enable */
	
	/* control signals used in the 3rd stage (EXE) */
	wire add_sub;        /* alu control */
	wire mem_rd;
	wire mem_wr;
	wire data_sel;     /* data mux selection signal */
		
	/* control signals used in the 4th stage (WB) */
	wire [3:0] reg_dst;    /* destination register index */
	wire wrx;           /* RF write enable */
	wire halt;

	/* staging register in/out */
	wire [9:0] ctrl_id_ex_in;
	wire [9:0] ctrl_id_ex_out;
	wire [5:0] ctrl_ex_wb_in;
	wire [5:0] ctrl_ex_wb_out;

		
	/* datapath signals */
	wire [7:0] pc_out;             /* PC output: PC -> iMEM */
	wire [15:0] instr;              /* instruction: IR output */
	wire [15:0] imem_out;           /* iMEM output: iMEM -> IR */
    wire [15:0] rf_2, rf_1;         /* two rf output */	
    wire [15:0] se_imm;             /* sign-extended imm signal: SE -> imm_mux */
    wire [15:0] imm_mux_out;        /* imm mux out */
    wire [15:0] alu_out;            /* ALU out */
    wire [15:0] dmem_out;            /* dMEM out */  
    wire [15:0] data_mux_out;       /* data mux out */ 

     
    wire [15:0] a_out_data;          /* reg a output */
    wire [15:0] b_out_data;          /* reg b output */
    wire [15:0] g_out_data;          /* reg g output */    
    wire [15:0] dp_out_data;         /* reg dp output */ 

    
    /* Staging Register 0: Program Counter */
	PC pc(.clk(clk),
		  .countEn(reg_en),
		  .reset(rst),
		  .Address(pc_out));
	
		  
    /* Instruction Memory (iMEM), Read-Only */
	l7_iMEM mem(.clk(clk),
	             .address(pc_out),
	             .DataOut(imem_out));

	
	/* Staging Register 1: Instruction Register (IR) - 16-bits */             
    A #(.bit_width(16)) IR(.Ain(imem_out), .load_en(reg_en), .clk(clk), .Aout(instr));
   
    
    /* instruction decode */
    id id(.instr(instr),
        .reg_src1(reg_src1),
        .reg_src2(reg_src2),
        .reg_dst(reg_dst),
        .imm(imm),
        .add_sub(add_sub),
        .mem_rd(mem_rd),
        .mem_wr(mem_wr),
        .reg_wr(wrx),
        .imm_sel(imm_sel),
        .data_sel(data_sel),
        .dp_en(dp_en),
        .halt(halt)
    );

    /* 16-bit sign-extension */
    SE_16 se(.imm(imm), .extended(se_imm));
     
     
    /* Register File */
    l7_RF RF(.clk(clk),
          .rst(rst),
          .DataIn(g_out_data),
          .raddr_2(reg_src2),
          .raddr_1(reg_src1),
          .waddr(ctrl_ex_wb_out[5:2]), /* TODO #2-1 reg_dst*/
          .WrX(ctrl_ex_wb_out[1]), /* TODO #2-2 wrx*/
          .out_data_2(rf_2),
          .out_data_1(rf_1)
		  );

	/* imm_mux */		
	mux_2_to_1 #(.bit_width(16)) imm_mux(
	           .in0(rf_2),
               .in1(se_imm),
               .sel(imm_sel),
               .mux_output(imm_mux_out));


    /* diplay register */
     A #(.bit_width(16)) DP(
         .clk(clk), .rst(rst),
         .Ain(rf_1),
         .load_en(dp_en), 
         .Aout(dp_out_data));
   
   	/* Staging Register 2: OP_A - 16-bits, OP_B - 16-bits, CTRL - n bits? */             
     A #(.bit_width(16)) OP_A(
         .clk(clk), .rst(rst),
         .Ain(rf_1),
         .load_en(reg_en),
         .Aout(a_out_data));
 
     A #(.bit_width(16)) OP_B(
         .clk(clk), .rst(rst),
         .Ain(imm_mux_out),
         .load_en(reg_en),
         .Aout(b_out_data));

    
    /* TODO #2-3: ID -> CTRL_ID_EX */
    assign ctrl_id_ex_in[9:6] = reg_dst;
    assign ctrl_id_ex_in[5] = wrx;
    assign ctrl_id_ex_in[4] = halt;
    assign ctrl_id_ex_in[3] = add_sub; 
    assign ctrl_id_ex_in[2] = data_sel; 
    assign ctrl_id_ex_in[1] = mem_rd; 
    assign ctrl_id_ex_in[0] = mem_wr; 
       
     A #(.bit_width(10)) CTRL_ID_EX(
         .clk(clk), .rst(rst),
         .Ain(ctrl_id_ex_in), /* TODO #2-4 */
         .load_en(reg_en), 
         .Aout(ctrl_id_ex_out)); /* TODO #2-5 */
         
   	/* Execution (ALU) and Memory Accesses */
                
    ALU alu (.in_A(a_out_data),
                 .in_B(b_out_data),
                 .add_sub(ctrl_id_ex_out[3]),
                 .adder_out(alu_out));

    l7_dMEM dmem (
      .clk(clk),
      .address(a_out_data[7:0]),
      .DataIn(b_out_data),
      .MemRd(ctrl_id_ex_out[1]), /* TODO #2-6 mem_rd*/ 
      .MemWr(ctrl_id_ex_out[0]),/* TODO #2-7 mem_wr*/
      .DataOut(dmem_out)
    );

    /* data mux */         
    mux_2_to_1 #(.bit_width(16)) data_mux(
                .in0(alu_out),
                .in1(dmem_out),
                .sel(ctrl_id_ex_out[2]),
                .mux_output(data_mux_out));                 
             

   	/* Staging Register 3: G/MDR*/                      
     A #(.bit_width(16)) g(
         .clk(clk), .rst(rst),
         .Ain(data_mux_out),
         .load_en(reg_en),
         .Aout(g_out_data));
    
     /* TODO #2-8 */ 
     assign ctrl_ex_wb_in[5:2] = ctrl_id_ex_out[9:6]; /* reg_dst */
     assign ctrl_ex_wb_in[1] = ctrl_id_ex_out[5];       /* wrx */
     assign ctrl_ex_wb_in[0] = ctrl_id_ex_out[4];       /* halt */
     A #(.bit_width(6)) CTRL_EX_WB(
         .clk(clk), .rst(rst),
         .Ain(ctrl_ex_wb_in), /* TODO #2-9 */
         .load_en(reg_en),
         .Aout(ctrl_ex_wb_out)); /* TODO #2-10 */


    /* halt signal generator */
    always@(*)
    begin
      if (rst) reg_en <= 1'b1;
      else
        if (ctrl_ex_wb_out[0]) /* halt signal */
          reg_en <= 1'b0;
         
    end

             
    initial begin
        clk = 0;
		//this testbench is a bit different from the others
		//the instructinos come entirely from the program
		//to verify correctness, you will need to see that the 
		//results match what you expect from the program		
		rst = 1;
		#10;
		rst = 0;		
		#1000; 
		$finish;	
     end
                 
     always #1 clk = !clk;
     
endmodule
