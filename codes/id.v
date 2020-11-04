module id(

    input wire                      rst,
    // 待译码指令对应的pc
    input wire[`InstAddrBus]        pc_i,
    input wire[`InstBus]            inst_i,

    //处于执行阶段的指令的一些信息，用于解决load相关
    input wire[`AluOpBus]           ex_aluop_i,

    //处于执行阶段的指令要写入的目的寄存器信息
    input wire                      ex_wreg_i,
    input wire[`RegBus]             ex_wdata_i,
    input wire[`RegAddrBus]         ex_wd_i,

    //处于访存阶段的指令要写入的目的寄存器信息
    input wire                      mem_wreg_i,
    input wire[`RegBus]             mem_wdata_i,
    input wire[`RegAddrBus]         mem_wd_i,

    // 两个操作数
    input wire[`RegBus]             reg1_data_i,
    input wire[`RegBus]             reg2_data_i,

    //如果上一条指令是转移指令，那么下一条指令在译码的时候is_in_delayslot为true
    input wire                    is_in_delayslot_i,

    //送到regfile的信息，
    output reg                    reg1_read_o,
    output reg                    reg2_read_o,
    output reg[`RegAddrBus]       reg1_addr_o,
    output reg[`RegAddrBus]       reg2_addr_o,

    //送到执行阶段的信息
    output reg[`AluOpBus]         aluop_o,
    output reg[`AluSelBus]        alusel_o,
    output reg[`RegBus]           reg1_o,
    output reg[`RegBus]           reg2_o,
    output reg[`RegAddrBus]       wd_o,
    output reg                    wreg_o,
    output wire[`RegBus]          inst_o,

    // output reg                    next_inst_in_delayslot_o,

    // 是否发生了转移
    output reg                    branch_flag_o,
    // 转移的目的地址
    output reg[`RegBus]           branch_target_address_o,
    // 转移指令要保存的返回地址
    output reg[`RegBus]           link_addr_o,

    // output reg                    is_in_delayslot_o,
    output wire                   stallreq
);


// 如果访问了exe阶段要写的寄存器，直接用
// 如果exe阶段是个load，则需要暂停一个周期
// 如果访问了mem阶段要写的寄存器，直接用，优先级小于exe阶段
// 如果是转移指令，要在译码阶段检测到转移的发生，同时把要转移的位置算出来

