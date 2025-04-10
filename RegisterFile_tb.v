`timescale 1ns / 1ps

module RegisterFile_tb;
    // Inputs
    reg clk;
    reg reset;
    reg RegWrite;
    reg [3:0] read_reg1;
    reg [3:0] read_reg2;
    reg [3:0] write_reg;
    reg [15:0] write_data;

    // Outputs
    wire [15:0] read_data1;
    wire [15:0] read_data2;

    // Instantiate the RegisterFile
    RegisterFile uut (
        .clk(clk),
        .reset(reset),
        .RegWrite(RegWrite),
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Clock generation
    always #5 clk = ~clk; // 10 ns clock period

    // Test sequence
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        RegWrite = 0;
        read_reg1 = 0;
        read_reg2 = 0;
        write_reg = 0;
        write_data = 0;

        // Reset the Register File
        #10 reset = 0;

        // Write data to register 1
        #10 write_reg = 4'b0001;
            write_data = 16'hA5A5;
            RegWrite = 1;
        #10 RegWrite = 0;

        // Read data from register 1
        #10 read_reg1 = 4'b0001;

        // Write data to register 2
        #10 write_reg = 4'b0010;
            write_data = 16'h5A5A;
            RegWrite = 1;
        #10 RegWrite = 0;

        // Read data from register 2
        #10 read_reg2 = 4'b0010;

        // Add more test cases as needed

        #20 $finish; // End simulation
    end
endmodule
