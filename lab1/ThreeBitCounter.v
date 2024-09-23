module ThreeBitCounter (Direction, Clock, Reset, Count);
    input Direction, Clock, Reset;
    output reg [2:0] Count;
    reg [1:0] currState, nextState;
    always @(posedge Clock)
        if (Reset) currState = 0;
        else currState = nextState;
    always @(*)
    case (currState)
        0: if (Direction==1) nextState = 1; else nextState = 3;
        1: if (Direction==1) nextState = 2; else nextState = 0;
        2: if (Direction==1) nextState = 3; else nextState = 1;
        3: if (Direction==1) nextState = 0; else nextState = 2;
    endcase
    always @(*)
    case (currState)
        0: Count = 3'b001;
        1: Count = 3'b010;
        2: Count = 3'b011;
        3: Count = 3'b100;
    endcase
endmodule

