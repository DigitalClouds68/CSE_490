`timescale 1ns / 1ps

module SignExt4_tb;
    reg  [3:0] in;
    wire [15:0] out;
    SignExt4 uut (
        .in(in),
        .out(out)
    );
    initial begin
        $display("Time\tin\tout");
        $monitor("%g\t%b\t%b", $time, in, out);
        // Apply different inputs
        in = 4'b0000; #10;  // 0x0000
        in = 4'b0111; #10;  // 0x0007
        in = 4'b1000; #10;  // 0xFFF8
        in = 4'b1111; #10;  // 0xFFFF
        in = 4'b1010; #10;  // 0xFFFA
        $finish;
    end
endmodule