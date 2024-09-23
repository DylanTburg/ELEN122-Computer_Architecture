module modified_mux(input [3:0] input_data,
                input [3:0] G_data,
                input Gout,
                input _Extern,
                output reg [3:0] mux_output);

    always@(*)
        if (Gout==1'b1 && _Extern!=1'b1)            
            mux_output <= G_data;
        else if (Gout!=1'b1 && _Extern==1'b1)
            mux_output <= input_data; 
        else 
             mux_output <= 4'b0000;              
        
endmodule