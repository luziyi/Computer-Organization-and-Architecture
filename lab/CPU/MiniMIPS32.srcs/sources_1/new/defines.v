`timescale 1ns / 1ps

/*------------------- ȫ�ֲ��� -------------------*/
`define RST_ENABLE 1'b0                // ��λ�ź���Ч  RST_ENABLE
`define RST_DISABLE 1'b1                // ��λ�ź���Ч
`define ZERO_WORD 32'h00000000        // 32λ����ֵ0
`define ZERO_DWORD 64'b0               // 64λ����ֵ0
`define WRITE_ENABLE 1'b1                // ʹ��д
`define WRITE_DISABLE 1'b0                // ��ֹд
`define READ_ENABLE 1'b1                // ʹ�ܶ�
`define READ_DISABLE 1'b0                // ��ֹ��
`define MREG_ENABLE 1'b1                // �洢�����Ĵ���ʹ���ź���Ч
`define MREG_DISABLE 1'b0                // �洢�����Ĵ���ʹ���ź���Ч
`define RT_ENABLE 1'b1                // Ŀ�ļĴ���ѡ���ź���Ч
`define RT_DISABLE 1'b0                // Ŀ�ļĴ���ѡ���ź���Ч
`define SHIFT_ENABLE 1'b1                // ��λʹ���ź���Ч
`define SHIFT_DISABLE 1'b0                // ��λʹ���ź���Ч
`define WHILO_ENABLE 1'b1                //ʹ��дhilo
`define WHILO_DISABLE 1'b0                //��ֹдhilo
`define STOP_ENABLE 1'b1                // ��ͣʹ���ź���Ч
`define STOP_DISABLE 1'b0                // ��ͣʹ���ź���Ч
`define ALUOP_BUS 7 : 0               // ����׶ε����aluop_o�Ŀ��
`define SHIFT_ENABLE 1'b1                // ��λָ��ʹ�� 
`define ALUTYPE_BUS 2 : 0               // ����׶ε����alutype_o�Ŀ��  
`define TRUE_V 1'b1                // �߼�"��"  
`define FALSE_V 1'b0                // �߼�"��"  
`define CHIP_ENABLE 1'b1                // оƬʹ��  
`define CHIP_DISABLE 1'b0                // оƬ��ֹ  
`define WORD_BUS 31: 0               // 32λ��
`define DOUBLE_REG_BUS 63: 0               // ������ͨ�üĴ����������߿��
`define RT_ENABLE 1'b1                // rtѡ��ʹ��
`define SIGNED_EXT 1'b1                // ������չʹ��
`define IMM_ENABLE 1'b1                // ������ѡ��ʹ��
`define UPPER_ENABLE 1'b1                // ��������λʹ��
`define MREG_ENABLE 1'b1                // д�ؽ׶δ洢�����ѡ���ź�
`define BSEL_BUS 3 : 0               // ���ݴ洢���ֽ�ѡ���źſ��
`define PC_INIT 32'hBFC00000        // PC��ʼֵ

/*------------------- ָ���ֲ��� -------------------*/
`define INST_ADDR_BUS 31: 0               // ָ��ĵ�ַ���
`define INST_BUS 31: 0               // ָ������ݿ��

// ��������alutype
`define NOP 3'b000
`define ARITH 3'b001
`define LOGIC 3'b010
`define MOVE 3'b011
`define SHIFT 3'b100
`define STORE 3'b101
`define JUMP 3'b110
`define PRIVILEGE 3'b111
// �ڲ�������aluop
//��������ָ��
`define MINIMIPS32_ADD 8'h10
`define MINIMIPS32_ADDI 8'h11
`define MINIMIPS32_ADDU 8'h12
`define MINIMIPS32_ADDIU 8'h13
`define MINIMIPS32_SUB 8'h14
`define MINIMIPS32_SUBU 8'h15
`define MINIMIPS32_SLT 8'h16
`define MINIMIPS32_SLTI 8'h17
`define MINIMIPS32_SLTU 8'h18
`define MINIMIPS32_SLTIU 8'h19
`define MINIMIPS32_MULT 8'h1A
`define MINIMIPS32_MULTU 8'h1B
//�߼�����ָ��
`define MINIMIPS32_AND 8'h1C
`define MINIMIPS32_ANDI 8'h1D
`define MINIMIPS32_LUI 8'h1E
`define MINIMIPS32_NOR 8'h1F
`define MINIMIPS32_OR 8'h20
`define MINIMIPS32_ORI 8'h21
`define MINIMIPS32_XOR 8'h22
`define MINIMIPS32_XORI 8'h23

//��λָ��
`define MINIMIPS32_SLL 8'h24
`define MINIMIPS32_SLLV 8'h25
`define MINIMIPS32_SRA 8'h26
`define MINIMIPS32_SRAV 8'h27
`define MINIMIPS32_SRL 8'h28
`define MINIMIPS32_SRLV 8'h29
//�����ƶ�ָ��
`define MINIMIPS32_MFHI 8'h2A
`define MINIMIPS32_MFLO 8'h2B
`define MINIMIPS32_MTHI 8'h2C
`define MINIMIPS32_MTLO 8'h2D

//�ô�ָ��
`define MINIMIPS32_LB 8'h2E
`define MINIMIPS32_LBU 8'h2F
`define MINIMIPS32_LH 8'h30
`define MINIMIPS32_LHU 8'h31
`define MINIMIPS32_LW 8'h32
`define MINIMIPS32_SB 8'h33
`define MINIMIPS32_SH 8'h34
`define MINIMIPS32_SW 8'h35
//ת��ָ��
`define MINIMIPS32_BEQ 8'h36
`define MINIMIPS32_BNE 8'h37
`define MINIMIPS32_BGEZ 8'h38
`define MINIMIPS32_BGTZ 8'h39
`define MINIMIPS32_BLEZ 8'h3A
`define MINIMIPS32_BLTZ 8'h3B
`define MINIMIPS32_BLTZAL 8'h3C
`define MINIMIPS32_BGEZAL 8'h3D
`define MINIMIPS32_J 8'h3E
`define MINIMIPS32_JAL 8'h3F
`define MINIMIPS32_JR 8'h40
`define MINIMIPS32_JALR 8'h41
//����ָ��
`define MINIMIPS32_DIV 8'h42
`define MINIMIPS32_DIVU 8'h43
//CP0ָ��
`define MINIMIPS32_MFC0 8'h44
`define MINIMIPS32_MTC0 8'h45
//�쳣���ָ��
`define MINIMIPS32_SYSCALL 8'h46
`define MINIMIPS32_BREAK 8'h47
`define MINIMIPS32_ERET 8'h48

`define STOP 1'b1
`define START 1'b0
`define DIV_NOT_READY 1'b0
`define DIV_READY 1'b1
`define DIV_START 1'b1
`define DIV_STOP 1'b0
`define DIV_FREE 2'b00
`define DIV_ON 2'b01
`define DIV_FINISHED 2'b10
`define DIV_ZERO 2'b11
/*------------------- ͨ�üĴ����Ѳ��� -------------------*/
`define REG_BUS 31: 0               // �Ĵ������ݿ��
`define REG_ADDR_BUS 4 : 0               // �Ĵ����ĵ�ַ���
`define REG_NUM 32                  // �Ĵ�������32��
`define REG_NOP 5'b00000            // ��żĴ���

//.....exception argument
// need for exetype
`define Int 0               
`define ADEL 4              
`define ADES 5                  
`define Sys 8           
`define BP 9                
`define RI 10 
`define Ov 12
`define noexe 1
`define Eret 26  //a way to realize eret instruction
`define EXCTYPE_BUS 4:0  
`define EXEADDR 32'hbfc00380  
//cp0 regfile
`define BadVAddr_ID 8               
`define Status_ID 12              
`define Cause_ID 13                  
`define EPC_ID 14   
`define BadVAddr_init 32'h00000000
`define Status_init 32'h00000000              
`define Cause_init 32'h00000004                  
`define EPC_init 32'h00000000 

`define op_len 5:0
`define funct_len 5:0
`define rs_len 4:0
`define rt_len 4:0
`define rd_len 4:0
`define sa_len 4:0
`define imm_len 15:0
`define instr_index_len 25:0
`define INT_LEN 5:0
