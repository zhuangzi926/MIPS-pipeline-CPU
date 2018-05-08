module pipe_forward_a(forwarda,gpr,alu,wb,result);
	input [1:0]			forwarda;
	input [31:0]		gpr;
	input [31:0]		alu;
	input [31:0]		wb;

	output [31:0]	result;

	assign result=(forwarda==2'b00)?gpr:
		      (forwarda==2'b10)?alu:
		      (forwarda==2'b01)?wb:gpr;
endmodule