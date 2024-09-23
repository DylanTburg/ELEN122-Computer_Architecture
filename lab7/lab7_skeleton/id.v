
module id( /* instruction decode */
    input [15:0] instr,
    output [3:0] reg_src1,
    output [3:0] reg_src2,
    output [3:0] reg_dst, 
    output [3:0] imm,   
    output reg add_sub,
    output reg mem_rd,
    output reg mem_wr,
    output reg reg_wr,
    output reg imm_sel,
    output reg data_sel,
    output reg dp_en,
    output reg halt  
    );
    
    wire [3:0] opcode; 
    
    assign opcode = instr[15:12];  
    
    assign reg_dst = instr[11:8];
    assign reg_src1 = instr[7:4];
    assign reg_src2 = instr[3:0];
    assign imm = instr[3:0];   
  
    /* for other control signals */
    always@(*)
    begin
        if(opcode==4'b0000) /* load */
          begin
            add_sub = 1'b0;
            mem_rd = 1'b1;
            mem_wr = 1'b0;
            reg_wr = 1'b1;
            imm_sel = 1'b0;
            data_sel = 1'b1;
            dp_en = 1'b0;
            halt = 1'b0;
          end

	/* TODO #1: Complete the implmentation of the ID block */
        else if (opcode==4'b0001) /* move */
          begin
            add_sub = 1'b0;
            mem_rd = 1'b0;
            mem_wr = 1'b0;
            reg_wr = 1'b1;
            imm_sel = 1'b0;
            data_sel = 1'b0;
            dp_en = 1'b0;
            halt = 1'b0;
          end
                 
        else if (opcode==4'b0010) /* sub */
          begin
            add_sub = 1'b1;
            mem_rd = 1'b0;
            mem_wr = 1'b0;
            reg_wr = 1'b1;
            imm_sel = 1'b0;
            data_sel = 1'b0;
            dp_en = 1'b0;
            halt = 1'b0;
          end
                     
        else if (opcode==4'b0011) /* add */
          begin
            add_sub = 1'b0;
            mem_rd = 1'b0;
            mem_wr = 1'b0;
            reg_wr = 1'b1;
            imm_sel = 1'b0;
            data_sel = 1'b0;
            dp_en = 1'b0;
            halt = 1'b0;
          end
                  
        else if (opcode==4'b0100) /* disp */
          begin
            add_sub = 1'b0;
            mem_rd = 1'b0;
            mem_wr = 1'b0;
            reg_wr = 1'b0;
            imm_sel = 1'b0;
            data_sel = 1'b0;
            dp_en = 1'b1;
            halt = 1'b0;
          end
                  
        else if (opcode==4'b0101) /* halt */
          begin
            add_sub = 1'b0;
            mem_rd = 1'b0;
            mem_wr = 1'b0;
            reg_wr = 1'b0;
            imm_sel = 1'b0;
            data_sel = 1'b0;
            dp_en = 1'b0;
            halt = 1'b1;
          end
                  
        else if (opcode==4'b0110) /* subi */
          begin
            add_sub = 1'b1;
            mem_rd = 1'b0;
            mem_wr = 1'b0;
            reg_wr = 1'b1;
            imm_sel = 1'b1;
            data_sel = 1'b0;
            dp_en = 1'b0;
            halt = 1'b0;
          end
                  
        else if (opcode==4'b0111) /* addi */
          begin
            add_sub = 1'b0;
            mem_rd = 1'b0;
            mem_wr = 1'b0;
            reg_wr = 1'b1;
            imm_sel = 1'b1;
            data_sel = 1'b0;
            dp_en = 1'b0;
            halt = 1'b0;
          end
                    
        else if (opcode==4'b1000) /* store */
          begin
            add_sub = 1'b0;
            mem_rd = 1'b0;
            mem_wr = 1'b1;
            reg_wr = 1'b0;
            imm_sel = 1'b0;
            data_sel = 1'b1;
            dp_en = 1'b0;
            halt = 1'b0;
          end
                    
        else if (opcode==4'b1001) /* nop */
          begin
            add_sub = 1'b0;
            mem_rd = 1'b0;
            mem_wr = 1'b0;
            reg_wr = 1'b0;
            imm_sel = 1'b0;
            data_sel = 1'b0;
            dp_en = 1'b0;
            halt = 1'b0;
          end
                   
        else 
          begin
            add_sub = 1'b0;
            mem_rd = 1'b0;
            mem_wr = 1'b0;
            reg_wr = 1'b0;
            imm_sel = 1'b0;
            data_sel = 1'b0;
            dp_en = 1'b0;
            halt = 1'b0;
          end
                  
    end
    
endmodule
