`timescale 1ns / 1ps

module tb_ProgramCounter;
    reg clk;
    reg reset;
    reg [15:0] pc_in;
    reg load;
    wire [15:0] pc_out;
    
    ProgramCounter uut (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_in),
        .load(load),
        .pc_out(pc_out)
    );
    always #5 clk = ~clk;
    initial begin
        clk = 0;
        reset = 0;
        pc_in = 0;
        load = 0;
        $display("Time\treset\tload\tpc_in\t\tpc_out");
        $monitor("%g\t%b\t%b\t%h\t\t%h", $time, reset, load, pc_in, pc_out);
        //Tests resetting, incrementing, loading a value, and incrementing again
        reset = 1; #10;
        reset = 0; #10;
        #20;
        pc_in = 16'h00A0;
        load = 1; #10;
        load = 0; #10;
        #30;
        $finish;
    end
endmodule
