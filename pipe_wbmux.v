module pipe_wbmux(sel,RegW,MemO,Result);
	input 			sel;
	input[31:0]		RegW;
	input[31:0]		MemO;

	output[31:0]	Result;

	assign Result=(sel==0)?RegW:MemO;
	
endmodule