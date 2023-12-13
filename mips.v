module mips (
    input wire clk, rst,
    input wire [31:0] instr,
    input wire [31:0] read_data,
    output wire mem_write,
    output wire [31:0] PC,
    output wire [31:0] write_data,
    output wire [31:0] alu_out
);

    wire [2:0] alu_control;
    wire jump;
    wire mem_to_reg;
    wire branch;
    wire alu_src;
    wire reg_dst;
    wire reg_write;

    controller controller(
        .op(instr[31:26]),
        .funct(instr[5:0]),
        .mem_to_reg(mem_to_reg),
        .mem_write(mem_write),
        .branch(branch),
        .alu_src(alu_src),
        .reg_dst(reg_dst),
        .reg_write(reg_write),
        .jump(jump),
        .alu_control(alu_control)
    );

    data_path data_path(
        .clk(clk),
        .rst(rst),
        .instr(instr),
        .read_data(read_data),
        .alu_control(alu_control),
        .jump(jump),
        .mem_to_reg(mem_to_reg),
        .branch(branch),
        .alu_src(alu_src),
        .reg_dst(reg_dst),
        .reg_write(reg_write),
        .PC(PC),
        .alu_result(alu_out),
        .write_data(write_data)
    );

endmodule