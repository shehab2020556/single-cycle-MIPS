module data_path (
    input wire clk,rst,
    input wire mem_to_reg,
    input wire reg_dst,
    input wire reg_write,
    input wire branch,
    input wire jump,
    input wire alu_src,
    input wire [31:0] instr,
    input wire [2:0] alu_control,
    input wire [31:0] read_data,
    output wire [31:0] write_data,
    output wire [31:0] alu_result,
    output wire [31:0] PC
);

wire zero;
wire [31:0] dm_muxed;
wire [4:0] write_reg;
wire [31:0] RD1, RD2;
wire [31:0] SrcB;
wire [31:0] signimm;
wire PCscrc;
wire [31:0] pc_muxed;
wire [31:0] PC_plus4;
wire [31:0] PC_branch;
wire [27:0] pc_shifted;
wire [31:0] PC_branch_shifted;
wire [31:0] PC_dash;

adder  PC_add1 (.in1(PC),.in2(32'b100),.out(PC_plus4));

adder  PC_add2(.in1(PC_plus4),.in2(PC_branch_shifted),.out(PC_branch));

shift_left_1  shift_left_1(.in(signimm),.out(PC_branch_shifted));

shift_left_2  shift_left_2(.in(instr[25:0]),.out(pc_shifted));

register #(.bus_width(32)) PC_reg (.d(PC_dash),.clk(clk),.rst(rst),.q(PC));

mux #(.bus_width(32)) mux_1(.sel(mem_to_reg),.in1(alu_result),.in2(read_data),.out(dm_muxed));

mux #(.bus_width(32)) mux_2(.sel(alu_src), .in1(RD2), .in2(signimm), .out(SrcB));

mux #(.bus_width(32)) mux_3(.sel(jump), .in1(pc_muxed), .in2({PC_plus4[31:28], pc_shifted}), .out(PC_dash));

mux#(.bus_width(32)) mux_4(.sel(PCscrc), .in1(PC_plus4), .in2(PC_branch), .out(pc_muxed));

mux #(.bus_width(5)) mux_5(.sel(reg_dst), .in1(instr[20:16]), .in2(instr[15:11]), .out(write_reg));

reg_file       reg_file(.A1(instr[25:21]), .A2(instr[20:16]), .A3(write_reg), .WE3(reg_write), 
                                    .rst(rst), .clk(clk), .RD1(RD1), .RD2(RD2), .WD3(dm_muxed)); 
alu  alu(.SrcA(RD1), .SrcB(SrcB), .alu_control(alu_control), .alu_result(alu_result), .zero(zero));
sign_extend  sign_extend(.instr_15_0(instr[15:0]),  .signlmm(signimm));

assign write_data = RD2;
assign PCscrc = zero & branch;

endmodule
