
module ex_mem(

    input   wire                                        clk,
    input wire                                      rst,

    //来自控制模块的信息
    input wire[5:0]                          stall,

    //来自执行阶段的信息
    input wire[`RegAddrBus]       ex_wd,
    input wire                    ex_wreg,
    input wire[`RegBus]                  ex_wdata,

  //为实现加载、访存指令而添加
  input wire[`AluOpBus]        ex_aluop,
    input wire[`RegBus]          ex_mem_addr,
    input wire[`RegBus]          ex_reg2,

    //送到访存阶段的信息
    output reg[`RegAddrBus]      mem_wd,
    output reg                   mem_wreg,
    output reg[`RegBus]                  mem_wdata,

  //为实现加载、访存指令而添加
  output reg[`AluOpBus]        mem_aluop,
    output reg[`RegBus]          mem_mem_addr,
    output reg[`RegBus]          mem_reg2,
);

// 不需要hi, lo寄存器
// stall[3] == `Stop && stall[4] == `NoStop 则下传空指令
// stall[3] == `NoStop 正常下传
