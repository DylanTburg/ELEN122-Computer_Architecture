module l7_iMEM(
	input clk,
	input [7:0] address,
	output reg [15:0] DataOut
);
			  
	reg [15:0] mem_arr [256:0]; 
	
	initial begin
		$readmemh("imem.txt", mem_arr); 
		
	end
	
	always@(*)
	begin
		DataOut <= mem_arr[address];
	end
	
	
endmodule
