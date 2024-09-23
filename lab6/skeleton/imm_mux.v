module imm_mux( input [15:0] sw_data, rf_data,
    input sw_select,
    input rf_select,
    output reg [15:0] adder_b
    );
    
    always @(*) begin
        if (sw_select) adder_b <= sw_data;
        if (rf_select) adder_b <= rf_data;
    end
endmodule