module SE_16(
	input [3:0] imm,
	output [15:0] extended
);
                         
    assign extended = { {12{imm[3]}}, imm};
    
endmodule
