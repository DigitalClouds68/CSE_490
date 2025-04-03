module ProgramCounter (
    input   wire         clk,
    input   wire         reset,
    input   wire [15:0]  pc_in,
    input   wire         load,
    output  reg  [15:0]  pc_out
);
    always @(posedge clk or posedge reset) begin
        if (reset) 
            pc_out <= 16'b0;
        else if (load)
            pc_out <= pc_in;
        else
            pc_out <= pc_out + 16'd2;  // increment by 2 (word-aligned)
    end
endmodule
