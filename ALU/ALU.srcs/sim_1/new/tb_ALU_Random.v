`timescale 1ns / 1ps

module tb_ALU_Random();

    // 声明输入/输出端�?�(用于仿真)
    reg  [15:0] A_tb;
    reg  [15:0] B_tb;
    reg  [3:0]  ALUControl_tb;
    wire [15:0] ALUResult_tb;
    wire        zero_tb;

    // 实例化 ALU_Random
    ALU_Random uut (
        .A(A_tb),
        .B(B_tb),
        .ALUControl(ALUControl_tb),
        .ALUResult(ALUResult_tb),
        .zero(zero_tb)
    );

    initial begin
        // �?始赋值
        A_tb = 16'd0;
        B_tb = 16'd0;
        ALUControl_tb = 4'b0000;
        #10;

        // 1) 测试 AND (ALUControl=0000)
        A_tb = 16'h00FF; //  0000 0000 1111 1111
        B_tb = 16'hF0F0; //  1111 0000 1111 0000
        ALUControl_tb = 4'b0000; // AND
        #10;

        // 2) 测试 ADD (ALUControl=0010)
        A_tb = 16'd10; 
        B_tb = 16'd25; 
        ALUControl_tb = 4'b0010; // ADD
        #10;

        // 3) 测试 SUB (ALUControl=0001)
        A_tb = 16'd40; 
        B_tb = 16'd10;
        ALUControl_tb = 4'b0001; // SUB => 40-10=30
        #10;

        // 4) 测试 OR (ALUControl=0100)
        A_tb = 16'h0FF0;
        B_tb = 16'h00F0;
        ALUControl_tb = 4'b0100; // OR
        #10;

        // 5) 测试 XOR (ALUControl=0101)
        A_tb = 16'hAA55;
        B_tb = 16'h00FF;
        ALUControl_tb = 4'b0101; // XOR
        #10;

        // 6) 测试 SLL (ALUControl=0011)
        // 比如 A=1, B=4 => 1左移4�?=16 (0x0010)
        A_tb = 16'd1;
        B_tb = 16'd4;
        ALUControl_tb = 4'b0011;
        #10;

        // 7) 测试 zero 标志: �?�一次 0 结果
        A_tb = 16'd5;
        B_tb = 16'd5;
        ALUControl_tb = 4'b0001; // SUB => 0 => zero=1
        #10;

        // 仿真结�?�
        #10;
        $finish;
    end

endmodule
