module sign_extend (
  input wire [15:0] instr_15_0, 
  output wire [31:0] signlmm
);
  
  assign signlmm = {{16 {instr_15_0[15]}} , instr_15_0[15:0]};

endmodule