`timescale 1ns/1ps
module InstructionMemory_tb;
    
    reg [15:0] addr;
    wire [15:0] instr;
    
    InstructionMemory IM(
        .addr(addr),
        .instr(instr)
    );
    
    integer idx;
    
    initial begin
        $display("Starting InstructionMemory test...");

        // Power of 2
        for(idx = 0; idx < 28; idx = idx + 1) begin
            addr = idx * 2;  // addr = 0, 2, 4, ...
            #10;
            $display("At addr = %d, instr = %b (0x%h)", addr, instr, instr);
        end

        $finish;
    end

endmodule
