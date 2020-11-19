`include "defines.vh"
module mem_controller(
    input wire clk,
    input wire rst,
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

    //CPLD串口控制器信号
    output wire uart_rdn,         //读串口信号，低有效
    output wire uart_wrn,         //写串口信号，低有效
    input wire uart_dataready,    //串口数据准备好
    input wire uart_tbre,         //发送数据标志
    input wire uart_tsre,         //数据发送完毕标志

    // cpu 控制读写逻辑信号
    input wire oen,
    input wire wen,
    input wire[3:0] ram_be_n,
    input wire[`DataAddrBus] mem_addr,
    input wire[`DataBus] data_in,
    output reg[`DataBus] data_out,
    output wire done,

    input wire sv32_en,
    input wire[21:0] satp_ppn,

    // gram控制信号
    output reg gram_we_n,
    output reg[7:0] gram_wr_data,
    output wire[18:0] gram_wr_addr
); 
// ===== 串口 ===== 
reg oe_uart_n, we_uart_n;
reg[7:0] data_uart_in;
wire[7:0] data_uart_out;
wire uart_done;
uart_io _uart_io(
    .clk(clk),
    .rst(rst),
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
// ===== 存储设备 =====
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

wire [1:0] mem_use;
wire [19:0] ram_addr;
addr_decode _addr_decode(
    .mem_addr(phy_addr),
    .mem_use(mem_use),
    .ram_addr(ram_addr)
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

// // 用户态地址映射（硬编码）
// wire[`DataAddrBus] phy_addr;
// mmu _mmu(
//     .sv32_en(sv32_en),
//     .addr_i(mem_addr),
//     .addr_o(phy_addr)
// );

// 用户态地址映射（查页表）
reg[`DataAddrBus] phy_addr;

// 低19位用于gram地址映射
assign gram_wr_addr = mem_addr[18:0];

wire[`DataAddrBus] page1_addr = {satp_ppn[19:0], mem_addr[31:22], 2'b0};
wire[`DataBus] page_entry = data_base_out;
wire is_uart = 32'h10000000 <= mem_addr && 32'h10000008 >= mem_addr;
wire is_vga = 32'h20000000 <= mem_addr && mem_addr < 32'h20075300;
reg[2:0] state;
localparam STATE_IDLE = 3'b000;
localparam STATE_READ = 3'b001;
localparam STATE_WRITE = 3'b010;
localparam STATE_START = 3'b011;
localparam STATE_PAGE_1 = 3'b100;
localparam STATE_PAGE_2 = 3'b101;
localparam STATE_PAGE_3 = 3'b110;
localparam STATE_DONE = 3'b111;
assign done = state == STATE_DONE;

always @(posedge clk or posedge rst) begin
    if(rst) begin
        state <= STATE_IDLE;
        {oe_base_n, we_base_n} <= 2'b11;
        {oe_ext_n, we_ext_n} <= 2'b11;
        {oe_uart_n, we_uart_n} <= 2'b11;

        base_address <= 20'b0;
        ext_address <= 20'b0;
        data_base_in <= 32'b0;
        data_ext_in <= 32'b0;
        base_ram_be_reg <= 4'b0;
        ext_ram_be_reg <= 4'b0;
        data_uart_in <= 32'b0;

        phy_addr <= 32'b0;

        gram_we_n <= 1'b1;
        gram_wr_data <= 8'b0;
    end
    else begin
        case(state)
            STATE_IDLE: begin
                if(~oen | ~wen) begin
                    if(sv32_en && ~is_uart && ~is_vga) begin
                        // 需要映射，先查一级页表
                        state <= STATE_PAGE_1;
                        // 注意这里是sram地址
                        base_address <= page1_addr[21:2];
                        oe_base_n <= 1'b0;
                    end
                    else begin
                        phy_addr <= mem_addr;
                        state <= STATE_START;
                    end
                end
            end
            STATE_PAGE_1: begin
                if(base_done) begin
                    oe_base_n <= 1'b1;
                    if(page_entry[3:1] != 3'b0) begin
                        phy_addr <= {page_entry[29:10], mem_addr[11:0]};
                        state <= STATE_START;
                    end
                    else begin
                        // is not leaf, keep reading
                        state <= STATE_PAGE_2;
                        // 注意这里是sram地址
                        base_address <= {page_entry[29:10], mem_addr[21:12]};
                    end
                end
            end
            STATE_PAGE_2: begin
                oe_base_n <= 1'b0;
                state <= STATE_PAGE_3;
            end
            STATE_PAGE_3: begin
                if(base_done) begin
                    oe_base_n <= 1'b1;
                    phy_addr <= {page_entry[29:10], mem_addr[11:0]};
                    state <= STATE_START;
                end
            end
            STATE_START: begin
                if (~oen) begin
                    case(mem_use)
                        `USE_BASE: begin
                            base_address <= ram_addr;
                            oe_base_n <= 1'b0;
                            state <= STATE_READ;
                        end
                        `USE_EXT: begin
                            ext_address <= ram_addr;
                            oe_ext_n <= 1'b0;
                            state <= STATE_READ;
                        end
                        `USE_UART: begin
                            if(mem_addr == `UART_DATA_ADDR) begin
                                // 读串口数据寄存器
                                oe_uart_n <= 1'b0;
                                state <= STATE_READ;
                            end
                            else if(mem_addr == `UART_STATUS_ADDR) begin
                                // 读串口状态寄存器
                                data_out <= uart_status;
                                state <= STATE_DONE;
                            end
                            else begin
                                state <= STATE_DONE;
                            end                            
                        end
                        `USE_VGA: begin
                            // VGA cannot be read
                            state <= STATE_DONE;
                        end
                    endcase
                end
                else if(~wen) begin
                    case(mem_use)
                        `USE_BASE: begin
                            base_address <= ram_addr;
                            base_ram_be_reg <= ram_be_n;
                            we_base_n <= 1'b0;
                            data_base_in <= data_in;
                            state <= STATE_WRITE;
                        end
                        `USE_EXT: begin
                            ext_address <= ram_addr;
                            ext_ram_be_reg <= ram_be_n;
                            we_ext_n <= 1'b0;
                            data_ext_in <= data_in;
                            state <= STATE_WRITE;
                        end
                        `USE_UART: begin
                            if(mem_addr == `UART_DATA_ADDR) begin
                                we_uart_n <= 1'b0;
                                case (ram_be_n)
                                    `BE_BYTE_0:
                                        data_uart_in <= data_in[7:0];
                                    `BE_BYTE_1:
                                        data_uart_in <= data_in[15:8];
                                    `BE_BYTE_2:
                                        data_uart_in <= data_in[23:16];
                                    `BE_BYTE_3:
                                        data_uart_in <= data_in[31:24];
                                    default:
                                        data_uart_in <= 8'hzz;
                                endcase
                                state <= STATE_WRITE;
                            end
                            else begin
                                state <= STATE_DONE;
                            end
                        end
                        `USE_VGA: begin
                            // write gram
                            gram_we_n <= 1'b0;
                            case (ram_be_n)
                                `BE_BYTE_0:
                                    gram_wr_data <= data_in[7:0];
                                `BE_BYTE_1:
                                    gram_wr_data <= data_in[15:8];
                                `BE_BYTE_2:
                                    gram_wr_data <= data_in[23:16];
                                `BE_BYTE_3:
                                    gram_wr_data <= data_in[31:24];
                                default:
                                    gram_wr_data <= 8'hzz;
                            endcase
                            state <= STATE_WRITE;
                        end
                    endcase                    
                end               
            end
        STATE_READ: begin
            case(mem_use)
                `USE_BASE: begin
                    if(base_done) begin
                        oe_base_n <= 1'b1;
                        base_ram_be_reg <= 4'b0;
                        data_out <= data_to_load;
                        state <= STATE_DONE;
                    end
                end
                `USE_EXT: begin
                    if(ext_done) begin
                        oe_ext_n <= 1'b1;
                        ext_ram_be_reg <= 4'b0;
                        data_out <= data_to_load;
                        state <= STATE_DONE;
                    end
                end 
                `USE_UART: begin
                    if(uart_done) begin
                        oe_uart_n<= 1'b1;
                        data_out <= data_to_load;
                        state <= STATE_DONE;
                    end
                end
                `USE_VGA: begin
                    // this case will never be reached
                    state <= STATE_DONE;
                end
            endcase
        end
        STATE_WRITE: begin
            case(mem_use)
                `USE_BASE: begin
                    if(base_done) begin
                        we_base_n <= 1'b1;
                        base_ram_be_reg <= 4'b0;
                        state <= STATE_DONE;
                    end
                end
                `USE_EXT: begin
                    if(ext_done) begin
                        we_ext_n <= 1'b1;
                        ext_ram_be_reg <= 4'b0;
                        state <= STATE_DONE;
                    end
                end 
                `USE_UART: begin
                    if(uart_done) begin
                        we_uart_n<= 1'b1;
                        state <= STATE_DONE;
                    end
                end
                `USE_VGA: begin
                    // should be finished by now
                    gram_we_n <= 1'b1;
                    state <= STATE_DONE;
                end
            endcase
        end
        STATE_DONE: begin
            state <= STATE_IDLE;
        end
        endcase
    end
end

endmodule