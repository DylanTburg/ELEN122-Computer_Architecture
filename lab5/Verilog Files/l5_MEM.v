module l5_MEM(
	input clk,
	input [7:0] address,
	input [15:0] DataIn,
	input MemWr,
	output reg [15:0] DataOut
);
			  
	reg [15:0] mem_arr [256:0]; 
	
	initial begin
		$readmemh("mem.txt", mem_arr); 
		
		mem_arr[48] = 16'h1234; //decimal 4660
		mem_arr[49] = 16'h789A; //decimal 30874
		mem_arr[50] = 16'd128;  //4660+30874=35534 (hex 8ACE) into address 128 
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
