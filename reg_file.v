module reg_file (
  input   wire  [4:0]     A1,
  input   wire  [4:0]     A2,
  input   wire  [4:0]     A3,
  input   wire            WE3, rst,
  input  wire   [31:0]     WD3,
  input   wire            clk,
  output  wire   [31:0]     RD1,
  output  wire   [31:0]     RD2
);

reg [31:0] regfile [31:0];
integer i;



always @(posedge clk or negedge rst) begin
if(!rst) begin
    for(i=0; i<32; i=i+1) begin
        regfile[i]<=32'b0;
    end
end 
else if(WE3) begin
    regfile[A3]<= WD3 ;
end
end

assign RD1= regfile[A1];
assign RD2= regfile[A2];

endmodule