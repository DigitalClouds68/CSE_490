module RegisterFile (
    input  wire         clk,
    input  wire         reset,
    input  wire         RegWrite,
    input  wire  [3:0]  read_reg1,
    input  wire  [3:0]  read_reg2,
    input  wire  [3:0]  write_reg,
    input  wire  [15:0] write_data,
    output wire  [15:0] read_data1,
    output wire  [15:0] read_data2
);
    /* Add sth here */
    reg [15:0] regfile [0:15];
    integer k;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for(k=0; k<16; k=k+1)
                regfile[k] <= 16'h0000;
        end else if (RegWrite) begin
            regfile[write_reg] <= write_data;
        end
    end
    assign read_data1 = regfile[read_reg1];
    assign read_data2 = regfile[read_reg2];
endmodule
