module pipe_forward_m(w_reg_target,w_mem_source,w_reg_data,w_mem_data,result,wb,mw);
	input [4:0]	w_reg_target;
	input [4:0]	w_mem_source;
	input [31:0]	w_reg_data;
	input [31:0]	w_mem_data;
	input 		wb;
	input		mw;

	output [31:0]	result;

	assign result=(w_reg_target==w_mem_source && wb && mw)?w_reg_data:w_mem_data;
endmodule