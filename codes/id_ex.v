module id_ex(

    input wire                      clk,
    input wire                      rst,

    //来自控制模块的信息
    input wire[5:0]                 stall,

    //从译码阶段传递的信息
    input wire[`AluOpBus]         id_aluop,
    input wire[`AluSelBus]        id_alusel,
    input wire[`RegBus]           id_reg1,
    input wire[`RegBus]           id_reg2,
    input wire[`RegAddrBus]       id_wd,
    input wire                    id_wreg,
    input wire[`RegBus]           id_link_address,
    input wire                    id_is_in_delayslot,
    input wire                    next_inst_in_delayslot_i,
    input wire[`RegBus]           id_inst,

    //传递到执行阶段的信息
    output reg[`AluOpBus]         ex_aluop,
    output reg[`AluSelBus]        ex_alusel,
    output reg[`RegBus]           ex_reg1,
    output reg[`RegBus]           ex_reg2,
    output reg[`RegAddrBus]       ex_wd,
    output reg                    ex_wreg,
    output reg[`RegBus]           ex_link_address,
  output reg                    ex_is_in_delayslot,
    output reg                    is_in_delayslot_o,
    output reg[`RegBus]           ex_inst

);

// stall[2] == `Stop && stall[3] == `NoStop 则下传一条空指令
// stall[2] == `NoStop 则正常下传
