module l6_MEM(
	input clk,
	input [7:0] address,
	input [15:0] DataIn,
	input MemWr,
	output reg [15:0] DataOut
);
			  
	reg [15:0] mem_arr [256:0]; 
	
	initial begin
		$readmemh("mem.txt", mem_arr); 
		
		mem_arr[48] = 16'h000B; //count address. count = 11
		mem_arr[49] = 16'h0001; 
		mem_arr[50] = 16'h0002; 
		mem_arr[51] = 16'h0003; 
		mem_arr[52] = 16'h0004; 
		mem_arr[53] = 16'h0005; 
		mem_arr[54] = 16'h0006; 
		mem_arr[55] = 16'h0007; 
		mem_arr[56] = 16'h0008; 
		mem_arr[57] = 16'h0009; 
		mem_arr[58] = 16'h000A; 
		mem_arr[59] = 16'h000B;
		
	end
	
	always@(posedge clk)
	begin
		if (MemWr) mem_arr[address] <= DataIn;
	end
	
	always@(*)
	begin
		DataOut <= mem_arr[address];
	end
	
	
endmodule
