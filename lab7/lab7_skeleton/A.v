module A #(parameter bit_width=8) (
         input clk, input rst,
         input [bit_width-1:0] Ain,
         input load_en, 
         output reg [bit_width-1:0] Aout);

    
    // initialized to 0
    initial begin
        Aout = 0;
    end  
    
    always@(posedge clk)
        if(rst)
            Aout <= 0;
        else if(load_en)
			Aout <= Ain;

endmodule
