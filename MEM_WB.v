module MEM_WB(clk,rst,
	address_in,data_in,r_target_in,Reg_Write_in,M2R_in,
	address_out,data_out,r_target_out,Reg_Write_out,M2R_out);
	input clk;
	input rst;
	input [31:0]	address_in;
	input [31:0]	data_in;
	input [4:0]		r_target_in;
	input			Reg_Write_in;
	input			M2R_in;


	output reg[31:0]	address_out;
	output reg[31:0]	data_out;
	output reg[4:0]	r_target_out;
	output reg		Reg_Write_out;
	output reg		M2R_out;

	initial
	begin
			address_out=32'b0;
			data_out=32'b0;
			r_target_out=5'b0;
			Reg_Write_out=0;
			M2R_out=0;
	end

	always @(posedge clk) 
	begin
		
			address_out<=address_in;
			data_out<=data_in;
			r_target_out<=r_target_in;
			Reg_Write_out<=Reg_Write_in;
			M2R_out<=M2R_in;
		
	end

	always @(posedge rst) 
	begin
		if (rst) 
		begin
			address_out=32'b0;
			data_out=32'b0;
			r_target_out=5'b0;
			Reg_Write_out=0;
			M2R_out=0;
		end
	end
endmodule
