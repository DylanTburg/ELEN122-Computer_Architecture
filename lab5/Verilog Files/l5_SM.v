//this actually the L3_SM
//we add halt, rename idle to be fetch
module l5_SM(input clk,
			 input reset, 
			 input [3:0] operation,
			 output reg _Extern,
			 output reg Gout,
			 output reg Ain,
			 output reg Gin,
			 output reg DPin,
			 output reg RdX,
			 output reg RdY,
			 output reg WrX,
			 output reg add_sub,
			 output reg pc_en,
			 output reg ILin,
			 output reg rf_sel,
			 output reg sw_sel,
			 output reg MemWr,
			 output reg AddrSel,
			 output [3:0] cur_state);
			
    // state definitions
	parameter FETCH        =  4'b0000;
	parameter DECODE       =  4'b0001;
	parameter LOAD         =  4'b0010;
	parameter READ_Y       =  4'b0011;
	parameter READ_X       =  4'b0100;
	parameter ADD          =  4'b0101;
	parameter SUB          =  4'b0110;
	parameter MV           =  4'b0111;
	parameter WRITE_X      =  4'b1000;
	parameter ADDI         =  4'b1001;
	parameter SUBI         =  4'b1010;
	parameter DISP         =  4'b1011;
	parameter HALT         =  4'b1100;
	parameter STORE        =  4'b1101;
	
	reg [3:0] state = FETCH;
	assign cur_state = state;


	always@(*)
	begin
	   case(state)
	       FETCH:
	           begin
	               _Extern = 1'b0;
	               Gout = 1'b0;
	               //Iout = 1'b0;
	               Ain = 1'b0;
	               Gin = 1'b0;
	               DPin = 1'b0;
	               RdX = 1'b0;
	               RdY = 1'b0;
	               WrX = 1'b0;
	               add_sub = 1'b0;
	               pc_en = 1'b1;
	               ILin = 1'b1;
	               rf_sel = 1'b0;	/* TODO #4: complete the control logic output */
                   sw_sel = 1'b0;	/* TODO #4: complete the control logic output */
                   MemWr = 1'b0;	/* TODO #4: complete the control logic output */
                   AddrSel = 1'b0;	/* TODO #4: complete the control logic output */
	           end
	       DECODE:
	           begin
	               _Extern = 1'b0;
	               Gout = 1'b0;
	               //Iout = 1'b0;
	               Ain = 1'b0;
	               Gin = 1'b0;
	               DPin = 1'b0;
	               RdX = 1'b0;
	               RdY = 1'b0;
	               WrX = 1'b0;
	               add_sub = 1'b0;
	               pc_en = 1'b0;
	               ILin = 1'b0;
	               rf_sel = 1'b0; /* TODO #4 */		 
                   sw_sel = 1'b0; /* TODO #4 */
                   MemWr = 1'b0; /* TODO #4 */
                   AddrSel = 1'b0; /* TODO #4 */
	           end
	       LOAD:
	           begin
	               _Extern = 1'b1;
	               Gout = 1'b0;
	               //Iout = 1'b0;
	               Ain = 1'b0;
	               Gin = 1'b0;
	               DPin = 1'b0;
	               RdX = 1'b0;
	               RdY = 1'b0;
	               WrX = 1'b1;
	               add_sub = 1'b0;
	               pc_en = 1'b0;
	               ILin = 1'b0;
	               rf_sel = 1'b0; /* TODO #4 */
                   sw_sel = 1'b0; /* TODO #4 */
                   MemWr = 1'b0; /* TODO #4 */
                   AddrSel = 1'b1; /* TODO #4 */
	           end	   
	       READ_Y:
	           begin
	               _Extern = 1'b0;
	               Gout = 1'b0;
	               //Iout = 1'b0;
	               Ain = 1'b1;
	               Gin = 1'b0;
	               DPin = 1'b0;
	               RdX = 1'b0;
	               RdY = 1'b1;
	               WrX = 1'b0;
	               add_sub = 1'b0;
	               pc_en = 1'b0;
	               ILin = 1'b0;
	               rf_sel = 1'b0; /* TODO #4 */
                   sw_sel = 1'b0; /* TODO #4 */
                   MemWr = 1'b0; /* TODO #4 */
                   AddrSel = 1'b0; /* TODO #4 */
	           end	   
	       READ_X:
	           begin
	               _Extern = 1'b0;
	               Gout = 1'b0;
	               //Iout = 1'b0;
	               Ain = 1'b1;
	               Gin = 1'b0;
	               DPin = 1'b0;
	               RdX = 1'b1;
	               RdY = 1'b0;
	               WrX = 1'b0;
	               add_sub = 1'b0;
	               pc_en = 1'b0;
	               ILin = 1'b0;
	               rf_sel = 1'b0; /* TODO #4 */
                   sw_sel = 1'b0; /* TODO #4 */
                   MemWr = 1'b0; /* TODO #4 */
                   AddrSel = 1'b0; /* TODO #4 */
	           end	  
	       ADD:
	           begin
	               _Extern = 1'b0;
	               Gout = 1'b0;
	               //Iout = 1'b0;
	               Ain = 1'b0;
	               Gin = 1'b1;
	               DPin = 1'b0;
	               RdX = 1'b1;
	               RdY = 1'b0;
	               WrX = 1'b0;
	               add_sub = 1'b0;
	               pc_en = 1'b0;
	               ILin = 1'b0;
	               rf_sel = 1'b1; /* TODO #4 */
                   sw_sel = 1'b0; /* TODO #4 */
                   MemWr = 1'b0; /* TODO #4 */
                   AddrSel = 1'b0; /* TODO #4 */
	           end	
	       SUB:
	           begin
	               _Extern = 1'b0;
	               Gout = 1'b0;
	               //Iout = 1'b0;
	               Ain = 1'b0;
	               Gin = 1'b1;
	               DPin = 1'b0;
	               RdX = 1'b0;
	               RdY = 1'b1;
	               WrX = 1'b0;
	               add_sub = 1'b1;
	               pc_en = 1'b0;
	               ILin = 1'b0;
	               rf_sel = 1'b1; /* TODO #4 */
                   sw_sel = 1'b0; /* TODO #4 */
                   MemWr = 1'b0; /* TODO #4 */
                   AddrSel = 1'b0; /* TODO #4 */
	           end
	       MV:
	           begin
	               _Extern = 1'b0;
	               Gout = 1'b0;
	               //Iout = 1'b0;
	               Ain = 1'b0;
	               Gin = 1'b1;
	               DPin = 1'b0;
	               RdX = 1'b0;
	               RdY = 1'b0;
	               WrX = 1'b0;
	               add_sub = 1'b0;
	               pc_en = 1'b0;
	               ILin = 1'b0;
	               rf_sel = 1'b1; /* TODO #4 */
                   sw_sel = 1'b0; /* TODO #4 */
                   MemWr = 1'b0; /* TODO #4 */
                   AddrSel = 1'b0; /* TODO #4 */
	           end
	       WRITE_X:
	           begin
	               _Extern = 1'b0;
	               Gout = 1'b1;
	               //Iout = 1'b0;
	               Ain = 1'b0;
	               Gin = 1'b0;
	               DPin = 1'b0;
	               RdX = 1'b0;
	               RdY = 1'b0;
	               WrX = 1'b1;
	               add_sub = 1'b0;
	               pc_en = 1'b0;
	               ILin = 1'b0;
	               rf_sel = 1'b0; /* TODO #4 */
                   sw_sel = 1'b0; /* TODO #4 */
                   MemWr = 1'b0; /* TODO #4 */
                   AddrSel = 1'b0; /* TODO #4 */
	           end	           
	       HALT:
	           begin
	               _Extern = 1'b0;
	               Gout = 1'b0;
	               //Iout = 1'b0;
	               Ain = 1'b0;
	               Gin = 1'b0;
	               DPin = 1'b0;
	               RdX = 1'b0;
	               RdY = 1'b0;
	               WrX = 1'b0;
	               add_sub = 1'b0;
	               pc_en = 1'b0;
	               ILin = 1'b0;
	               rf_sel = 1'b0; /* TODO #4 */
                   sw_sel = 1'b0; /* TODO #4 */
                   MemWr = 1'b0; /* TODO #4 */
                   AddrSel = 1'b0; /* TODO #4 */
	           end
	       DISP:
	           begin
	               _Extern = 1'b0;
	               Gout = 1'b0;
	               //Iout = 1'b0;
	               Ain = 1'b0;
	               Gin = 1'b0;
	               DPin = 1'b1;
	               RdX = 1'b1;
	               RdY = 1'b0;
	               WrX = 1'b0;
	               add_sub = 1'b0;
	               pc_en = 1'b0;
	               ILin = 1'b0;
	               rf_sel = 1'b0; /* TODO #4 */
                   sw_sel = 1'b0; /* TODO #4 */
                   MemWr = 1'b0; /* TODO #4 */
                   AddrSel = 1'b0; /* TODO #4 */
	           end	 
	       ADDI:
	           begin
	               _Extern = 1'b0;
	               Gout = 1'b0;
	               //Iout = 1'b1;
	               Ain = 1'b0;
	               Gin = 1'b1;
	               DPin = 1'b0;
	               RdX = 1'b0;
	               RdY = 1'b0;
	               WrX = 1'b0;
	               add_sub = 1'b0;
	               pc_en = 1'b0;
	               ILin = 1'b0;
	               rf_sel = 1'b0; /* TODO #4 */
                   sw_sel = 1'b1; /* TODO #4 */
                   MemWr = 1'b0; /* TODO #4 */
                   AddrSel = 1'b0; /* TODO #4 */
	           end	
	       SUBI:
	           begin
	               _Extern = 1'b0;
	               Gout = 1'b0;
	               //Iout = 1'b1;
	               Ain = 1'b0;
	               Gin = 1'b1;
	               DPin = 1'b0;
	               RdX = 1'b0;
	               RdY = 1'b0;
	               WrX = 1'b0;
	               add_sub = 1'b1;
	               pc_en = 1'b0;
	               ILin = 1'b0;
	               rf_sel = 1'b0; /* TODO #4 */
                   sw_sel = 1'b1; /* TODO #4 */
                   MemWr = 1'b0; /* TODO #4 */
                   AddrSel = 1'b0; /* TODO #4 */
	           end    
	       STORE:
	           begin
	               _Extern = 1'b0;
	               Gout = 1'b0;
	               //Iout = 1'b1;
	               Ain = 1'b0;
	               Gin = 1'b0;
	               DPin = 1'b0;
	               RdX = 1'b0;
	               RdY = 1'b0;
	               WrX = 1'b0;
	               add_sub = 1'b0;
	               pc_en = 1'b0;
	               ILin = 1'b0;
	               rf_sel = 1'b0; /* TODO #4 */
                   sw_sel = 1'b0; /* TODO #4 */
                   MemWr = 1'b1; /* TODO #4 */
                   AddrSel = 1'b1; /* TODO #4 */
	           end      
	   endcase
	end



/*
opcode encodings
0000 - load
0001 - move
0010 - subtract
0011 - add
0100 - disp
0101 - HALT
0110 - subi
0111 - addi
1000 - store
*/
			 
	always@(posedge clk or posedge reset)
	begin
		
		if (reset==1) state <= FETCH;
		else 
		case(state)
			FETCH:   
			             state <= DECODE;
			DECODE:   
					if(operation == 4'b0000) state <= LOAD;
					else if(operation == 4'b0001) state <= READ_Y;
					else if(operation == 4'b0010) state <= READ_X;
					else if(operation == 4'b0011) state <= READ_Y;
					else if(operation == 4'b0100) state <= DISP;
					else if(operation == 4'b0101) state <= HALT;
					else if(operation == 4'b0110) state <= READ_X;
					else if(operation == 4'b0111) state <= READ_X;
					else if(operation == 4'b1000) state <= STORE;
					else state <= FETCH;				  
			LOAD: 
					state <= FETCH;
			READ_Y:
						if(operation == 4'b0001) state <= MV;
						else if(operation == 4'b0011) state <= ADD;
						else state <= READ_Y;
			READ_X:
						if(operation == 4'b0010) state <= SUB;
						else if(operation == 4'b0110) state <= SUBI;
						else if(operation == 4'b0111) state <= ADDI;
						else state <= READ_X;	
			ADD: 
					state <= WRITE_X;				 
			SUB:
					state <= WRITE_X;
			MV:
					state <= WRITE_X;
			WRITE_X: 
					state <= FETCH;				 
			DISP: 					
					state <= FETCH;
			ADDI: 					
					state <= WRITE_X;			
			SUBI:
			        state <= WRITE_X;
			STORE:
			        state <= FETCH;
			HALT:
			        state <= HALT;
			        	  
			default: state <= FETCH;
			
		endcase
				
	end //end always			 
			 
			 
endmodule

