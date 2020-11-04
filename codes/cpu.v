module openmips(

    input   wire                                        clk,
    input wire                                      rst,


    input wire[`RegBus]           rom_data_i,
    output wire[`RegBus]           rom_addr_o,
    output wire                    rom_ce_o,

  //连接数据存储器
    input wire[`RegBus]           ram_data_i,
    output wire[`RegBus]           ram_addr_o,
    output wire[`RegBus]           ram_data_o,
    output wire                    ram_we_o,
    output wire[3:0]               ram_sel_o,
    output wire[3:0]               ram_ce_o

);

// 把其他模块连起来
