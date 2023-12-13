module instr_mem (
    input wire [31:0] PC,
    output wire [31:0] instr
);




reg [31:0] intr_mem [31:0];

initial begin
    $readmemh("machine_code.txt",intr_mem) ;
end

  assign instr = intr_mem[(PC>>2)];

    
endmodule