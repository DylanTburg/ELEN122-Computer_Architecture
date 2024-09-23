module data_mux(input [15:0] switch_data,
                input [15:0] G_data,
                input Gout,
                input _Extern,
                output reg [15:0] mux_output);

    always@(*)
    begin
        if(Gout)
            mux_output <= G_data;

        if(_Extern)
            mux_output <= switch_data;
            
    end
        
endmodule