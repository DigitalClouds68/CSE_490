module InstructionMemory (
    input   wire [15:0] addr,
    output  wire [15:0] instr
);
    reg [15:0] memory [0:63];
    integer i;
    
    initial begin
        // Can add some instr right here..................
        for(i = 0; i < 64; i = i + 1) 
            memory[i] = 16'h0000;
    end
    
    assign instr = memory[addr[15:1]];  // use word index
endmodule
