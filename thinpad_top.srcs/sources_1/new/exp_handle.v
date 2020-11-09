`include "defines.vh"
module exp_handle(
    input wire clk,
    input wire rst,
    input wire [1:0] exception,
    input wire[`InstBus] inst,
    input wire[`DataAddrBus] mem_addr,
    input wire[`ExpBus] exp_code
);


reg[`RegBus] mtvec;
reg[`RegBus] mcause;
reg[`RegBus] mepc;
reg[`RegBus] mtval;
reg[`RegBus] mstatus;
always @(posedge clk or negedge rst) begin
    if (rst) begin
        mtvec <= `ZeroWord;
        mcause <= `ZeroWord;
        mepc <= `ZeroWord;
        mtval <= `ZeroWord;
        mstatus <= `ZeroWord;
    end
end

endmodule