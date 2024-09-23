module l7_RF(
	input clk,
	input rst,
	input [15:0] DataIn,
	input [3:0] raddr_2,
	input [3:0] raddr_1,
	input [3:0] waddr,
	input WrX,
	output [15:0] out_data_2,
	output [15:0] out_data_1
);

	reg [15:0] datastorage [15:0]; 

	always@(posedge clk)
	begin

		if(rst)
		begin
			datastorage[0]  <= 16'habcd;
			datastorage[1]  <= 16'habcd;
			datastorage[2]  <= 16'habcd;
			datastorage[3]  <= 16'habcd;
			datastorage[4]  <= 16'habcd;
			datastorage[5]  <= 16'habcd;
			datastorage[6]  <= 16'habcd;
			datastorage[7]  <= 16'habcd;
			datastorage[8]  <= 16'habcd;
			datastorage[9]  <= 16'habcd;
			datastorage[10] <= 16'habcd;
			datastorage[11] <= 16'habcd;
			datastorage[12] <= 16'habcd;
			datastorage[13] <= 16'habcd;
			datastorage[14] <= 16'habcd;
			datastorage[15] <= 16'habcd;
		end

		else if(WrX) //write high
			datastorage[waddr] <= DataIn;

	end

	assign out_data_2 = datastorage[raddr_2];
	assign out_data_1 = datastorage[raddr_1];

/*	assign regdata = {datastorage[15],
					  datastorage[14],
					  datastorage[13],
					  datastorage[12],
					  datastorage[11],
					  datastorage[10],
					  datastorage[9],
					  datastorage[8],
					  datastorage[7],
					  datastorage[6],
					  datastorage[5],
					  datastorage[4],
					  datastorage[3],
					  datastorage[2],
					  datastorage[1],
					  datastorage[0]};
  */
    

endmodule
