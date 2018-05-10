module pipe_PcUnit(clk,rst,sel,branch_address,pcout,pc_4,stall,jump,jaddress);

	input   clk;					//输入时钟信号，上升沿取指令
	input   rst;					//高电平时重置整个pc，低电平无作用
	input   sel;					//高电平时执行条件跳转指令
	input   [31:0]	branch_address;	//32位条件分支指令地址
	input	stall;					//高电平时阻塞pc
	input 	jump;					//高电平时执行无条件跳转指令
	input	[31:0]		jaddress;	//32位无条件跳转指令

	output	reg[31:0]	pcout;		//32位下一条指令地址
	output	reg[31:0]	pc_4;		//32位下下条指令地址
	
	
	integer i;

	reg [31:0] temp;	

	always@(posedge clk or posedge rst)
	begin
		
		begin
			if(rst == 1)
				pcout <= 32'h0000_3000;
			
			pcout = pcout+4;

			pc_4=pcout+4;
			if(jump==1)				//如果发生无条件跳转指令
			begin
				pcout=jaddress;		//输出跳转地址
				pc_4=pcout+4;
			end
			
		end
	end

	always @ (posedge sel)
	begin
		if(sel==1)					//如果发生条件分支指令
			pcout=branch_address;
	end
	
	always @ (posedge stall)		//如果发生阻塞
	begin
		pcout=pcout-4;
		pc_4=pcout+4;
	end
	

endmodule
	
	
