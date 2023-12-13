module data_mem (
    input wire clk, rst, WE,
    input wire [31:0] A,
    input wire [31:0] WD,
    output wire [31:0] RD,
    output wire  [31:0] tst
);
    
reg [31:0] ram [99:0];
integer i;

always@(posedge clk, negedge rst) begin
    if (!rst) begin
        for (i = 0; i<100; i=i+1) begin
                ram[i] <= 32'b0;
        end 
    end
    else if (WE) begin
        ram[A] <= WD; 
    end
end 

assign RD = ram[A];
assign tst = ram[0];

endmodule