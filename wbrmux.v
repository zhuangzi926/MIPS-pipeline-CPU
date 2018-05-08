module pipe_wbrmux(regdst,lw_target,r_target,result)
	input 			regdst;
	input [4:0]		lw_target;
	input [4:0]		r_target;

	output [4:0]	result;


	if(regdst==0)
		result=lw_target;
	else 
		result=r_target;
endmodule