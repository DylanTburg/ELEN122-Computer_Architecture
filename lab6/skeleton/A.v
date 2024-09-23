module A #(parameter bit_width=8) (input [bit_width-1:0] Ain,
         input load_en,
         output reg [bit_width-1:0] Aout);

    
    // initialized to 0
    initial begin
        Aout = 0;
    end  
    
    always@(*)
        if(load_en)
			Aout <= Ain;

endmodule