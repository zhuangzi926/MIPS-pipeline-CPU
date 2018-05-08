module pipe_hazard_detect(clk,idexe_memr,idexe_regrt,ifid_regrs,ifid_regrt,stall);
	input			idexe_memr;
	input [4:0]		idexe_regrt;
	input [4:0]		ifid_regrs;
	input [4:0]		ifid_regrt;
	input clk;

	output 	reg	stall;


	

	always @ (posedge clk)
	begin
		if(idexe_memr && ((idexe_regrt==ifid_regrs)||(idexe_regrt==ifid_regrt)))
			stall=1;
		else
			stall=0;
	end

endmodule

