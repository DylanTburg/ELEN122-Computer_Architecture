module RF(input fpga_clk,
          input [3:0] DataIn,
          input [1:0] AddrX,
          input [1:0] AddrY,
          input RdX,
          input RdY,
          input WrX,
          input [3:0] sm_state,
          output reg [3:0] Dataout,
          output [6:0] seg,
          output [7:0] an);

    /*
    notes
    4 four bit registers internally - need 2 bit addr bus
    when RdX == 0 && RdY == 0, dataout <= 0
    when RdX == 1 && RdY == 1, dataout <= 0
    */
	
	reg [3:0] datastorage [3:0]; 
	
	
	initial begin
		//array initialization. See if Lewis has a preference other than zeros.
		//this is sythesizable on the xilinx toolset.
		datastorage[0] = 0;
		datastorage[1] = 0;
		datastorage[2] = 0;
		datastorage[3] = 0;
	end
	
	//instantiate the decoder so the registers can be displayed.
	wire [6:0] s0, s1, s2, s3, s4; //make sure these are 7 bits.
	bin_7seg seg0(.data(datastorage[0]), .seg(s0));
	bin_7seg seg1(.data(datastorage[1]), .seg(s1));
	bin_7seg seg2(.data(datastorage[2]), .seg(s2));
	bin_7seg seg3(.data(datastorage[3]), .seg(s3));
	bin_7seg seg7(.data(sm_state), .seg(s4));

    //Instantiate the modules needed for display
    display_driver dd(.fpga_clk(fpga_clk),
                      .display_digit0(s0),
                      .display_digit1(s1),
                      .display_digit2(s2),
                      .display_digit3(s3),
                      .display_digit7(s4),
                      .seg(seg),
                      .an(an));

   
   
   // register output
   always@(*)
   begin
        if( (RdX == 0 && RdY == 0) || (RdX == 1 && RdY == 1) )
            Dataout <= 0;
        else if (RdX ==1)
            Dataout <= datastorage[AddrX];
        else if (RdY ==1)
            Dataout <= datastorage[AddrY];
        else
            Dataout <= 0;                
   end

    // register contents update
    always@(posedge fpga_clk)
        if(WrX) //write high
            datastorage[AddrX] <= DataIn;


endmodule
