module l6_branch(
	input bnz, /* asserted if the instruction is bnz */
	input bz,  /* asserted if the instruction is bz */
	input [15:0] rf_data_in,
	output reg branch  /* output: assert if the branch condition is fulfilled */
);
		
  /* TODO #2: complete the following */
  always@(*)
  begin
    if(bnz==1)  /* if the instruction is bnz? */
        if(rf_data_in==0) branch=0; 
        else branch=1;        
    else if (bz==1) /* if the instruction is bz */
        if(rf_data_in==0) branch=1;
        else branch=0;
    else /* if the instruction is not a branch-related one? */
        branch=0;
    
  end
	
endmodule
