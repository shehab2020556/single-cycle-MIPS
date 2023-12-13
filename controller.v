module controller(
    input wire [5:0] op, funct,
    output wire mem_to_reg, mem_write,    
    output wire branch, alu_src,
    output wire reg_dst, reg_write,
    output wire jump,
    output wire [2:0] alu_control
);
wire [1:0] alu_op;

main_dec main_dec(op, mem_to_reg, mem_write, branch,
            alu_src, reg_dst, reg_write, jump, alu_op);
alu_dec alu_dec( funct, alu_op, alu_control);

endmodule

