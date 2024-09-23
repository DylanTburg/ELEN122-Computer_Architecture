module l4_MEM(
	input [7:0] count,
	output reg [15:0] Data
);

	//capping programs to 256 (16 bit) instructions
	//this will make synthesis/implementation faster
	
	reg [15:0] instructions [20:0];
	
	initial begin
		$readmemb("instructions.mem", instructions); 
		
		//alternatively - read in hex format if you prefer
		//$readmemh("instructions_hex.txt", instructions);
	end
	
	always@(*)
	begin
		Data <= instructions[count];
	end
	
endmodule
