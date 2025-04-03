module Mux2 (
    input  wire [15:0]  in0,
    input  wire [15:0]  in1,
    input  wire         select,
    output reg  [15:0]  out
);

always @(*) begin
    if (select == 0)
        out = in0;
    else
        out = in1;
end
endmodule