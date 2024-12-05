`include "defines.v"

module ifid_reg (
    input wire cpu_clk_50M,
    input wire cpu_rst_n,

    // ����ȡָ�׶ε���Ϣ  
    input wire [`INST_ADDR_BUS] if_pc,
    input wire [`INST_ADDR_BUS] if_debug_wb_pc, // ������ʹ�õ�PCֵ���ϰ����ʱ���ɾ�����ź�

    input  wire [         3 : 0] stall,
    // signal from cp0
    input  wire                  flush,
    // ��������׶ε���Ϣ  
    output reg  [`INST_ADDR_BUS] id_pc,
    output reg  [`INST_ADDR_BUS] id_debug_wb_pc  // ������ʹ�õ�PCֵ���ϰ����ʱ���ɾ�����ź�
);

  always @(posedge cpu_clk_50M) begin
    // ��λ��ʱ����������׶ε���Ϣ��0
    if (cpu_rst_n == `RST_ENABLE) begin
      id_pc          <= `PC_INIT;
      id_debug_wb_pc <= `PC_INIT;  // �ϰ����ʱ���ɾ�������
    end  // ������ȡָ�׶ε���Ϣ�Ĵ沢��������׶�
    else begin
      if (stall[2] == `STOP_ENABLE && stall[1] == `STOP_ENABLE) begin
        id_pc          <= id_pc;
        id_debug_wb_pc <= id_debug_wb_pc;
      end else begin
        id_pc          <= if_pc;
        id_debug_wb_pc <= if_debug_wb_pc;  // �ϰ����ʱ���ɾ�������
      end
    end
  end

endmodule
