module j_ctrl(jaddress,pc_4_high,pc_j_out);
	input [25:0]	jaddress;
	input [3:0]		pc_4_high;

	output [31:0]	pc_j_out;

	assign pc_j_out[31:28] = pc_4_high;
	assign pc_j_out[27:2]  = jaddress;
	assign pc_j_out[1:0]   = 2'b00;

endmodule
