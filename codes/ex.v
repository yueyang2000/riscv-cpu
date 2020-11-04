module ex(

    input wire                                      rst,

    //送到执行阶段的信息
    input wire[`AluOpBus]         aluop_i,
    input wire[`AluSelBus]        alusel_i,
    input wire[`RegBus]           reg1_i,
    input wire[`RegBus]           reg2_i,
    input wire[`RegAddrBus]       wd_i,
    input wire                    wreg_i,
    input wire[`RegBus]           inst_i,

    input wire[`DoubleRegBus]     hilo_temp_i,
    input wire[1:0]               cnt_i,

    //与除法模块相连
    input wire[`DoubleRegBus]     div_result_i,
    input wire                    div_ready_i,

    //是否转移、以及link address
    input wire[`RegBus]           link_address_i,
    input wire                    is_in_delayslot_i,

    output reg[`RegAddrBus]       wd_o,
    output reg                    wreg_o,
    output reg[`RegBus]             wdata_o,

    output reg[`RegBus]           hi_o,
    output reg[`RegBus]           lo_o,
    output reg                    whilo_o,

    output reg[`DoubleRegBus]     hilo_temp_o,
    output reg[1:0]               cnt_o,

    output reg[`RegBus]           div_opdata1_o,
    output reg[`RegBus]           div_opdata2_o,
    output reg                    div_start_o,
    output reg                    signed_div_o,

    //下面新增的几个输出是为加载、存储指令准备的
    output wire[`AluOpBus]        aluop_o,
    output wire[`RegBus]          mem_addr_o,
    output wire[`RegBus]          reg2_o,

    output reg                      stallreq

);

// 有一些控制信号要下传，主要是与load/store相关
// exe阶段应该是很直接的，基础指令也不需要暂停
