module ALU (
    input   wire  [15:0]  A,
    input   wire  [15:0]  B,
    input   wire  [3:0]   ALUControl,
    output  reg   [15:0]  ALUOut,
    output  reg           Zero
);
    always @* begin
        case (ALUControl)
            4'b0000: ALUOut = A + B;    // add
            4'b0001: ALUOut = A - B;    // sub
            4'b0010: ALUOut = B << A;   // sll
            4'b0011: ALUOut = A & B;    // AND
            4'b0100: ALUOut = A | B;    // OR
            4'b0101: ALUOut = A ^ B;    // XOR
            default: ALUOut = 16'h0000;
        endcase
        // (Not sure if it's usable)Zero flag is true if result is zero
        Zero = (ALUOut == 16'h0000) ? 1'b1 : 1'b0;
    end
endmodule
