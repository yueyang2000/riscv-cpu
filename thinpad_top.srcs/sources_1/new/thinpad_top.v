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

wire clk = clk_50M;
wire rst = reset_btn; 

reg oe_uart_n, we_uart_n;
reg[7:0] data_uart_in;
wire[7:0] data_uart_out;
wire uart_done;
uart_io _uart_io(
    .clk(clk),
    .rst(reset_btn),
    .oen(oe_uart_n),
    .wen(we_uart_n),
    .data_in(data_uart_in),
    .data_out(data_uart_out),
    .done(uart_done),
    .base_ram_data_wire(base_ram_data),
    .uart_rdn(uart_rdn), 
    .uart_wrn(uart_wrn), 
    .uart_dataready(uart_dataready),
    .uart_tbre(uart_tbre), 
    .uart_tsre(uart_tsre)
);



wire[`DataBus] data_base_out;
wire base_done;
reg oe_base_n, we_base_n;
reg[19:0] base_address; // 喂给base_ram的地址
assign base_ram_addr = base_address;
reg[`DataBus] data_base_in;
reg[3:0] base_ram_be_reg;
assign base_ram_be_n = base_ram_be_reg;
sram_io base_ram_io(
    .clk(clk),
    .rst(rst),
    .oen(oe_base_n),
    .wen(we_base_n),
    .data_in(data_base_in),
    .data_out(data_base_out),
    .done(base_done),
    .ram_data_wire(base_ram_data),
    .ram_ce_n(base_ram_ce_n),
    .ram_oe_n(base_ram_oe_n),
    .ram_we_n(base_ram_we_n)
);

wire[`DataBus] data_ext_out;
wire ext_done;
reg oe_ext_n, we_ext_n;
reg[19:0] ext_address; // 喂给ext_ram的地址
assign ext_ram_addr = ext_address;
reg[`DataBus] data_ext_in;
reg[3:0] ext_ram_be_reg;
assign ext_ram_be_n = ext_ram_be_reg;
sram_io ext_ram_io(
    .clk(clk),
    .rst(rst),
    .oen(oe_ext_n),
    .wen(we_ext_n),
    .data_in(data_ext_in),
    .data_out(data_ext_out),
    .done(ext_done),
    .ram_data_wire(ext_ram_data),
    .ram_ce_n(ext_ram_ce_n),
    .ram_oe_n(ext_ram_oe_n),
    .ram_we_n(ext_ram_we_n)
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


wire [1:0] mem_use;
wire [19:0] ram_addr;
addr_decode _addr_decode(
    .mem_addr(mem_addr),
    .mem_use(mem_use),
    .ram_addr(ram_addr)
);

wire instValid, branch, mem_rd, mem_wr, wb;
wire[`InstAddrBus] branch_addr;
wire[`DataBus] mem_wr_data;
wire[`DataAddrBus] mem_addr;
wire[`RegAddrBus] wb_reg_addr;
wire[`DataBus] wb_data;
wire[3:0] ram_be_n;
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
    .mem_wr(mem_wr),
    .mem_wr_data(mem_wr_data),
    .mem_addr(mem_addr),
    .wb(wb),
    .wb_reg_addr(wb_reg_addr),
    .wb_data(wb_data),
    .ram_be_n(ram_be_n)
);


// 包含字节使能的判断，符号扩展
wire[`DataBus] data_to_load;
wire[7:0] uart_status = {2'b0, 1'b1, 4'b0, uart_dataready};
data_loader _data_loader(
    .ram_be_n(ram_be_n),
    .mem_use(mem_use),
    .data_base_out(data_base_out),
    .data_ext_out(data_ext_out),
    .uart_rd(data_uart_out),
    .data_to_load(data_to_load)
);


// program counter
reg [`InstAddrBus] pc;
wire [`InstAddrBus] new_pc = branch? branch_addr: pc + 4;
// instruction
reg [`InstBus] inst;
reg [`StateBus] state;

always@(posedge clk or posedge rst) begin
    if(rst)begin
        pc <= `START_ADDR;
        {oe_base_n, we_base_n} <= 2'b11;
        {oe_ext_n, we_ext_n} <= 2'b11;
        {oe_uart_n, we_uart_n} <= 2'b11;
        state <= `STATE_BOOT;
        inst <= 32'b0;

        base_address <= 20'b0;
        ext_address <= 20'b0;
        data_base_in <= 32'b0;
        data_ext_in <= 32'b0;
        base_ram_be_reg <= 4'b0;
        ext_ram_be_reg <= 4'b0;
        data_uart_in <= 32'b0;
        reg_we <= 1'b0;
    end
    else begin
        case (state) 
            `STATE_BOOT: begin
                reg_we <= 1'b0;
                base_address <= pc[21:2];
                oe_base_n <= 1'b0; 
                state <= `STATE_EXE1;        
            end
            `STATE_IF: begin
                reg_we <= 1'b0; // 新周期开始前可以写reg
                pc <= new_pc;
                base_address <= new_pc[21:2];
                oe_base_n <= 1'b0; 
                state <= `STATE_EXE1;
            end
            `STATE_EXE1: begin
                // EXE阶段及以后不允许修改pc和inst的值
                // 保证控制信号稳定
                if(base_done) begin
                    oe_base_n <= 1'b1;
                    inst <= data_base_out;
                    state <= `STATE_MEM;
                end
            end
            `STATE_MEM: begin
                if (mem_rd) begin
                    case (mem_use)
                        `USE_BASE: begin
                            base_address <= ram_addr;
                            oe_base_n <= 1'b0;
                            state <= `STATE_WB;
                        end
                        `USE_EXT: begin
                            ext_address <= ram_addr;
                            oe_ext_n <= 1'b0;
                            state <= `STATE_WB;
                        end
                        `USE_UART: begin
                            if(mem_addr == `UART_DATA_ADDR) begin
                                // 读串口数据寄存器
                                oe_uart_n <= 1'b0;
                                state <= `STATE_WB;
                            end
                            else if(mem_addr == `UART_STATUS_ADDR) begin
                                // 读串口状态寄存器，直接写回
                                reg_we <= 1'b1;
                                reg_wdata <= uart_status;
                                state <= `STATE_IF;
                            end
                            else begin
                                state <= `STATE_IF;
                            end
                        end
                        default: begin
                            state <= `STATE_IF;
                        end
                    endcase
                end
                else if(mem_wr) begin
                    // 写的时候需要赋值字节使能
                    case(mem_use)
                        `USE_BASE: begin
                            base_address <= ram_addr;
                            base_ram_be_reg <= ram_be_n;
                            we_base_n <= 1'b0;
                            data_base_in <= mem_wr_data;
                            state <= `STATE_WB;
                        end
                        `USE_EXT: begin
                            ext_address <= ram_addr;
                            ext_ram_be_reg <= ram_be_n;
                            we_ext_n <= 1'b0;
                            data_ext_in <= mem_wr_data;
                            state <= `STATE_WB;
                        end
                        `USE_UART: begin
                            // 一定是SB指令
                            // 写串口数据
                            if(mem_addr == `UART_DATA_ADDR) begin
                                we_uart_n <= 1'b0;
                                case (ram_be_n)
                                    `BE_BYTE_0:
                                        data_uart_in <= mem_wr_data[7:0];
                                    `BE_BYTE_1:
                                        data_uart_in <= mem_wr_data[15:8];
                                    `BE_BYTE_2:
                                        data_uart_in <= mem_wr_data[23:16];
                                    `BE_BYTE_3:
                                        data_uart_in <= mem_wr_data[31:24];
                                    default:
                                        data_uart_in <= 8'hzz;
                                endcase
                                state <= `STATE_WB;
                            end
                            else begin
                                // do nothing
                                state <= `STATE_IF;
                            end
                        end
                        default: begin
                            state <= `STATE_IF;
                        end
                    endcase
                end
                else begin
                    // 如果没有访存那就直接写回
                    if (wb) begin
                        reg_we <= 1'b1;
                        reg_wdata <= wb_data;
                    end
                    state <= `STATE_IF;
                end
            end
            `STATE_WB: begin
                // 其实是访存的收尾阶段
                case (mem_use)
                    `USE_BASE: begin
                        if(base_done) begin
                            {oe_base_n, we_base_n} <= 2'b11;
                            base_ram_be_reg <= 4'b0;
                            // 访存写回
                            if (mem_rd) begin
                                reg_we <= 1'b1;
                                reg_wdata <= data_to_load;                
                            end 
                            state <= `STATE_IF;
                        end
                    end
                    `USE_EXT: begin
                        if(ext_done) begin
                            {oe_ext_n, we_ext_n} <= 2'b11;
                            ext_ram_be_reg <= 4'b0;
                            // 访存写回
                            if (mem_rd) begin
                                reg_we <= 1'b1;
                                reg_wdata <= data_to_load;
                            end 
                            state <= `STATE_IF;
                        end
                    end
                    `USE_UART: begin
                        if(uart_done) begin
                            {oe_uart_n, we_uart_n} <= 2'b11;
                            if (mem_rd) begin
                                reg_we <= 1'b1;
                                reg_wdata <= data_to_load;
                            end
                            state <= `STATE_IF;
                        end
                    end 
                endcase
            end
        endcase 
    end
end
endmodule

