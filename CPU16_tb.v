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
        for(i=0; i<64; i=i+1)
            cpu.IM.memory[i] = 16'h0000;  // clear memory
        
        /*Read Instruction Memory*/
        //$readmemh("instr.txt", cpu.IM.memory); 
        cpu.IM.memory[0]  = 16'b0011111100000011;
        cpu.IM.memory[1]  = 16'b0011111011110000;
        cpu.IM.memory[2]  = 16'b0011101000001000;
        cpu.IM.memory[3]  = 16'b0000111011100010;
        cpu.IM.memory[4]  = 16'b0011110111100000;
        cpu.IM.memory[5]  = 16'b0000110111110000;
        cpu.IM.memory[6]  = 16'b0000110111110010;
        cpu.IM.memory[7]  = 16'b0000110111110010;
        cpu.IM.memory[8]  = 16'b0011100100000111;
        cpu.IM.memory[9]  = 16'b0011100000000110;
        cpu.IM.memory[10] = 16'b0011000100000001;
        cpu.IM.memory[11] = 16'b0000100110000011;
        cpu.IM.memory[12] = 16'b0000100000010010;
        cpu.IM.memory[13] = 16'b0101100100001101;
        cpu.IM.memory[14] = 16'b0010111011100000;
        cpu.IM.memory[15] = 16'b0010110111100010;
        cpu.IM.memory[16] = 16'b0001001011100000;
        cpu.IM.memory[17] = 16'b0001001111100001;
        cpu.IM.memory[18] = 16'b0001010011100010;
        cpu.IM.memory[19] = 16'b0001010111100011;
        cpu.IM.memory[20] = 16'b0001011011100100;
        cpu.IM.memory[21] = 16'b0100001011100010;
        cpu.IM.memory[22] = 16'b0000001011100001;
        cpu.IM.memory[23] = 16'b0000010011010001;
        cpu.IM.memory[24] = 16'b0101001000000010;
        cpu.IM.memory[25] = 16'b0000111011010001;
        cpu.IM.memory[26] = 16'b0110111111100110;
        cpu.IM.memory[27] = 16'b0110111111111010;
        
        // Apply reset
        reset = 1;
        #5;
        @(posedge clk);
        #1 reset = 0;

        #(300);  // 300 ns (30 clock cycles)

        $display("Final register state:");
        for(i=0; i<8; i=i+1) 
            $display("R%1d = 0x%h (%0d)", i, cpu.RF.regfile[i], $signed(cpu.RF.regfile[i]));
        for(i=8; i<16; i=i+1) 
            $display("R%1d = 0x%h (%0d)", i, cpu.RF.regfile[i], $signed(cpu.RF.regfile[i]));
        $finish;
    end
endmodule
