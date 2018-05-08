module EXE_MEM(clk,rst,
	pc_branch_in,alu_result_in,alu_zero_in,rt_data_in,r_target_in,Branch_in,Mem_Read_in,Mem_Write_in,Register_Write_in,M2R_in,
	pc_branch_out,alu_result_out,alu_zero_out,rt_data_out,r_target_out,Branch_out,Mem_Read_out,Mem_Write_out,Register_Write_out,M2R_out,
	ir_2016_out,ir_2016_in);
	
	input					clk;
	input					rst;

	input[31:0]				pc_branch_in;
	input[31:0]				alu_result_in;
	input					alu_zero_in;
	input[31:0]				rt_data_in;
	input[4:0]				r_target_in;
	input					Branch_in;
	input					Mem_Read_in;
	input					Mem_Write_in;
	input					Register_Write_in;
	input					M2R_in;
	input[4:0]				ir_2016_in;

	output reg[31:0]			pc_branch_out;
	output reg[31:0]			alu_result_out;
	output	 reg				alu_zero_out;
	output reg[31:0]			rt_data_out;
	output reg[4:0]				r_target_out;
	output	 reg				Branch_out;
	output		 reg			Mem_Read_out;
	output		 reg			Mem_Write_out;
	output		 reg			Register_Write_out;
	output		 reg			M2R_out;
	output	reg[4:0]			ir_2016_out;

	initial
	begin
			pc_branch_out=32'b0;
			alu_result_out=32'b0;
			alu_zero_out=1'b0;
			rt_data_out=32'b0;
			r_target_out=5'b0;
			Branch_out=1'b0;
			Mem_Read_out=1'b0;
			Mem_Write_out=1'b0;
			Register_Write_out=1'b0;
			M2R_out=1'b0;
			ir_2016_out=5'b0;
	end

	always @(posedge clk) 
	begin
		
			pc_branch_out<=pc_branch_in;
			alu_result_out<=alu_result_in;
			alu_zero_out<=alu_zero_in;
			rt_data_out<=rt_data_in;
			r_target_out<=r_target_in;
			Branch_out<=Branch_in;
			Mem_Read_out<=Mem_Read_in;
			Mem_Write_out<=Mem_Write_in;
			Register_Write_out<=Register_Write_in;
			M2R_out<=M2R_in;
			ir_2016_out<=ir_2016_in;
		
	end

	always @(posedge rst) 
	begin
		if (rst) 
		begin
			pc_branch_out=32'b0;
			alu_result_out=32'b0;
			alu_zero_out=1'b0;
			rt_data_out=32'b0;
			r_target_out=5'b0;
			Branch_out=1'b0;
			Mem_Read_out=1'b0;
			Mem_Write_out=1'b0;
			Register_Write_out=1'b0;
			M2R_out=1'b0;
			ir_2016_out=5'b0;
		end
	end
	
	
endmodule