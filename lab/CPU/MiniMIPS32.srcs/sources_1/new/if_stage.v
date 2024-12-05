`include "defines.v"

module if_stage (
    input wire                  cpu_clk_50M,
    input wire                  cpu_rst_n,
    //signal from idstage
    input wire [           1:0] jtsel,
    input wire [`INST_ADDR_BUS] jump_addr_1,
    input wire [`INST_ADDR_BUS] jump_addr_2,
    input wire [`INST_ADDR_BUS] jump_addr_3,
    input wire [         3 : 0] stall,
    //signal from cp0
    input wire                  flush,
    input wire [`INST_ADDR_BUS] excaddr,

    output reg                  ice,
    output reg [`INST_ADDR_BUS] pc,
    output     [`INST_ADDR_BUS] iaddr,
    output     [`INST_ADDR_BUS] debug_wb_pc  // ������ʹ�õ�PCֵ���ϰ����ʱ���ɾ�����ź�
);

  reg [`INST_ADDR_BUS] pc_next;
  reg [`INST_ADDR_BUS] pc_tp;
  always @(*) begin
    if (jtsel == 2'b01) pc_next = jump_addr_1;
    else if (jtsel == 2'b10) pc_next = jump_addr_2;
    else if (jtsel == 2'b11) pc_next = jump_addr_3;
    else pc_next = pc + 4;
  end
  always @(*) begin
    if (cpu_rst_n == `RST_ENABLE) begin
      ice = `CHIP_DISABLE;  // ��λ��ʱ��ָ��洢������  
    end else begin
      ice = (stall[3] == `STOP_ENABLE) ? `CHIP_DISABLE : `CHIP_ENABLE;  // ��λ������ָ��洢��ʹ��
    end
  end

  always @(posedge cpu_clk_50M) begin
    if (ice == `CHIP_DISABLE)
      if (stall[3] == `STOP_ENABLE) pc_tp <= pc;
      else pc_tp <= `PC_INIT;
    // ָ��洢�����õ�ʱ��PC���ֳ�ʼֵ��MiniMIPS32������Ϊ0x00000000��
    else begin
      pc_tp <= (stall[3] == `STOP_ENABLE) ? pc : pc_next;
    end
  end

  // TODO��ָ��洢���ķ��ʵ�ַû�и�����������Χ���н��й̶���ַӳ�䣬��Ҫ�޸�!!!
  //try
  always @(*) begin
    if (flush == 1) pc = excaddr;
    else pc = pc_tp;
  end
  assign iaddr       = (ice == `CHIP_DISABLE) ? `PC_INIT : pc;  // ��÷���ָ��洢���ĵ�ַ

  assign debug_wb_pc = pc;  // �ϰ����ʱ���ɾ�������

endmodule
