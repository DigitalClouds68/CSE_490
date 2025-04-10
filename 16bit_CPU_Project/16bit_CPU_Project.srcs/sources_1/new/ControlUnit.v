module ControlUnit (
    input   wire  [3:0]  opcode,
    input   wire  [3:0]  func,
    output  reg          RegWrite,
    output  reg          MemWrite,
    output  reg          MemRead,
    output  reg          ALUSrc,
    output  reg          MemtoReg,
    output  reg          Jump,
    output  reg   [3:0]  ALUControl
);
    always @* begin
        RegWrite = 0;
        MemWrite = 0;
        MemRead  = 0;
        ALUSrc   = 0;
        MemtoReg = 0;
        Jump     = 0;
        ALUControl = 4'b0000;
        case(opcode)
            4'b0000: begin
                case(func)
                    4'b0000: ALUControl = 4'b0000; // add
                    4'b0001: ALUControl = 4'b0001; // sub
                    4'b0010: ALUControl = 4'b0010; // sll
                    4'b0011: ALUControl = 4'b0011; // and
                    
                    4'b0100: ALUControl = 4'b0100; // or
                    4'b0101: ALUControl = 4'b0101; // xor
                    default: ALUControl = 4'b0000;
                endcase
                RegWrite = 1;
            end
            4'b0001: begin // lw
                ALUControl = 4'b0000;
                RegWrite = 1;
                MemRead  = 1;
                MemtoReg = 1;
                ALUSrc   = 1;
            end
            4'b0010: begin // sw
                ALUControl = 4'b0000;
                MemWrite = 1;
                ALUSrc   = 1;
            end
            4'b0011: begin // addi
                ALUControl = 4'b0000; // add
                RegWrite = 1;
                ALUSrc   = 1;
            end
            4'b0100: begin // beq
                ALUControl = 4'b0001; // sub (to compare R[rs] - R[rt])
                ALUSrc   = 0;
            end
            4'b0101: begin // bne
                ALUControl = 4'b0001; // sub
                ALUSrc   = 0;
            end
            4'b0110: begin
                Jump = 1;
            end
        endcase
    end
endmodule
