module ThreeBitCounter (Done, Start, Clock, Reset, Count);
    input Start, Done, Clock, Reset;
    output reg [2:0] Count;
    reg [1:0] currState, nextState;
    always @(posedge Clock)
        if (Reset) currState = 0;
        else currState = nextState;
    always @(posedge Clock)
        if (Start) currState = 1;
        else currState = nextState; 
    always @(*)
    case (currState)
        0: if (Done) nextState = 0; else nextState = 0;
        1: if (Done) nextState = 0; else nextState = 2;
        2: if (Done) nextState = 0; else nextState = 3;
        3: if (Done) nextState = 0; else nextState = 3;
    endcase
    always @(*)
    case (currState)
        0: Count = 3'b001;
        1: Count = 3'b010;
        2: Count = 3'b011;
        3: Count = 3'b100;
    endcase
endmodule


