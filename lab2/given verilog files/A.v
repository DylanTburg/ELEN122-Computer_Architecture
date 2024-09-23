module A(input [3:0] Ain,
         input load_en,
         output reg [3:0] Aout);


    // initialized to 0
    initial begin
        Aout = 0;
    end  
    
    always@(*)
        if(load_en)
			Aout <= Ain;

endmodule