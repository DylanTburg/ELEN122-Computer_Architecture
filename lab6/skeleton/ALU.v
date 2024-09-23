module ALU (input [15:0] in_A,
            input [15:0] in_B,
            input add_sub,
            output reg [15:0] adder_out);

	always@(*)
	begin
	
		if(add_sub == 0) // 0: add
		begin
			adder_out <= in_A + in_B;
		end
		
		else              // 1: sub
		begin
			adder_out <= in_A - in_B;
		end
		
	end
	
endmodule