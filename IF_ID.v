module IF_ID(clk,rst,pcin,irin,pcout,irout,stall);

//PCunit 和 IM 可以保留

	input			clk;
	input			rst;
	input			stall;
	input [31:0]	pcin;
	input [31:0]	irin;

	output reg[31:0]	irout;
	output reg[31:0]	pcout;

	initial
	begin
		irout=32'b0;
		pcout=32'b0;
	end

	always @(posedge clk) 
	begin
		if(stall)
		begin
			
		end
		else 
		begin
			pcout<=pcin;
			irout<=irin;
		end
		
	end
	
	always @(posedge rst) 
	begin
		if (rst==1) 
		begin
			// reset
			pcout<=32'b0;
			irout<=32'b0;
		end
	end
endmodule