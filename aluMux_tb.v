`timescale 1ns / 1ps

module aluMux_tb;

    reg [15:0] in0;
    reg [15:0] in1;
    reg select;  
    wire [15:0] out;
    
    Mux2 uut (
        .in0(in0),
        .in1(in1),
        .select(select),
        .out(out)
    );
    
    initial begin 
    
        $monitor("ALUSrcMux Testing Starts");
        
        in0 = 16'h0000; //register value
        in1 = 16'h000A; //immediate value
        
        //test one, select == 0 
        $monitor("Test 1: select = %h, out = %h", select, out);
        select = 0;
        #10;
        
        //test two, select == 1
        $monitor("Test 2: select = %h, out = %h", select, out);
        select = 1;
        #10;
    end    
endmodule