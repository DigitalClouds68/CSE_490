`timescale 1ns/1ps
module CPU16_tb;
    reg clk;
    reg reset;
    // Instantiate the CPU
    CPU16 cpu(
        .clk(clk), 
        .reset(reset)
    );

    initial clk = 0;
    always #5 clk = ~clk;  // 10ns clock period (100 MHz)

    integer i;
    initial begin
        // Initialize instruction memory with a test program
        for(i=0; i<64; i=i+1) cpu.IM.memory[i] = 16'h0000;  // clear memory
        // Program: this sequence will test each instruction type
        cpu.IM.memory[0]  = 16'h3105;  // addi r1, r0, 5      ; R1 = 5
        cpu.IM.memory[1]  = 16'h3203;  // addi r2, r0, 3      ; R2 = 3
        cpu.IM.memory[2]  = 16'h0120;  // add   r1, r2        ; R1 = R1 + R2  (5+3=8)
        cpu.IM.memory[3]  = 16'h0121;  // sub   r1, r2        ; R1 = R[rs]-R[rt] = R2 - R1 (3-8 = -5)
        cpu.IM.memory[4]  = 16'h3406;  // addi  r4, r0, 6     ; R4 = 6
        cpu.IM.memory[5]  = 16'h0413;  // and   r4, r1        ; R4 = R4 & R1  (6 & -5)
        cpu.IM.memory[6]  = 16'h0422;  // sll   r4, r2        ; R4 = R4 << R2 (R4 << 3)
        cpu.IM.memory[7]  = 16'h3604;  // addi  r6, r0, 4     ; R6 = 4 (base address)
        cpu.IM.memory[8]  = 16'h2102;  // sw    r1, r0, 2     ; Mem[0+2] = R1 (-5)
        cpu.IM.memory[9]  = 16'h1502;  // lw    r5, r0, 2     ; R5 = Mem[0+2] (should load -5)
        cpu.IM.memory[10] = 16'h2162;  // sw    r1, r6, 2     ; Mem[R6+2] = R1 (-5 at addr 6)
        cpu.IM.memory[11] = 16'h1762;  // lw    r7, r6, 2     ; R7 = Mem[4+2] (load -5 from addr 6)
        cpu.IM.memory[12] = 16'h4571;  // beq   r5, r7, +1    ; if R5 == R7 (they are both -5) branch +1
        cpu.IM.memory[13] = 16'h3401;  // addi  r4, r0, 1     ; R4 = 1  (should be skipped by beq)
        cpu.IM.memory[14] = 16'h5251;  // bne   r2, r5, +1    ; if R2 != R5 (3 != -5) branch +1
        cpu.IM.memory[15] = 16'h3601;  // addi  r6, r0, 1     ; R6 = 1  (should be skipped by bne)
        cpu.IM.memory[16] = 16'h6001;  // jmp   +1            ; jump to the instruction after next (skip one)
        cpu.IM.memory[17] = 16'h3207;  // addi  r2, r0, 7     ; R2 = 7  (should be skipped by jmp)
        cpu.IM.memory[18] = 16'h3000;  // addi  r0, r0, 0     ; NOP (just to end program gracefully)

        // Apply reset
        reset = 1;
        #5;   // wait for half clock (to trigger PC reset at clock edge)
        @(posedge clk);  // ensure a clock edge occurs with reset=1
        #1 reset = 0;    // release reset

        // Run the CPU for a sufficient number of cycles
        #(300);  // 300 ns (30 clock cycles)
        // Now print out register and memory state
        $display("Final register state:");
        for(i=0; i<8; i=i+1) 
            $display("R%1d = 0x%h (%0d)", i, cpu.RF.regfile[i], $signed(cpu.RF.regfile[i]));
        for(i=8; i<16; i=i+1) 
            $display("R%1d = 0x%h (%0d)", i, cpu.RF.regfile[i], $signed(cpu.RF.regfile[i]));
        $display("Data Memory[2..3] = %02h %02h (should be 0xFF 0xFB, representing -5)", 
                 cpu.DM.memory[2], cpu.DM.memory[3]);
        $display("Data Memory[6..7] = %02h %02h (should be 0xFF 0xFB, representing -5)", 
                 cpu.DM.memory[6], cpu.DM.memory[7]);
        $finish;
    end
endmodule
