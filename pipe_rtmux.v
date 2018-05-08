module pipe_rtmux(sel,imme,rt,result);
	input		sel;
	input [31:0]		imme;
	input [31:0]		rt;

	output [31:0]	result;

	assign result=(sel==0)?rt:imme;
	
	
endmodule