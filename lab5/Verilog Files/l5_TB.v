module l5_TB();
    /* top-level design file for lab 5 */

    reg clk, rst;   // clock and reset
  
    //state machine signals

    wire [3:0] smstate; 
    
    wire [15:0] IM_out;
	
	/* decoded instruction signals: see the instruction encoding */
	wire [3:0] opcode;
	wire [3:0] reg_dst;
	wire [3:0] reg_src1;
	wire [3:0] reg_src2;
	wire [3:0] imm;
	
	/* control signals */
	wire extern;       /* d_mux selection signal 1 */
	wire gout;         /* d_mux selection signal 2 */
	wire ain;          /* latch a enable */
	wire gin;          /* latch g enable */
	wire din;          /* latch dp enable */
	wire rdx, rdy;      /* read register enable: will not be used */
	wire pc_en;        /* PC enable */
	wire il_en;        /* Instruction latch enable */
	wire addr_sel;     /* Mem Mux selection signal */
	wire mem_wr;        /* Memory write enable */
	wire wrx;           /* RF write enable */
	wire add_sub;        /* alu control */
	wire rf_sel;       /* imm_mux selection signal 1 */
	wire sw_sel;       /* imm_mux selection singal 2 */
		
	/* datapath signals */
	wire [7:0] pc_out;             /* PC output: PC -> Mem Mux */
    	wire [7:0] rfaddr;              /* address from RF */
    	wire [7:0] mm_out;              /* memory mux output: Mem Mux -> MEM */
	wire [15:0] mem_out;           /* MEM output: MEM -> ilatch or MEM -> d_mux */
    	wire [15:0] rf_2, rf_1;         /* two rf output */	
    	wire [15:0] se_imm;             /* sign-extended imm signal: SE -> imm_mux */
    	wire [15:0] mout;               /* data mux (d_mux) out */
    	wire [15:0] alu_out;            /* ALU out: ALU -> latch g */
    
    	wire [15:0] instr;              /* instruction: ilatch output */

    	wire [15:0] a_out_data;          /* latch a output */
    	wire [15:0] g_out_data;          /* latch g output */    
    	wire [15:0] dp_out_data;         /* latch dp output */ 

    
	PC pc(.clk(clk),
		  .countEn(pc_en),
		  .reset(rst),
		  .Address(pc_out));
	
	
    /* TODO #1: Instatiate Memory Mux */
    assign rfaddr = rf_1[7:0];
    mux_2_to_1 #(.bit_width(8)) 
                mm(
                .in0(pc_out),
				.in1(rfaddr),
				.sel(addr_sel),
				.mux_output(mm_out)
				);
    /* end of TODO #1 */



    /* Memory (MEM) */
	l5_MEM mem(.clk(clk),
	             .address(mm_out),
	             .DataIn(rf_2),
	             .MemWr(mem_wr),
	             .DataOut(mem_out));
	
	/* instruction latch */             
    A #(.bit_width(16)) ilatch(.Ain(mem_out), .load_en(il_en), .Aout(instr));
    
    /* instruction decode */
    assign opcode = instr[15:12];
    assign reg_dst = instr[11:8];
    assign reg_src1 = instr[7:4];
    assign reg_src2 = instr[3:0];
    assign imm = instr[3:0];  

    /* 16-bit sign-extension */
    SE_16 se(.imm(imm), .extended(se_imm));
    
    l5_SM sm(.clk(clk),
             .reset(rst),
             .operation(opcode),
             ._Extern(extern),
             .Gout(gout),
             .Ain(ain),
             .Gin(gin),
			 .DPin(din),
             .RdX(rdx),
             .RdY(rdy),
             .WrX(wrx),
             .add_sub(add_sub),
			 .rf_sel(rf_sel),
			 .sw_sel(sw_sel),
			 .pc_en(pc_en),
			 .ILin(il_en),
			 .MemWr(mem_wr),
			 .AddrSel(addr_sel),
             .cur_state(smstate));
     
     
    l5_RF RF(.clk(clk),
          .rst(rst),
          .DataIn(mout),
          .raddr_2(reg_src2),
          .raddr_1(reg_src1),
          .waddr(reg_dst),
          .WrX(wrx),
          .out_data_2(rf_2),
          .out_data_1(rf_1)
		  );
                
    ALU alu (.in_A(a_out_data),
                 .in_B(IM_out),
                 .add_sub(add_sub),
                 .adder_out(alu_out));

     A #(.bit_width(16)) a(.Ain(rf_1),
         .load_en(ain),
         .Aout(a_out_data));
         
     A #(.bit_width(16)) g(.Ain(alu_out),
         .load_en(gin),
         .Aout(g_out_data));
         
     A #(.bit_width(16)) dp(.Ain(rf_1),
          .load_en(din),
          .Aout(dp_out_data));
    
    /* TODO #2-2: instantiate the data MUX (data_mux.v) */ 
        data_mux d_mux(
                .switch_data(mem_out),
				.G_data(g_out_data),
				.Gout(gout),
				._Extern(extern),
				.mux_output(mout)
       );
    /* end of TODO #2-2 */

    /* TODO #3-2: instantiate the imm mux (imm_mux.v) */	
	imm_mux imm_mux(.sw_data(se_imm),
	            .rf_data(rf_2),
                .sw_select(sw_sel),
                .rf_select(rf_sel),
                .adder_b(IM_out)
    );
    /* end of TODO #3-2 */

             
    initial begin
        clk = 0;
		//this testbench is a bit different from the others
		//the instructinos come entirely from the program
		//to verify correctness, you will need to see that the 
		//results match what you expect from the program		
		rst = 1;
		#20;
		rst = 0;		
		#1000; 
		$finish;	
     end
                 
     always #1 clk = !clk;
     
endmodule
