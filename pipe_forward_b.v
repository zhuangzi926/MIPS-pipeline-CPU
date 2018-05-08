module pipe_forward_b(forwardb,gpr,alu,wb,result);
	input [1:0]			forwardb;
	input [31:0]		gpr;
	input [31:0]		alu;
	input [31:0]		wb;

	output [31:0]	result;

	assign result=(forwardb==2'b00)?gpr:
		      (forwardb==2'b10)?alu:
		      (forwardb==2'b01)?wb:gpr;
endmodule