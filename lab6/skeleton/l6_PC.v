module l6_PC(
	input clk,
	input countEn,
	input reset,
	input loadNewPC,
	input [7:0] newPC,
	output reg [7:0] Address
);

        
    always@(posedge clk)
    begin
        if(reset)
            Address <= 0;        
        else if(loadNewPC)
			Address <= newPC;   
        else if(countEn)
              Address <= Address + 1;
    end
	
endmodule