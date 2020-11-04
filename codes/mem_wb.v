module mem_wb(

    input   wire                                        clk,
    input wire                                      rst,

  //来自控制模块的信息
    input wire[5:0]               stall,

    //来自访存阶段的信息
    input wire[`RegAddrBus]       mem_wd,
    input wire                    mem_wreg,
    input wire[`RegBus]                  mem_wdata,

    //送到回写阶段的信息
    output reg[`RegAddrBus]      wb_wd,
    output reg                   wb_wreg,
    output reg[`RegBus]                  wb_wdata,
);
// 写回就是控制regfile的写入

// stall[4] == `Stop && stall[5] == `NoStop 则下传空指令
// stall[4] == `NoStop 则正常下传
