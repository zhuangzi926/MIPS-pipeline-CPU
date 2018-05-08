module pipe_wbrmux(regdst,lw_target,r_target,result);
	input 			regdst;
	input [4:0]		lw_target;
	input [4:0]		r_target;

	output [4:0]	result;

	assign result=(regdst==0)?lw_target:r_target;

	
endmodule