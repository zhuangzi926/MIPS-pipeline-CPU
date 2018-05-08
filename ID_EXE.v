module ID_EXE(clk,rst,
	pc_4_in,ir_in,register_read1_in,register_read2_in,ir_2016_in,ir_1511_in,ir_150_in,Reg_Dst_in,Reg_Write_in,ALUctrl_in,ALUctrl_out,ALUSrc_in,Branch_in,Mem2R_in,Mem_Write_in,Mem_Read_in,
	pc_4_out,ir_out,register_read1_out,register_read2_out,ir_2016_out,ir_1511_out,ir_150_out,Reg_Dst_out,Reg_Write_out,ALUSrc_out,Branch_out,Mem2R_out,Mem_Write_out,Mem_Read_out,
	ext_in,ext_out,bne_in,bne_out
	);

	input			clk;
	input			rst;

	input [31:0]	pc_4_in;
	input [31:0]	ir_in;
	input [31:0]	register_read1_in;
	input [31:0]	register_read2_in;
	input [4:0]		ir_2016_in;
	input [4:0]		ir_1511_in;
	input [15:0]	ir_150_in;
	input 			Reg_Dst_in;
	input			Reg_Write_in;
	input [4:0]		ALUctrl_in;
	input			ALUSrc_in;
	input			Branch_in;
	input			Mem2R_in;
	input			Mem_Write_in;
	input			Mem_Read_in;
	input [31:0]	ext_in;
	input			bne_in;

	output reg[31:0]	pc_4_out;
	output reg[31:0]	ir_out;
	output reg[31:0]	register_read1_out;
	output reg[31:0]	register_read2_out;
	output reg[4:0]	ir_2016_out;
	output reg[4:0]	ir_1511_out;
	output reg[15:0]	ir_150_out;
	output reg		Reg_Dst_out;
	output reg		Reg_Write_out;
	output reg[4:0]		ALUctrl_out;
	output reg		ALUSrc_out;
	output reg		Branch_out;
	output reg		Mem2R_out;
	output reg		Mem_Write_out;
	output reg		Mem_Read_out;
	output reg[31:0] ext_out;
	output reg 		bne_out;

	initial
	begin
		pc_4_out=32'b0;
		ir_out=32'b0;
		register_read1_out=32'b0;
		register_read2_out=32'b0;
		ir_2016_out=5'b0;
		ir_1511_out=5'b0;
		ir_150_out=16'b0;
		Reg_Dst_out=0;
		Reg_Write_out=0;
		ALUctrl_out=5'b0;
		ALUSrc_out=0;
		Branch_out=0;
		Mem2R_out=0;
		Mem_Write_out=0;
		Mem_Read_out=0;
		ext_out=32'b0;
		bne_out=0;
	end

	always @(posedge clk) 
	begin

		
			pc_4_out<=pc_4_in;
			ir_out<=ir_in;
			register_read1_out<=register_read1_in;
			register_read2_out<=register_read2_in;
			ir_2016_out<=ir_2016_in;
			ir_1511_out<=ir_1511_in;
			ir_150_out<=ir_150_in;
			Reg_Dst_out<=Reg_Dst_in;
			Reg_Write_out<=Reg_Write_in;
			ALUctrl_out<=ALUctrl_in;
			ALUSrc_out<=ALUSrc_in;
			Branch_out<=Branch_in;
			Mem2R_out<=Mem2R_in;
			Mem_Write_out<=Mem_Write_in;
			Mem_Read_out<=Mem_Read_in;
			ext_out<=ext_in;
			bne_out<=bne_in;
		
		
	end

	always @(posedge rst) 
	begin
		if (rst==1) 
		begin
			pc_4_out=32'b0;
			ir_out=32'b0;
			register_read1_out=32'b0;
			register_read2_out=32'b0;
			ir_2016_out=5'b0;
			ir_1511_out=5'b0;
			ir_150_out=16'b0;
			Reg_Dst_out=0;
			Reg_Write_out=0;
			ALUctrl_out=5'b0;
			ALUSrc_out=0;
			Branch_out=0;
			Mem2R_out=0;
			Mem_Write_out=0;
			Mem_Read_out=0;
			ext_out=32'b0;
			bne_out=0;
		end
	end

endmodule
