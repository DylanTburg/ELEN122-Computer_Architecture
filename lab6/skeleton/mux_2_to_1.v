module mux_2_to_1 #(parameter bit_width=8) (
    input [bit_width-1:0] in0,
    input [bit_width-1:0] in1,
    input sel,
    output reg [bit_width-1:0] mux_output);

    always@(*)
        if (sel==1'b1)            
            mux_output <= in1;
        else if (sel==1'b0)
            mux_output <= in0; 
        else 
             mux_output <= 0;              
        
endmodule
