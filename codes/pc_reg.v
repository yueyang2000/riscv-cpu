module pc_reg(
    input wire                  clk,
    input wire                  rst,
    input wire[5:0]             stall,
    // 是否发生了转移
    input wire                  brange_flag_i,
    // 转移到的目标地址
    input wire[`RegBus]         branch_target_address_i,
    // mem 要不要读写
    input wire                  mem,
    output reg[`InstAddrBus]    pc,
    output reg                  ce,
    // 需要加入if的sram控制信号

    // 等待mem
    output reg                  stallreq
);
// 如果当前mem阶段需要读写，则mem应该先做
// 需要请求暂停，让if_id插入一个nop


    // 如果有分支，则跳转
    always @ (posedge clk) begin
        if (ce == `ChipDisable) begin
            pc <= 32'h00000000;
        end else if(stall[0] == `NoStop) begin
            if(branch_flag_i == `Branch) begin
                    pc <= branch_target_address_i;
                end else begin
                pc <= pc + 4'h4;
            end
        end
    end

endmodule
