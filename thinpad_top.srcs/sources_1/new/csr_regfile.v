`include "defines.vh"

module csr_regfile(
    input wire clk,
    input wire rst,
    output reg[`DataBus] csr_rd_data,
    input wire[`CsrAddrBus] csr_rd_addr,
    input wire csr_we,
    input wire[`CsrAddrBus] csr_wr_addr,
    input wire[`DataBus] csr_wr_data
);

reg[`DataBus] mtvec;
reg[`DataBus] mcause;
reg[`DataBus] mepc;
reg[`DataBus] mtval; 
reg[`DataBus] mstatus;
reg[`DataBus] mscratch;
always @(posedge clk or posedge rst) begin
    if (rst) begin
        mtvec <= `ZeroWord;
        mcause <= `ZeroWord;
        mepc <= `ZeroWord;
        mtval <= `ZeroWord;
        mstatus <= `ZeroWord;
        mscratch <= `ZeroWord;
        csr_rd_data <= `ZeroWord;
    end
    else begin
        
    end
end

endmodule