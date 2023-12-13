module alu(
    input wire[31:0] SrcA,SrcB,
    input wire [2:0] alu_control,
    output reg [31:0] alu_result,
    output wire zero
);
    
assign zero = (alu_result==32'b0)? 1:0;
always @(*) begin
begin
    case(alu_control)
        3'b000:alu_result = SrcA&SrcB;
        3'b001:alu_result = SrcA|SrcB;
        3'b010:alu_result = SrcA+SrcB;
        3'b110:alu_result = SrcA-SrcB; // 3'b100:alu_result = SrcA-SrcB; 
        // 3'b101:alu_result = SrcA*SrcB;
        3'b111:alu_result = (SrcA<SrcB);
        default:alu_result =31'b0;
    endcase
end
end

endmodule

