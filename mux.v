module mux#(parameter bus_width = 32) (
    input wire  sel,
    input wire [bus_width-1:0] in1,in2,
    output reg [bus_width-1:0] out
);
always @(*) begin
    if(sel==0) begin
        out = in1;
    end
    else begin
        out = in2;
    end
end

endmodule