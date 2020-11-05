`default_nettype none

module thinpad_top(
    input wire clk_50M,           //50MHz 时钟输入
    input wire clk_11M0592,       //11.0592MHz 时钟输入（备用，可不用）

    input wire clock_btn,         //BTN5手动时钟按钮开关，带消抖电路，按下时为1
    input wire reset_btn,         //BTN6手动复位按钮开关，带消抖电路，按下时为1

    input  wire[3:0]  touch_btn,  //BTN1~BTN4，按钮开关，按下时为1
    input  wire[31:0] dip_sw,     //32位拨码开关，拨到“ON”时为1
    output wire[15:0] leds,       //16位LED，输出时1点亮
    output wire[7:0]  dpy0,       //数码管低位信号，包括小数点，输出1点亮
    output wire[7:0]  dpy1,       //数码管高位信号，包括小数点，输出1点亮

    //CPLD串口控制器信号
    output wire uart_rdn,         //读串口信号，低有效
    output wire uart_wrn,         //写串口信号，低有效
    input wire uart_dataready,    //串口数据准备好
    input wire uart_tbre,         //发送数据标志
    input wire uart_tsre,         //数据发送完毕标志

    //BaseRAM信号
    inout wire[31:0] base_ram_data,  //BaseRAM数据，低8位与CPLD串口控制器共享
    output wire[19:0] base_ram_addr, //BaseRAM地址
    output wire[3:0] base_ram_be_n,  //BaseRAM字节使能，低有效。如果不使用字节使能，请保持为0
    output wire base_ram_ce_n,       //BaseRAM片选，低有效
    output wire base_ram_oe_n,       //BaseRAM读使能，低有效
    output wire base_ram_we_n,       //BaseRAM写使能，低有效

    //ExtRAM信号
    inout wire[31:0] ext_ram_data,  //ExtRAM数据
    output wire[19:0] ext_ram_addr, //ExtRAM地址
    output wire[3:0] ext_ram_be_n,  //ExtRAM字节使能，低有效。如果不使用字节使能，请保持为0
    output wire ext_ram_ce_n,       //ExtRAM片选，低有效
    output wire ext_ram_oe_n,       //ExtRAM读使能，低有效
    output wire ext_ram_we_n,       //ExtRAM写使能，低有效

    //直连串口信号
    output wire txd,  //直连串口发送端
    input  wire rxd,  //直连串口接收端

    //Flash存储器信号，参考 JS28F640 芯片手册
    output wire [22:0]flash_a,      //Flash地址，a0仅在8bit模式有效，16bit模式无意义
    inout  wire [15:0]flash_d,      //Flash数据
    output wire flash_rp_n,         //Flash复位信号，低有效
    output wire flash_vpen,         //Flash写保护信号，低电平时不能擦除、烧写
    output wire flash_ce_n,         //Flash片选信号，低有效
    output wire flash_oe_n,         //Flash读使能信号，低有效
    output wire flash_we_n,         //Flash写使能信号，低有效
    output wire flash_byte_n,       //Flash 8bit模式选择，低有效。在使用flash的16位模式时请设为1

    //USB 控制器信号，参考 SL811 芯片手册
    output wire sl811_a0,
    //inout  wire[7:0] sl811_d,     //USB数据线与网络控制器的dm9k_sd[7:0]共享
    output wire sl811_wr_n,
    output wire sl811_rd_n,
    output wire sl811_cs_n,
    output wire sl811_rst_n,
    output wire sl811_dack_n,
    input  wire sl811_intrq,
    input  wire sl811_drq_n,

    //网络控制器信号，参考 DM9000A 芯片手册
    output wire dm9k_cmd,
    inout  wire[15:0] dm9k_sd,
    output wire dm9k_iow_n,
    output wire dm9k_ior_n,
    output wire dm9k_cs_n,
    output wire dm9k_pwrst_n,
    input  wire dm9k_int,

    //图像输出信号
    output wire[2:0] video_red,    //红色像素，3位
    output wire[2:0] video_green,  //绿色像素，3位
    output wire[1:0] video_blue,   //蓝色像素，2位
    output wire video_hsync,       //行同步（水平同步）信号
    output wire video_vsync,       //场同步（垂直同步）信号
    output wire video_clk,         //像素时钟输出
    output wire video_de           //行数据有效信号，用于区分消隐区
);


// PLL分频示例
wire locked, clk_10M, clk_20M;
pll_example clock_gen 
 (
  // Clock in ports
  .clk_in1(clk_50M),  // 外部时钟输入
  // Clock out ports
  .clk_out1(clk_10M), // 时钟输出1，频率在IP配置界面中设置
  .clk_out2(clk_20M), // 时钟输出2，频率在IP配置界面中设置
  // Status and control signals
  .reset(reset_btn), // PLL复位输入
  .locked(locked)    // PLL锁定指示输出，"1"表示时钟稳定，
                     // 后级电路复位信号应当由它生成（见下）
 );

reg reset_of_clk10M;
// 异步复位，同步释放，将locked信号转为后级电路的复位reset_of_clk10M
always@(posedge clk_10M or negedge locked) begin
    if(~locked) reset_of_clk10M <= 1'b1;
    else        reset_of_clk10M <= 1'b0;
end

// always@(posedge clk_10M or posedge reset_of_clk10M) begin
//     if(reset_of_clk10M)begin
//         // Your Code
//     end
//     else begin
//         // Your Code
//     end
// end



//disable byte
assign base_ram_be_n = 4'b0000;
assign ext_ram_be_n = 4'b0000;

//disable ext ram
assign ext_ram_ce_n = 1'b1;
assign ext_ram_oe_n = 1'b1;
assign ext_ram_we_n = 1'b1;

// disable uart
assign uart_rdn = 1'b1;
assign uart_wrn = 1'b1;

wire clk = clk_11M0592;
wire rst = reset_btn; 

wire[31:0] data_sram_out;
wire sram_done;
reg oe_sram_n, we_sram_n;
reg[19:0] address; // 喂给sram的地址
assign base_ram_addr = address;
reg[31:0] data_sram_in;

sram_io _sram_io(
    .clk(clk),
    .rst(rst),
    .oen(oe_sram_n),
    .wen(we_sram_n),
    .data_in(data_sram_in),
    .data_out(data_sram_out),
    .done(sram_done),
    .base_ram_data_wire(base_ram_data),
    .base_ram_ce_n(base_ram_ce_n),
    .base_ram_oe_n(base_ram_oe_n),
    .base_ram_we_n(base_ram_we_n)
);

reg reg_we;
reg[`DataBus] reg_wdata;
wire[`RegAddrBus] reg1_addr;
wire[`DataBus] reg1_data;
wire[`RegAddrBus] reg2_addr;
wire[`DataBus] reg2_data;
regfile _regfile(
    .clk(clk),
    .rst(rst),
    .we(reg_we),
    .waddr(wb_reg_addr),
    .wdata(reg_wdata),
    .raddr1(reg1_addr),
    .rdata1(reg1_data),
    .raddr2(reg2_addr),
    .rdata2(reg2_data)
);

wire instValid, branch, mem_rd, mem_wr, wb;
wire[`InstAddrBus] branch_addr;
wire[2:0] load_type;
wire[`DataBus] mem_wr_data;
wire[`DataAddrBus] mem_addr;
wire[`RegAddrBus] wb_reg_addr;
wire[`DataBus] wb_data;
exe _exe(
    .pc(pc),
    .inst(inst),
    .reg1_data_i(reg1_data),
    .reg2_data_i(reg2_data),
    .reg1_addr_o(reg1_addr),
    .reg2_addr_o(reg2_addr),
    .instValid(instValid),
    .branch(branch),
    .branch_addr(branch_addr),
    .mem_rd(mem_rd),
    .load_type(load_type),
    .mem_wr(mem_wr),
    .mem_wr_data(mem_wr_data),
    .mem_addr(mem_addr),
    .wb(wb),
    .wb_reg_addr(wb_reg_addr),
    .wb_data(wb_data)
);
// program counter
reg [`InstAddrBus] pc;
// instruction
reg [`InstBus] inst;
reg [`StateBus] state;
  
always@(posedge clk or posedge rst) begin
    if(rst)begin
        pc <= 32'b0;
        {oe_sram_n, we_sram_n} <= 2'b11;
        state <= `STATE_BOOT;
        inst <= 32'b0;
        address <= 20'b0;
        data_sram_in <= 32'b0;
        reg_we <= 1'b0;
    end
    else begin
        case (state) 
            `STATE_BOOT: begin
                address <= pc[21:2];
                oe_sram_n <= 1'b0;
                state <= `STATE_IF;
            end
            `STATE_IF: begin
                if(sram_done) begin
                    oe_sram_n <= 1'b1;
                    inst <= data_sram_out;
                    state <= `STATE_EXE;
                end
            end
            `STATE_EXE: begin
                pc <= branch ? branch_addr: pc + 4;
                if (mem_rd | mem_wr) begin
                    address <= mem_addr[21:2];
                    if (mem_rd) begin
                        oe_sram_n <= 1'b0;
                    end
                    else begin
                        we_sram_n <= 1'b0;
                        data_sram_in <= mem_wr_data;
                    end
                    state <= `STATE_MEM;
                end
                else begin
                    if (wb) begin
                        reg_we <= 1'b1;
                        reg_wdata <= wb_data;
                    end
                    // 写回也在这个阶段做完
                    // 不进行mem的已经可以开始检查串口了
                    state <= `STATE_UART;
                end
            end
            `STATE_MEM: begin
                if(sram_done) begin
                    {oe_sram_n, we_sram_n} <= 2'b11;
                    // 说明要做写回
                    if (mem_rd) begin
                        reg_we <= 1'b1;
                        reg_wdata <= data_sram_out;
                    end
                    state <= `STATE_UART;
                end
            end
            `STATE_UART: begin
                reg_we <= 1'b0; // 寄存器已写完
                // do nothing, prepare for if
                address <= pc[21:2];
                oe_sram_n <= 1'b0;
                state <= `STATE_IF;
            end
        endcase 
    end
end
endmodule

