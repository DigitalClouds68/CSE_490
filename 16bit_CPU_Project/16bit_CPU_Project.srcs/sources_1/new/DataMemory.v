module DataMemory (
    input   wire          clk,
    input   wire          MemWrite,
    input   wire          MemRead,
    input   wire  [15:0]  addr,
    input   wire  [15:0]  write_data,
    output  reg   [15:0]  read_data
);
    reg [7:0] memory [0:127];

/* Can delete */
    integer j;
    initial begin
        for(j = 0; j < 128; j = j + 1)
            memory[j] = 8'h00;
    end
/**************/

    always @(posedge clk) begin
        if (MemWrite) begin
            memory[addr]   <= write_data[15:8];
            memory[addr + 1] <= write_data[7:0];
        end
    end

    always @* begin
        if (MemRead) 
            read_data = { memory[addr], memory[addr + 1] };
        else 
            read_data = 16'hZZZZ;
    end
endmodule
