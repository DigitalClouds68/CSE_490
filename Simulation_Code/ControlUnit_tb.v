`timescale 1ns/1ps
module ControlUnit_tb;

    reg  [3:0] opcode;
    reg  [3:0] func;
    wire       RegWrite;
    wire       MemWrite;
    wire       MemRead;
    wire       ALUSrc;
    wire       MemtoReg;
    wire       Jump;
    wire [3:0] ALUControl;
    
    ControlUnit CU (
        .opcode(opcode),
        .func(func),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .Jump(Jump),
        .ALUControl(ALUControl)
    );
    
    initial begin
        opcode = 4'b0000; func = 4'b0000; // add
        #10;
        $display("Test R-type (add): opcode=%b, func=%b", opcode, func);
        $display("  RegWrite = %b, ALUControl = %b", RegWrite, ALUControl);

        opcode = 4'b0000; func = 4'b0001; // sub
        #10;
        $display("Test R-type (sub): opcode=%b, func=%b", opcode, func);
        $display("  RegWrite = %b, ALUControl = %b", RegWrite, ALUControl);

        opcode = 4'b0000; func = 4'b0010; // sll
        #10;
        $display("Test R-type (sll): opcode=%b, func=%b", opcode, func);
        $display("  RegWrite = %b, ALUControl = %b", RegWrite, ALUControl);

        opcode = 4'b0000; func = 4'b0011; // and
        #10;
        $display("Test R-type (and): opcode=%b, func=%b", opcode, func);
        $display("  RegWrite = %b, ALUControl = %b", RegWrite, ALUControl);

        opcode = 4'b0001; func = 4'b0000; // lw
        #10;
        $display("Test lw: opcode=%b", opcode);
        $display("  RegWrite = %b, MemRead = %b, MemtoReg = %b, ALUSrc = %b, ALUControl = %b", 
                 RegWrite, MemRead, MemtoReg, ALUSrc, ALUControl);

        opcode = 4'b0010; func = 4'b0000;
        #10;
        $display("Test sw: opcode=%b", opcode);
        $display("  MemWrite = %b, ALUSrc = %b, ALUControl = %b", MemWrite, ALUSrc, ALUControl);

        opcode = 4'b0011; func = 4'b0000;
        #10;
        $display("Test addi: opcode=%b", opcode);
        $display("  RegWrite = %b, ALUSrc = %b, ALUControl = %b", RegWrite, ALUSrc, ALUControl);

        opcode = 4'b0100; func = 4'b0000;
        #10;
        $display("Test beq: opcode=%b", opcode);
        $display("  ALUSrc = %b, ALUControl = %b", ALUSrc, ALUControl);

        opcode = 4'b0101; func = 4'b0000;
        #10;
        $display("Test bne: opcode=%b", opcode);
        $display("  ALUSrc = %b, ALUControl = %b", ALUSrc, ALUControl);

        opcode = 4'b0110; func = 4'b0000;
        #10;
        $display("Test jmp: opcode=%b", opcode);
        $display("  Jump = %b", Jump);

        $finish;
    end

endmodule
