`include "ctrl_encode_def.v"

module pipe_alu(AluResult,Zero,DataIn1,DataIn2,AluCtrl,offset,bne);

	input  [31:0] 		DataIn1;		//运算数据1
	input  [31:0]		DataIn2;		//运算数据2
	input  [4:0]		AluCtrl;		//运算器控制信号
	input  [5:0]		offset;
	input				bne;

	output reg[31:0]		AluResult;		//运算器输出结果
	output reg				Zero;			//结果是否为零
	
	reg signed [31:0] sDataIn1;
	reg signed [31:0] sDataIn2;
	reg signed [31:0] sAluResult;

	initial								//初始化数据
	begin
		Zero = 0;
		AluResult = 0;
		sDataIn1=32'b0;
		sDataIn2=32'b0;
		sAluResult=32'b0;
	end	
	
	always@(DataIn1 or DataIn2 or AluCtrl)
	begin
		case ( AluCtrl )
			`ALUOp_ADDU:
				begin
					AluResult=DataIn1+DataIn2;	//addu
				end
			`ALUOp_SUBU:
				begin
					AluResult=DataIn1-DataIn2;	//subu
				end
			`ALUOp_OR:
				begin
					AluResult=DataIn1|DataIn2;	//or
				end
			`ALUOp_AND:
				begin
					AluResult=DataIn1&DataIn2;
				end
			`ALUOp_XOR:
				begin
					AluResult=DataIn1^DataIn2;
				end
			`ALUOp_SLL:
				begin
					AluResult=DataIn2<<offset;
				end
			`ALUOp_SRL:
				begin
					AluResult=DataIn2>>offset;
				end
			`ALUOp_ADD:
				begin
					sDataIn1=DataIn1;
					sDataIn2=DataIn2;
					sAluResult=sDataIn1+sDataIn2;
					AluResult=sAluResult;
				end
			`ALUOp_SUB:
				begin
					sDataIn1=DataIn1;
					sDataIn2=DataIn2;
					sAluResult=sDataIn1-sDataIn2;
					AluResult=sAluResult;
				end
			`ALUOp_SLT:
				begin
					sDataIn1=DataIn1;
					sDataIn2=DataIn2;
					sAluResult=sDataIn1-sDataIn2;
					if(sAluResult<0)
						AluResult=1;
					else
						AluResult=0;
				end
	     
         		default:   ;
      		endcase
		
		if(AluResult==0)
			Zero=1;
		else
			Zero=0;

		if(bne==1)
			Zero=~Zero;

	end

endmodule