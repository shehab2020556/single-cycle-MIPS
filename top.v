`include "instr_mem.v"
`include "data_mem.v"
`include "reg_file.v"
`include "alu_dec.v"
`include "main_dec.v"
`include "controller.v"
`include "alu.v"
`include "mux.v"
`include "adder.v"
`include "sign_extend.v"
`include "shift_left_1.v"
`include "shift_left_2.v"
`include "register.v"
`include "data_path.v"
`include"mips.v"

module top(
    input clk, rst,
    output [31:0] tst
);
    
    wire mem_write;
    wire [31:0] alu_out;
    wire [31:0] write_data;
    wire [31:0] read_data;
    wire [31:0] PC;
    wire [31:0] instr;
    

    data_mem Data_mem_top_mips(
        .clk(clk), 
        .rst(rst), 
        .WE(mem_write),
        .A(alu_out),
        .WD(write_data),
        .RD(read_data),
        .tst(tst)
    );
    
    instr_mem  instr_mem(
        .PC(PC),
        .instr(instr)
    );
    
    mips mips(
        .clk(clk), 
        .rst(rst),
        .instr(instr),
        .read_data(read_data),
        .PC(PC),
        .write_data(write_data),
        .alu_out(alu_out),
        .mem_write(mem_write)
    );
    
    endmodule
