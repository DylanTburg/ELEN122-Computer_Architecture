module l6_branchPC(
	input [7:0] currPC,
	input [3:0] offset,
	output [7:0] adjustedPC
);
		
        /* TODO #1: calculate the target branch address */
        /* currPC + sign-extended offset */
	assign adjustedPC = currPC + { {4{offset[3]}}, offset};	
endmodule
