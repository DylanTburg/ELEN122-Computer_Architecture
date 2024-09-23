module PC(
	input clk,
	input countEn,
	input reset,
	output reg [7:0] Address
);


    always@(posedge clk)
    begin
        if(reset)
        begin
            Address <= 0;
        end
        
        else if(countEn)
        begin
              Address <= Address + 1;
        end
    end
	
endmodule
