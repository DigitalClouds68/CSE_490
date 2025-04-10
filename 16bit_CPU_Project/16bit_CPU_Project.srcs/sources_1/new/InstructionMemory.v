module InstructionMemory (
    input   wire [15:0] addr,
    output  wire [15:0] instr
);
    reg [15:0] memory [0:63];
    integer i;
    
    initial begin
        for(i = 0; i < 64; i = i + 1) 
            memory[i] = 16'h0000;
/*     This!!!  ↓ */
        memory[0]  = 16'b0011111100000011;
        memory[1]  = 16'b0011111011110000;
        memory[2]  = 16'b0011101000001000;
        memory[3]  = 16'b0000111011100010;
        memory[4]  = 16'b0011110111100000;
        memory[5]  = 16'b0000110111110000;
        memory[6]  = 16'b0000110111110010;
        memory[7]  = 16'b0000110111110010;
        memory[8]  = 16'b0011100100000111;
        memory[9]  = 16'b0011100000000110;
        memory[10] = 16'b0011000100000001;
        memory[11] = 16'b0000100110000011;
        memory[12] = 16'b0000100000010010;
        memory[13] = 16'b0101100100001101;
        memory[14] = 16'b0010111011100000;
        memory[15] = 16'b0010110111100010;
        memory[16] = 16'b0001001011100000;
        memory[17] = 16'b0001001111100001;
        memory[18] = 16'b0001010011100010;
        memory[19] = 16'b0001010111100011;
        memory[20] = 16'b0001011011100100;
        memory[21] = 16'b0100001011100010;
        memory[22] = 16'b0000001011100001;
        memory[23] = 16'b0000010011010001;
        memory[24] = 16'b0101001000000010;
        memory[25] = 16'b0000111011010001;
        memory[26] = 16'b0110111111100110;
        memory[27] = 16'b0110111111111010;

    end

    assign instr = memory[addr[15:1]];  // Each instruction is 2 Bytes，alignment
endmodule
