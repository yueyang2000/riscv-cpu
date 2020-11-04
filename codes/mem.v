module mem(
    input wire                                      rst,

    //来自执行阶段的信息
    input wire[`RegAddrBus]       wd_i,
    input wire                    wreg_i,
    input wire[`RegBus]                   wdata_i,

  input wire[`AluOpBus]        aluop_i,
    input wire[`RegBus]          mem_addr_i,
    input wire[`RegBus]          reg2_i,

    //来自memory的信息
    input wire[`RegBus]          mem_data_i,

    //送到回写阶段的信息
    output reg[`RegAddrBus]      wd_o,
    output reg                   wreg_o,
    output reg[`RegBus]                  wdata_o,
    output reg                   whilo_o,

    //送到memory的信息
    output reg[`RegBus]          mem_addr_o,
    output wire                                  mem_we_o,
    output reg[3:0]              mem_sel_o,
    output reg[`RegBus]          mem_data_o,
    output reg                   mem_ce_o
);
// 写入操作比较单纯
