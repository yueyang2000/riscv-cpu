`include "defines.vh"
module exp_handle(
    input wire [1:0] exception,
    input wire[`ExpBus] exp_code,
    input wire[`InstBus] inst,
    input wire[`InstAddrBus] pc,
    input wire[`DataAddrBus] mem_addr,

    input wire[`DataBus] reg_data_i,
    output reg[`RegAddrBus] reg_addr_o,

    input wire[`DataBus] csr_data_i,
    output reg[`RegAddrBus] csr_addr_o,

    output reg ebranch,
    output reg[`InstAddrBus] ebranch_addr,
    output reg wb_reg,
    output reg[`RegAddrBus] wb_reg_addr,
    output reg[`DataBus] wb_reg_data,
    output reg wb_csr,
    output reg[`CsrAddrBus] wb_csr_addr,
    output reg[`DataBus] wb_csr_data
);

always @(*) begin
    reg_addr_o <= 0;
    csr_addr_o <= 0;
    ebranch_addr <= 0;
    wb_reg <= 0;
    wb_reg_addr <= 0;
    wb_reg_data <= 0;
    wb_csr <= 0;
    wb_csr_addr <= 0;
    wb_csr_data <= 0;
    if (exception == `EXP_OP) begin
        ebranch <= 0;
    end
    else begin
        // EXP_ERR
        ebranch <= 0;
    end
end

endmodule