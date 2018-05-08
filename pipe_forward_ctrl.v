module pipe_forward_ctrl(clk,exemem_regw,exemem_regrd,idexe_regrs,idexe_regrt,memwb_regw,memwb_regrd,forward_a,forward_b);
	input			clk;
	input			exemem_regw;
	input [4:0]		exemem_regrd;
	input [4:0]		idexe_regrs;
	input [4:0]		idexe_regrt;
	input			memwb_regw;
	input [4:0]		memwb_regrd;

	output reg[1:0]	forward_a;
	output reg[1:0]	forward_b;

	always @(posedge clk or exemem_regw or exemem_regrd or idexe_regrs or idexe_regrt or memwb_regw or memwb_regrd) 
	begin
		forward_b=2'b00;
		forward_a=2'b00;
		if (exemem_regw&&(exemem_regrd!=5'b0)&&(exemem_regrd==idexe_regrs)) 
		begin
			forward_a=2'b10;
		end
		if (exemem_regw&&(exemem_regrd!=5'b0)&&(exemem_regrd==idexe_regrt)) 
		begin
			forward_b=2'b10;
		end
		if(memwb_regw&&(memwb_regrd!=5'b0)&&!(exemem_regw&&(exemem_regrd!=5'b0)&&(exemem_regrd==idexe_regrs))&&(memwb_regrd==idexe_regrs))
		begin
			forward_a=2'b01;
		end
		if(memwb_regw&&(memwb_regrd!=5'b0)&&!(exemem_regw&&(exemem_regrd!=5'b0)&&(exemem_regrd==idexe_regrt))&&(memwb_regrd==idexe_regrt))
		begin
			forward_b=2'b01;
		end
	end
endmodule