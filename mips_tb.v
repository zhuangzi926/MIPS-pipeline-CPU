 module Mips_tb();
    
   reg clk, rst;
    
   pipe_mips U_pipe_mips(.clk(clk),.rst(rst)); 
    
   initial begin
      $readmemh( "code3.txt" , U_pipe_mips.U_IM.IMem ) ; 
	$monitor("PC = 0x%8X, IR = 0x%8X", U_pipe_mips.U_pipe_PcUnit.pcout, U_pipe_mips.im_OpCode );        
      clk = 1 ;
      rst = 0 ;
      #5 rst = 1 ;
      #20 rst = 0 ;
   end
   
   always
	   #(50) clk = ~clk;
   
endmodule
