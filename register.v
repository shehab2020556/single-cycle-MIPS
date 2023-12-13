module register #(
    parameter bus_width=1
) (
    input  wire [bus_width-1:0] d,
    input  wire                 clk,rst,
    output reg  [bus_width-1:0] q
);

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        q<='b0;
    end
    else begin
        q<=d;
    end
end

endmodule