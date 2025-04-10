`timescale 1ns/1ps
module DataMemory_tb;
    reg clk;
    reg MemWrite;
    reg MemRead;
    reg [15:0] addr;
    reg [15:0] write_data;
    
    wire [15:0] read_data;
    
    DataMemory DM (
        .clk(clk),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .addr(addr),
        .write_data(write_data),
        .read_data(read_data)
    );
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        $display("Starting DataMemory simulation...");
        
        MemWrite = 1;
        MemRead = 0;
        addr = 16'd2;
        write_data = 16'hABCD;
        #10;
        MemWrite = 0;
        
        MemRead = 1;
        #5;
        $display("Time %t: Reading data at addr %d, read_data = 0x%h (expected 0xABCD)", $time, addr, read_data);
        
        MemWrite = 1;
        MemRead = 0;
        addr = 16'd10;
        write_data = 16'h1234;
        #10;
        MemWrite = 0;
        
        MemRead = 1;
        #5;
        $display("Time %t: Reading data at addr %d, read_data = 0x%h (expected 0x1234)", $time, addr, read_data);
        
        MemRead = 0;
        #5;
        $display("Time %t: With MemRead deasserted, read_data = 0x%h (expected 0xZZZZ)", $time, read_data);
        
        $finish;
    end
endmodule
