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
        // Default values (safe defaults)
        RegWrite = 0;
        MemWrite = 0;
        MemRead  = 0;
        ALUSrc   = 0;
        MemtoReg = 0;
        Jump     = 0;
        ALUControl = 4'b0000;
        case(opcode)
            4'b0000: begin // R-type instruction
                // Determine ALU operation from function code
                case(func)
                    4'b0000: ALUControl = 4'b0000; // add
                    4'b0001: ALUControl = 4'b0001; // sub
                    4'b0010: ALUControl = 4'b0010; // sll
                    4'b0011: ALUControl = 4'b0011; // and
                    4'b0100: ALUControl = 4'b0100; // or (optional)
                    4'b0101: ALUControl = 4'b0101; // xor (optional)
                    default: ALUControl = 4'b0000;
                endcase
                RegWrite = 1;
                // MemRead, MemWrite already 0 by default, ALUSrc=0, MemtoReg=0
            end
            4'b0001: begin // lw
                ALUControl = 4'b0000; // use add to calculate address
                RegWrite = 1;
                MemRead  = 1;
                MemtoReg = 1; // write data comes from memory
                ALUSrc   = 1; // B input is immediate
            end
            4'b0010: begin // sw
                ALUControl = 4'b0000; // add for address
                MemWrite = 1;
                ALUSrc   = 1; // B input is immediate
            end
            4'b0011: begin // addi
                ALUControl = 4'b0000; // add
                RegWrite = 1;
                ALUSrc   = 1; // immediate as operand
            end
            4'b0100: begin // beq
                ALUControl = 4'b0001; // sub (to compare R[rs] - R[rt])
                ALUSrc   = 0;
                // RegWrite, MemWrite remain 0
            end
            4'b0101: begin // bne
                ALUControl = 4'b0001; // sub
                ALUSrc   = 0;
            end
            4'b0110: begin // jmp
                Jump = 1;
                // No RegWrite, no memory ops
            end
            // Other opcodes can be handled here if extended
        endcase
    end
endmodule
