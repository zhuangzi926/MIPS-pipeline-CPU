module pipe_mips(clk,rst);

	//P205

	
	input			clk;
	input			rst;

	//PC
	wire   			pc_sel;//为1条件转移
	wire [31:0]		pc_branch_address;//转移地址
	wire [31:0]		pc_pcout;//pc输出
	wire [31:0]		pc_pc_4;//pc+4输出
	wire			pc_stall;
	wire			pc_jump;
	wire [31:0]		pc_jaddress;

	//IM
	wire [4:0] 		im_ImAdress;//5位指令地址输入
	wire [31:0]  	im_OpCode;//32位指令输出

	//IF_ID
	wire [31:0]		ifid_pcin;//pc+4输入
	wire [31:0]		ifid_irin;//32位指令输入
	wire [31:0]		ifid_irout;//32位指令输出
	wire [31:0]		ifid_pcout;//pc+4输?
	wire			ifid_stall;

	//gpr
	wire 			gpr_WE;//寄存器写
	wire [4:0] 		gpr_WeSel,gpr_ReSel1,gpr_ReSel2;//写选择，读选择
	wire [31:0] 	gpr_WData;//写数据
	wire [31:0] 	gpr_DataOut1,gpr_DataOut2;//读数据

	//ctrl
	wire [5:0]		ctrl_OpCode;//op前6位输入
	wire [5:0]		ctrl_funct;//6位功能码输入
	wire 			ctrl_jump;//jump指令
	wire 			ctrl_RegDst;//写寄存器选择					
	wire 			ctrl_Branch;//条件分支
	wire 			ctrl_MemR;//读寄存器
	wire 			ctrl_Mem2R;//数据存储器到寄存器堆
	wire 			ctrl_MemW;//写数据存储器
	wire 			ctrl_RegW;//寄存器堆写入数据
	wire 			ctrl_Alusrc;//运算器操作数选择
	wire [1:0] 		ctrl_ExtOp;//符号扩展选择
	wire [4:0]		ctrl_Aluctrl;//Alu运算模式选择
	wire			ctrl_bne;//是否为bne指令

	//extender
	wire [15:0] 	ex_DataIn;//16位符号扩展数据输入
	wire [1:0] 		ex_ExtOp;//2位符号扩展模式选择符输入
	wire [31:0] 	ex_ExtOut;//32位符号扩展输出

	//ID_EXE
	wire [31:0]		idexe_pc_4_in;//32位pc+4输入
	wire [31:0]		idexe_ir_in;//32位指令输入
	wire [31:0]		idexe_register_read1_in;//32位寄存器数据读入1
	wire [31:0]		idexe_register_read2_in;//32位寄存器数据读入2
	wire [4:0]		idexe_ir_2016_in;//20-16位指令输入
	wire [4:0]		idexe_ir_1511_in;//15-11位指令读入
	wire [15:0]		idexe_ir_150_in;//15-0位指令读入
	wire 			idexe_Reg_Dst_in;//写寄存器选择
	wire			idexe_Reg_Write_in;//寄存器写
	wire [4:0]		idexe_ALUctrl_in;
	wire			idexe_ALUSrc_in;
	wire			idexe_Branch_in;
	wire			idexe_Mem2R_in;
	wire			idexe_Mem_Write_in;
	wire			idexe_Mem_Read_in;
	wire [31:0]		idexe_pc_4_out;
	wire [31:0]		idexe_ir_out;
	wire [31:0]		idexe_register_read1_out;
	wire [31:0]		idexe_register_read2_out;
	wire [4:0]		idexe_ir_2016_out;
	wire [4:0]		idexe_ir_1511_out;
	wire [15:0]		idexe_ir_150_out;
	wire			idexe_Reg_Dst_out;
	wire			idexe_Reg_Write_out;
	wire [4:0]		idexe_ALUctrl_out;
	wire			idexe_ALUSrc_out;
	wire			idexe_Branch_out;
	wire			idexe_Mem2R_out;
	wire			idexe_Mem_Write_out;
	wire			idexe_Mem_Read_out;
	wire [31:0]		idexe_ext_in;
	wire [31:0]		idexe_ext_out;
	wire 			idexe_bne_in;
	wire  			idexe_bne_out;

	//alu
	wire [31:0] 	alu_DataIn1;//运算数据1
	wire [31:0]		alu_DataIn2;//运算数据2
	wire [4:0]		alu_AluCtrl;//运算器控制信号
	wire [5:0]		alu_offset;
	wire			alu_bne;
	wire [31:0]		alu_AluResult;//运算器输出结果
	wire			alu_Zero;//结果是否为零

	//adder
	wire [31:0] 	adder_pcin;//pc+4输入
	wire [31:0]		adder_exin;//偏移地址输入
	wire [31:0]		adder_pcout;//分支目标地址输出

	//rtmux
	wire			rtmux_sel;//alusrc
	wire [31:0]		rtmux_imme;//立即数输入
	wire [31:0]		rtmux_rt;//第二个读寄存器输入
	wire [31:0]		rtmux_result;//二选一输出

	//wbrmux
	wire 			wbrmux_regdst;
	wire [4:0]		wbrmux_lw_target;
	wire [4:0]		wbrmux_r_target;
	wire [4:0]		wbrmux_result;

	//EXE_MEM
	wire [31:0]		exemem_pc_branch_in;
	wire [31:0]		exemem_alu_result_in;
	wire			exemem_alu_zero_in;
	wire [31:0]		exemem_rt_data_in;
	wire [4:0]		exemem_r_target_in;
	wire			exemem_Branch_in;
	wire			exemem_Mem_Read_in;
	wire			exemem_Mem_Write_in;
	wire			exemem_Register_Write_in;
	wire			exemem_M2R_in;
	wire [31:0]		exemem_pc_branch_out;
	wire [31:0]		exemem_alu_result_out;
	wire			exemem_alu_zero_out;
	wire [31:0]		exemem_rt_data_out;
	wire [4:0]		exemem_r_target_out;
	wire			exemem_Branch_out;
	wire			exemem_Mem_Read_out;
	wire			exemem_Mem_Write_out;
	wire			exemem_Register_Write_out;
	wire			exemem_M2R_out;
	wire [4:0]		exemem_ir_2016_in;
	wire [4:0]		exemem_ir_2016_out;

	//DMem
	wire [4:0]  	dmem_DataAdr;
	wire [31:0] 	dmem_DataIn;
	wire 			dmem_DMemR;
	wire 			dmem_DMemW;
	wire [31:0] 	dmem_DataOut;

	//MEM_WB
	wire [31:0]		memwb_address_in;
	wire [31:0]		memwb_data_in;
	wire [4:0]		memwb_r_target_in;
	wire			memwb_Reg_Write_in;
	wire			memwb_M2R_in;
	wire [31:0]		memwb_address_out;
	wire [31:0]		memwb_data_out;
	wire [4:0]		memwb_r_target_out;
	wire			memwb_Reg_Write_out;
	wire			memwb_M2R_out;

	//wbmux
	wire 			wbmux_sel;
	wire [31:0]		wbmux_RegW;
	wire [31:0]		wbmux_MemO;
	wire [31:0]	    wbmux_Result;

	//forwared_ctrl
	wire			fc_exemem_regw;
	wire [4:0]		fc_exemem_regrd;
	wire [4:0]		fc_idexe_regrs;
	wire [4:0]		fc_idexe_regrt;
	wire			fc_memwb_regw;
	wire [4:0]		fc_memwb_regrd;
	wire [1:0]		fc_forward_a;
	wire [1:0]		fc_forward_b;

	//forward_a
	wire [1:0]		fa_forwarda;
	wire [31:0]		fa_gpr;
	wire [31:0]		fa_alu;
	wire [31:0]		fa_wb;
	wire [31:0]		fa_result;

	//forward_b
	wire [1:0]		fb_forwardb;
	wire [31:0]		fb_gpr;
	wire [31:0]		fb_alu;
	wire [31:0]		fb_wb;
	wire [31:0]		fb_result;

	//rst
	wire 			ifid_rst;
	wire 			idexe_rst;
	wire 			exemem_rst;
	wire 			memwb_rst;

	//hazard_detect
	wire			hd_idexe_memr;
	wire [4:0]		hd_idexe_regrt;
	wire [4:0]		hd_ifid_regrs;
	wire [4:0]		hd_ifid_regrt;
	wire			hd_stall;

	//j_ctrl
	wire [25:0]		jc_jaddress;
	wire [3:0]		jc_pc_4_high;
	wire [31:0]		jc_pc_j_out;

	//forward_m
	wire [4:0]		fm_w_reg_target;
	wire [4:0]		fm_w_mem_source;
	wire [31:0]		fm_w_reg_data;
	wire [31:0]		fm_w_mem_data;
	wire [31:0]		fm_result;
	wire			fm_wb;
	wire			fm_mw;
	
	//PC实例化
	assign pc_sel=((exemem_Branch_out&&exemem_alu_zero_out)==1)?1:0;
	assign pc_branch_address=exemem_pc_branch_out;
	assign pc_stall=hd_stall;
	assign pc_jump=ctrl_jump && (pc_sel!=1) && ((alu_Zero && idexe_Branch_out)!=1);
	assign pc_jaddress=jc_pc_j_out;
	pipe_PcUnit U_pipe_PcUnit(.clk(clk),.rst(rst),.sel(pc_sel),.branch_address(pc_branch_address),.pcout(pc_pcout),.pc_4(pc_pc_4),.stall(pc_stall),.jump(pc_jump),.jaddress(pc_jaddress));

	//IM实例化
	assign im_ImAdress=pc_pcout[6:2];
	IM U_IM(.OpCode(im_OpCode),.ImAdress(im_ImAdress));

	//IF_ID实例化
	assign ifid_pcin=pc_pc_4;
	assign ifid_irin=im_OpCode;
	assign ifid_rst=(pc_sel==1)?1:0;
	assign ifid_stall=hd_stall;
	IF_ID U_IF_ID(.clk(clk),.rst(ifid_rst),.pcin(ifid_pcin),.irin(ifid_irin),.pcout(ifid_pcout),.irout(ifid_irout),.stall(ifid_stall));

	//gpr实例化
	assign gpr_ReSel1=ifid_irout[25:21];
	assign gpr_ReSel2=ifid_irout[20:16];
	assign gpr_WE=memwb_Reg_Write_out;
	assign gpr_WData=wbmux_Result;
	assign gpr_WeSel=memwb_r_target_out;
	pipe_gpr U_pipe_gpr(.DataOut1(gpr_DataOut1),.DataOut2(gpr_DataOut2),.clk(clk),.WData(gpr_WData),.WE(gpr_WE),.WeSel(gpr_WeSel),.ReSel1(gpr_ReSel1),.ReSel2(gpr_ReSel2));

	//ctrl实例化
	assign ctrl_OpCode=ifid_irout[31:26];
	assign ctrl_funct=ifid_irout[5:0];
	Ctrl U_Ctrl(.jump(ctrl_jump),.RegDst(ctrl_RegDst),.Branch(ctrl_Branch),.MemR(ctrl_MemR),.Mem2R(ctrl_Mem2R),.MemW(ctrl_MemW),.RegW(ctrl_RegW),.Alusrc(ctrl_Alusrc),.ExtOp(ctrl_ExtOp),.Aluctrl(ctrl_Aluctrl),.OpCode(ctrl_OpCode),.funct(ctrl_funct),.bne(ctrl_bne));

	//extender实例化
	assign ex_DataIn=ifid_irout[15:0];
	assign ex_ExtOp=ctrl_ExtOp;
	pipe_extender U_pipe_extender(.ExtOut(ex_ExtOut),.DataIn(ex_DataIn),.ExtOp(ex_ExtOp));

	//ID_EXE实例化
	assign idexe_pc_4_in=ifid_pcout;
	assign idexe_ir_in=ifid_irout;
	assign idexe_register_read1_in=gpr_DataOut1;
	assign idexe_register_read2_in=gpr_DataOut2;
	assign idexe_ir_2016_in=ifid_irout[20:16];
	assign idexe_ir_1511_in=ifid_irout[15:11];
	assign idexe_ir_150_in=ifid_irout[15:0];
	assign idexe_Reg_Dst_in=ctrl_RegDst;
	assign idexe_Reg_Write_in=ctrl_RegW;
	assign idexe_ALUctrl_in=ctrl_Aluctrl[4:0];
	assign idexe_ALUSrc_in=ctrl_Alusrc;
	assign idexe_Branch_in=ctrl_Branch;
	assign idexe_Mem2R_in=ctrl_Mem2R;
	assign idexe_Mem_Write_in=ctrl_MemW;
	assign idexe_Mem_Read_in=ctrl_MemR;
	assign idexe_ext_in=ex_ExtOut;
	assign idexe_bne_in=ctrl_bne;
	assign idexe_rst=(hd_stall==1 || pc_sel==1 )?1:0;
	ID_EXE U_ID_EXE(.clk(clk),.rst(idexe_rst),
	.pc_4_in(idexe_pc_4_in),.ir_in(idexe_ir_in),.register_read1_in(idexe_register_read1_in),.register_read2_in(idexe_register_read2_in),.ir_2016_in(idexe_ir_2016_in),.ir_1511_in(idexe_ir_1511_in),.ir_150_in(idexe_ir_150_in),.Reg_Dst_in(idexe_Reg_Dst_in),.Reg_Write_in(idexe_Reg_Write_in),.ALUctrl_in(idexe_ALUctrl_in),.ALUctrl_out(idexe_ALUctrl_out),.ALUSrc_in(idexe_ALUSrc_in),.Branch_in(idexe_Branch_in),.Mem2R_in(idexe_Mem2R_in),.Mem_Write_in(idexe_Mem_Write_in),.Mem_Read_in(idexe_Mem_Read_in),
	.pc_4_out(idexe_pc_4_out),.ir_out(idexe_ir_out),.register_read1_out(idexe_register_read1_out),.register_read2_out(idexe_register_read2_out),.ir_2016_out(idexe_ir_2016_out),.ir_1511_out(idexe_ir_1511_out),.ir_150_out(idexe_ir_150_out),.Reg_Dst_out(idexe_Reg_Dst_out),.Reg_Write_out(idexe_Reg_Write_out),.ALUSrc_out(idexe_ALUSrc_out),.Branch_out(idexe_Branch_out),.Mem2R_out(idexe_Mem2R_out),.Mem_Write_out(idexe_Mem_Write_out),.Mem_Read_out(idexe_Mem_Read_out),
	.ext_in(idexe_ext_in),.ext_out(idexe_ext_out),.bne_in(idexe_bne_in),.bne_out(idexe_bne_out)
	);

	//alu实例化
	assign alu_DataIn1=fa_result;
	assign alu_DataIn2=rtmux_result;
	assign alu_AluCtrl=idexe_ALUctrl_out;
	assign alu_offset=idexe_ir_out[10:6];
	assign alu_bne=idexe_bne_out;
	pipe_alu U_pipe_alu(.AluResult(alu_AluResult),.Zero(alu_Zero),.DataIn1(alu_DataIn1),.DataIn2(alu_DataIn2),.AluCtrl(alu_AluCtrl),.offset(alu_offset),.bne(alu_bne));

	//adder实例化
	assign adder_pcin=idexe_pc_4_out;
	assign adder_exin=idexe_ext_out;
	pipe_adder U_pipe_adder(.pcin(adder_pcin),.exin(adder_exin),.pcout(adder_pcout));
	
	//rtmux实例化
	assign rtmux_sel=idexe_ALUSrc_out;//alusrc
	assign rtmux_imme=idexe_ext_out;//立即数输入
	assign rtmux_rt=fb_result;//第二个读寄存器输入
	pipe_rtmux U_pipe_rtmux(.sel(rtmux_sel),.imme(rtmux_imme),.rt(rtmux_rt),.result(rtmux_result));

	//wbrmux实例化
	assign wbrmux_regdst=idexe_Reg_Dst_out;
	assign wbrmux_lw_target=idexe_ir_2016_out;
	assign wbrmux_r_target=idexe_ir_1511_out;
	pipe_wbrmux U_pipe_wbrmux(.regdst(wbrmux_regdst),.lw_target(wbrmux_lw_target),.r_target(wbrmux_r_target),.result(wbrmux_result));

	//EXE_MEM实例化
	assign	exemem_pc_branch_in=adder_pcout;
	assign	exemem_alu_result_in=alu_AluResult;
	assign	exemem_alu_zero_in=alu_Zero;
	assign	exemem_rt_data_in=idexe_register_read2_out;
	assign	exemem_r_target_in=wbrmux_result;
	assign	exemem_Branch_in=idexe_Branch_out;
	assign	exemem_Mem_Read_in=idexe_Mem_Read_out;
	assign	exemem_Mem_Write_in=idexe_Mem_Write_out;
	assign	exemem_Register_Write_in=idexe_Reg_Write_out;
	assign	exemem_M2R_in=idexe_Mem2R_out;
	assign 	exemem_ir_2016_in=idexe_ir_2016_out;
	//assign  exemem_rst=(pc_sel==1)?1:0;
	EXE_MEM U_EXE_MEM(.clk(clk),.rst(rst),
	.pc_branch_in(exemem_pc_branch_in),.alu_result_in(exemem_alu_result_in),.alu_zero_in(exemem_alu_zero_in),.rt_data_in(exemem_rt_data_in),.r_target_in(exemem_r_target_in),.Branch_in(exemem_Branch_in),.Mem_Read_in(exemem_Mem_Read_in),.Mem_Write_in(exemem_Mem_Write_in),.Register_Write_in(exemem_Register_Write_in),.M2R_in(exemem_M2R_in),
	.pc_branch_out(exemem_pc_branch_out),.alu_result_out(exemem_alu_result_out),.alu_zero_out(exemem_alu_zero_out),.rt_data_out(exemem_rt_data_out),.r_target_out(exemem_r_target_out),.Branch_out(exemem_Branch_out),.Mem_Read_out(exemem_Mem_Read_out),.Mem_Write_out(exemem_Mem_Write_out),.Register_Write_out(exemem_Register_Write_out),.M2R_out(exemem_M2R_out),
	.ir_2016_in(exemem_ir_2016_in),.ir_2016_out(exemem_ir_2016_out));

	//DMem实例化
	assign  dmem_DataAdr=exemem_alu_result_out[4:0];
	assign 	dmem_DataIn=fm_result;
	assign 	dmem_DMemR=exemem_Mem_Read_out;
	assign 	dmem_DMemW=exemem_Mem_Write_out;
	pipe_DMem U_pipe_DMem(.DataOut(dmem_DataOut),.DataAdr(dmem_DataAdr),.DataIn(dmem_DataIn),.DMemW(dmem_DMemW),.DMemR(dmem_DMemR),.clk(clk));

	//MEM_WB实例化
	assign	memwb_address_in=exemem_alu_result_out;
	assign	memwb_data_in=dmem_DataOut;
	assign	memwb_r_target_in=exemem_r_target_out;
	assign	memwb_Reg_Write_in=exemem_Register_Write_out;
	assign	memwb_M2R_in=exemem_M2R_out;
	assign  memwb_rst=(hd_stall==1)?1:0;
	MEM_WB U_MEM_WB(.clk(clk),.rst(memwb_rst),
	.address_in(memwb_address_in),.data_in(memwb_data_in),.r_target_in(memwb_r_target_in),.Reg_Write_in(memwb_Reg_Write_in),.M2R_in(memwb_M2R_in),
	.address_out(memwb_address_out),.data_out(memwb_data_out),.r_target_out(memwb_r_target_out),.Reg_Write_out(memwb_Reg_Write_out),.M2R_out(memwb_M2R_out));

	//wbmux实例化
	assign	wbmux_sel=memwb_M2R_out;
	assign	wbmux_RegW=memwb_address_out;
	assign	wbmux_MemO=memwb_data_out;
	pipe_wbmux U_pipe_wbmux(.sel(wbmux_sel),.RegW(wbmux_RegW),.MemO(wbmux_MemO),.Result(wbmux_Result));

	//forwared_ctrl
	assign	fc_exemem_regw=exemem_Register_Write_out;
	assign	fc_exemem_regrd=exemem_r_target_out;
	assign	fc_idexe_regrs=idexe_ir_out[25:21];
	assign	fc_idexe_regrt=idexe_ir_2016_out;
	assign	fc_memwb_regw=memwb_Reg_Write_out;
	assign	fc_memwb_regrd=memwb_r_target_out;
	pipe_forward_ctrl U_pipe_forward_ctrl(.clk(clk),.exemem_regw(fc_exemem_regw),.exemem_regrd(fc_exemem_regrd),.idexe_regrs(fc_idexe_regrs),.idexe_regrt(fc_idexe_regrt),.memwb_regw(fc_memwb_regw),.memwb_regrd(fc_memwb_regrd),.forward_a(fc_forward_a),.forward_b(fc_forward_b));
	
	//forward_a实例化
	assign	fa_forwarda=fc_forward_a;
	assign	fa_gpr=idexe_register_read1_out;
	assign	fa_alu=exemem_alu_result_out;
	assign	fa_wb=wbmux_Result;
	pipe_forward_a U_pipe_forward_a(.forwarda(fa_forwarda),.gpr(fa_gpr),.alu(fa_alu),.wb(fa_wb),.result(fa_result));

	//forward_b实例化
	assign	fb_forwardb=fc_forward_b;
	assign	fb_gpr=idexe_register_read2_out;
	assign	fb_alu=exemem_alu_result_out;
	assign	fb_wb=wbmux_Result;
	pipe_forward_b U_pipe_forward_b(.forwardb(fb_forwardb),.gpr(fb_gpr),.alu(fb_alu),.wb(fb_wb),.result(fb_result));

	//hazard_detect实例化
	assign	hd_idexe_memr=idexe_Mem_Read_out;
	assign	hd_idexe_regrt=idexe_ir_2016_out;
	assign	hd_ifid_regrs=ifid_irout[25:21];
	assign	hd_ifid_regrt=ifid_irout[20:16];
	pipe_hazard_detect U_pipe_hazard_detect(.clk(clk),.idexe_memr(hd_idexe_memr),.idexe_regrt(hd_idexe_regrt),.ifid_regrs(hd_ifid_regrs),.ifid_regrt(hd_ifid_regrt),.stall(hd_stall));

	//j_ctrl实例化
	assign	jc_jaddress=ifid_irout[26:0];
	assign	jc_pc_4_high=ifid_pcout[31:28];
	j_ctrl U_j_ctrl(.jaddress(jc_jaddress),.pc_4_high(jc_pc_4_high),.pc_j_out(jc_pc_j_out));

	//forward_m
	assign	fm_w_reg_target=exemem_r_target_out;
	assign	fm_w_mem_source=exemem_ir_2016_out;
	assign	fm_w_reg_data=memwb_address_out;
	assign	fm_w_mem_data=exemem_rt_data_out;
	assign  fm_wb=memwb_Reg_Write_out;
	assign	fm_mw=exemem_Mem_Write_out;
	pipe_forward_m U_pipe_forward_m(.w_reg_target(fm_w_reg_target),.w_mem_source(fm_w_mem_source),.w_reg_data(fm_w_reg_data),.w_mem_data(fm_w_mem_data),.result(fm_result),.mw(fm_mw),.wb(fm_wb));
endmodule