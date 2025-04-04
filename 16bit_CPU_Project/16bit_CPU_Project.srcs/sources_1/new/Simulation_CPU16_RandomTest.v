`timescale 1ns/1ps
module CPU16_tb;
    reg clk;
    reg reset;

    CPU16 cpu(
        .clk(clk), 
        .reset(reset)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    integer i;
    initial begin
        for(i=0; i<64; i=i+1) cpu.IM.memory[i] = 16'h0000;
        cpu.IM.memory[0]  = 16'h3105;  // addi r1, r0, 5
        cpu.IM.memory[1]  = 16'h3203;  // addi r2, r0, 3
        cpu.IM.memory[2]  = 16'h0120;  // add   r1, r2
        cpu.IM.memory[3]  = 16'h0121;  // sub   r1, r2
        cpu.IM.memory[4]  = 16'h3406;  // addi  r4, r0, 6
        cpu.IM.memory[5]  = 16'h0413;  // and   r4, r1
        cpu.IM.memory[6]  = 16'h0422;  // sll   r4, r2
        cpu.IM.memory[7]  = 16'h3604;  // addi  r6, r0, 4
        cpu.IM.memory[8]  = 16'h2102;  // sw    r1, r0, 2
        cpu.IM.memory[9]  = 16'h1502;  // lw    r5, r0, 2
        cpu.IM.memory[10] = 16'h2162;  // sw    r1, r6, 2
        cpu.IM.memory[11] = 16'h1762;  // lw    r7, r6, 2
        cpu.IM.memory[12] = 16'h4571;  // beq   r5, r7, +1
        cpu.IM.memory[13] = 16'h3401;  // addi  r4, r0, 1
        cpu.IM.memory[14] = 16'h5251;  // bne   r2, r5, +1
        cpu.IM.memory[15] = 16'h3601;  // addi  r6, r0, 1
        cpu.IM.memory[16] = 16'h6001;  // jmp
        cpu.IM.memory[17] = 16'h3207;  // addi  r2, r0, 7
        cpu.IM.memory[18] = 16'h3000;  // addi  r0, r0, 0

        reset = 1;
        #5;
        @(posedge clk);
        #1 reset = 0;

        #(300);

    end
endmodule
