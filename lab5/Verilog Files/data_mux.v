module data_mux(input [15:0] switch_data, // data from mem
                input [15:0] G_data,	  // data from latch G (ALU)	
                input Gout,
                input _Extern,
                output reg [15:0] mux_output);

    always@(*)
    begin
	/* TODO #2-1: complete the design of Data MUX */
	/* if Gout == 1 and switch_data == 0 G_data is chosen for output */
        if(Gout) mux_output <= G_data;
        if(_Extern) mux_output <= switch_data;
  
	/* if Gout == 0 and switch_data == 1 switch_data is chosen for output */
	/* if both are 0, output is just deasserted */
	/* end of TODO #2-1 */
    end
        
endmodule
