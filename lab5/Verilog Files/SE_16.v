module SE_16(
	input [3:0] imm,
	output [15:0] extended
);
           
    /* TODO #3-1: prefix the MSB 12 times */              
    assign extended = {{12{imm[3]}}, imm};
    
    
    /*{imm[3],imm[3],imm[3],imm[3],
                       imm[3],imm[3],imm[3],imm[3],
                       imm[3],imm[3],imm[3],imm[3],imm}; */
    /* end of TODO #3-1*/
    
endmodule
