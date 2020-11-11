`include "defines.vh"
module exp_handle(
    input wire clk,
    input wire rst,
    input wire [1:0] exception,
    input wire[`ExpBus] exp_code,
    input wire[`InstBus] inst,
    input wire[`InstAddrBus] pc,
    input wire[`DataAddrBus] mem_addr,
    input wire csr_we,

    input wire[`DataBus] reg_data_i,
    output reg[`RegAddrBus] reg_addr_o,

    output reg ebranch,
    output reg[`InstAddrBus] ebranch_addr,

    output reg wb_reg,
    output reg[`RegAddrBus] wb_reg_addr,
    output reg[`DataBus] wb_reg_data
);

reg[`DataBus] mtvec;
reg[`DataBus] mcause;
reg[`DataBus] mepc;
reg[`DataBus] mtval; 
reg[`DataBus] mstatus;
reg[`DataBus] mscratch;

// 异常处理后csr寄存器的新值
reg[`DataBus] mtvec_to_write;
reg[`DataBus] mcause_to_write;
reg[`DataBus] mepc_to_write;
reg[`DataBus] mtval_to_write; 
reg[`DataBus] mstatus_to_write;
reg[`DataBus] mscratch_to_write;


always @(*) begin
    // 默认不做任何更新
    mtvec_to_write <= mtvec;
    mcause_to_write <= mcause;
    mepc_to_write <= mepc;
    mtval_to_write <= mtval;
    mstatus_to_write <= mstatus;
    mscratch_to_write <= mscratch;

    ebranch <= 0;
    ebranch_addr <= 0;
    reg_addr_o <= 0;
    wb_reg <= 0;
    wb_reg_addr <= 0;
    wb_reg_data <= 0;
    if (exception == `EXP_OP) begin
        ebranch <= 0;
        // ecall 只实现了U模式的30:sys_putc
    end
    else begin
        // EXP_ERR
        // 这些都是fatal
        ebranch <= 0;
    end
end

always @(posedge clk or posedge rst) begin
    if(rst) begin
        mtvec <= `ZeroWord;
        mcause <= `ZeroWord;
        mepc <= `ZeroWord;
        mtval <= `ZeroWord;
        mstatus <= `ZeroWord;
        mscratch <= `ZeroWord;
    end
    else if(csr_we) begin
        mtvec <= mtvec_to_write;
        mcause <= mcause_to_write;
        mepc <= mepc_to_write;
        mtval <= mtval_to_write;
        mstatus <= mstatus_to_write;
        mscratch <= mscratch_to_write;      
    end
end
endmodule