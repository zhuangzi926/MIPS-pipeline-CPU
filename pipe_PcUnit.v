
module pipe_PcUnit(clk,rst,sel,branch_address,pcout,pc_4,stall,jump,jaddress);

	input   clk;
	input   rst;
	input   sel;
	input   [31:0]	branch_address;
	input	stall;
	input 	jump;
	input	[31:0]		jaddress;

	output	reg[31:0]	pcout;
	output	reg[31:0]	pc_4;
	
	
	integer i;

	reg [31:0] temp;	

	always@(posedge clk or posedge rst)
	begin
		
		begin
			if(rst == 1)
				pcout <= 32'h0000_3000;
			
			pcout = pcout+4;

			pc_4=pcout+4;
			if(jump==1)
			begin
				pcout=jaddress;
				pc_4=pcout+4;
			end
			
		end
	end

	always @ (posedge sel)
	begin
		if(sel==1)
			pcout=branch_address;
	end
	
	always @ (posedge stall)
	begin
		pcout=pcout-4;
		pc_4=pcout+4;
	end
	

endmodule
	
	