`include "instruction_def.v"
`include "ctrl_encode_def.v"
module Ctrl(jump,RegDst,Branch,MemR,Mem2R,MemW,RegW,Alusrc,ExtOp,Aluctrl,OpCode,funct,bne);
	
	input [5:0]		OpCode;				//指令操作码字段
	input [5:0]		funct;				//指令功能字段

	output reg jump;						//指令跳转
	output reg RegDst;						
	output reg Branch;						//分支
	output reg MemR;						//读存储器
	output reg Mem2R;						//数据存储器到寄存器堆
	output reg MemW;						//写数据存储器
	output reg RegW;						//寄存器堆写入数据
	output reg Alusrc;						//运算器操作数选择
	output reg[1:0] ExtOp;						//位扩展/符号扩展选择
	output reg[4:0] Aluctrl;						//Alu运算选择
	output reg bne;


	always @(OpCode or funct)
	begin
		bne=0;
		case(OpCode)
			`INSTR_RTYPE_OP:
			begin
				assign Branch=0;	//
				assign jump=0;		//
				assign Mem2R=0;		//
				assign MemW=1'b0;
				assign MemR=1'b0;
				assign Alusrc=0;
				assign ExtOp=`EXT_ZERO;		//ext  1bit
				assign RegDst=1;	//
				assign RegW=1'b1;
				case(funct)
					6'b100001:
						begin
							assign Aluctrl=`ALUOp_ADDU;
						end
					6'b100011:
						begin
							assign Aluctrl=`ALUOp_SUBU;
						end
					6'b100000:
						begin
							assign Aluctrl=`ALUOp_ADD;
						end
					6'b100010:
						begin
							assign Aluctrl=`ALUOp_SUB;
						end
					6'b100100:
						begin
							assign Aluctrl=`ALUOp_AND;
						end
					6'b100101:
						begin
							assign Aluctrl=`ALUOp_OR;
						end
					6'b100110:
						begin
							assign Aluctrl=`ALUOp_XOR;
						end
					6'b000000:
						begin
							assign Aluctrl=`ALUOp_SLL;
						end
					6'b000010:
						begin 
							assign Aluctrl=`ALUOp_SRL;
						end
					6'b000011:
						begin
							assign Aluctrl=`ALUOp_SRA;
						end
					6'b001000:
						begin
							assign Aluctrl=`ALUOp_ADDU;	//jr
						end
					`INSTR_SLT_FUNCT:
						begin
							assign Aluctrl=`ALUOp_SLT;
						end
					default: ;
				endcase
			end
			
			`INSTR_ORI_OP:
			begin
				assign Branch=0;
				assign jump=0;
				assign Mem2R=0;
				assign MemW=1'b0;
				assign MemR=1'b0;
				assign Alusrc=1;
				assign ExtOp=`EXT_SIGNED;
				assign RegDst=0;
				assign RegW=1'b1;
				assign Aluctrl=`ALUOp_OR;
			end

			`INSTR_LUI_OP:
			begin
				assign Branch=0;
				assign jump=0;
				assign Mem2R=0;
				assign MemW=1'b0;
				assign MemR=1'b0;
				assign Alusrc=1;
				assign ExtOp=`EXT_HIGHPOS;
				assign RegDst=0;
				assign RegW=1'b1;
				assign Aluctrl=`ALUOp_OR;
			end

			`INSTR_SW_OP:
			begin
				assign Branch=0;
				assign jump=0;
				assign Mem2R=0;
				assign MemW=1'b1;
				assign MemR=1'b0;
				assign Alusrc=1;
				assign ExtOp=`EXT_SIGNED;
				assign RegDst=0;
				assign RegW=1'b0;
				assign Aluctrl=`ALUOp_ADD;
			end
			
			`INSTR_LW_OP:
			begin
				assign Branch=0;
				assign jump=0;
				assign Mem2R=1;
				assign MemW=1'b0;
				assign MemR=1'b1;
				assign Alusrc=1;
				assign ExtOp=`EXT_SIGNED;
				assign RegDst=0;
				assign RegW=1'b1;
				assign Aluctrl=`ALUOp_ADD;
			end

			`INSTR_BEQ_OP:
			begin
				assign Branch=1;
				assign jump=0;
				assign Mem2R=0;
				assign MemW=1'b0;
				assign MemR=1'b0;
				assign Alusrc=0;
				assign ExtOp=`EXT_SIGNED;
				assign RegDst=0;
				assign RegW=1'b0;
				assign Aluctrl=`ALUOp_SUB;
			end

			`INSTR_BNE_OP:
			begin
				assign Branch=1;
				assign jump=0;
				assign Mem2R=0;
				assign MemW=1'b0;
				assign MemR=1'b0;
				assign Alusrc=0;
				assign ExtOp=`EXT_SIGNED;
				assign RegDst=0;
				assign RegW=1'b0;
				assign Aluctrl=`ALUOp_SUB;
				assign bne=1;
			end
			
			`INSTR_ADDI_OP:
			begin
				assign Branch=0;
				assign jump=0;
				assign Mem2R=0;
				assign MemW=1'b0;
				assign MemR=1'b0;
				assign Alusrc=1;
				assign ExtOp=`EXT_SIGNED;
				assign RegDst=0;
				assign RegW=1'b1;
				assign Aluctrl=`ALUOp_ADD;
			end
			
			`INSTR_J_OP:
			begin
				assign Branch=0;
				assign jump=1;
				assign Mem2R=0;
				assign MemW=1'b0;
				assign MemR=1'b0;
				assign Alusrc=1;
				assign ExtOp=`EXT_SIGNED;
				assign RegDst=0;
				assign RegW=1'b0;
				assign Aluctrl=`ALUOp_ADD;
			end
			
			default: ;
		endcase
	end


endmodule