`timescale 1ns / 1ps

module wbMux_tb;
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
    
        $monitor("wbMux Testing Starts");
        
        in0 = 16'h0002+16'h0004; //ALU value 
        in1 = 16'hAAAA; //load instruction
        
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
