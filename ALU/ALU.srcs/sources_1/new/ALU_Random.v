`timescale 1ns/1ps

module ALU_Random
(
    input  wire [15:0] A, // register A
    input  wire [15:0] B, // register B
    input  wire [3:0]  ALUControl, 
    output reg  [15:0] ALUResult,
    output wire        zero
);
    always @(*) begin
        case(ALUControl)
            4'b0000: ALUResult = A & B;       // and
            4'b0001: ALUResult = A - B;       // sub
            4'b0010: ALUResult = A + B;       // add
            4'b0011: ALUResult = A << B[3:0];      // sll
            // still have or, xor, nor, slt....
            4'b0100: ALUResult = A | B;    // or
            4'b0101: ALUResult = A ^ B;    // xor
            default: ALUResult = 16'hxxxx;
        endcase
    end

    assign zero = (ALUResult == 16'b0);
endmodule
