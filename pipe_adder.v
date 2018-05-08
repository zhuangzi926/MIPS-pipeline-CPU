module pipe_adder(pcin,exin,pcout);

	input[31:0]				pcin;
	input[31:0]				exin;

	output reg[31:0]		pcout;


	reg signed [31:0] DataIn1;
	reg signed [31:0] DataIn2;
	reg signed [31:0] Result;

	initial
	begin
		DataIn2=32'b0;
		DataIn1=32'b0;
		Result=32'b0;
		pcout=32'b0;
	end

	always@(pcin or exin)
	begin
		DataIn1=pcin;
		DataIn2=exin<<2;
		Result=DataIn2+DataIn1;
		pcout=Result;
	end
endmodule

