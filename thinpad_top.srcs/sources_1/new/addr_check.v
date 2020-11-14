`include "defines.vh"
module addr_check(
    input wire sv32_en,
    input wire[`DataAddrBus] mem_addr,
    output wire err
);

wire mem_acc_fault = mem_addr > 32'h807fffff ? 1'b1 : mem_addr < 32'h10000000 ? 1'b1 : mem_addr <= 32'h10000008 ? 1'b0 :
                    mem_addr < 32'h80000000 ? 1'b1 : 1'b0;

wire t1 = mem_addr >= 32'h0 && mem_addr <= 32'h002FFFFF;
wire t2 = mem_addr >= 32'h7FC10000 && mem_addr <= 32'h7FFFFFFF;
wire t3 = mem_addr >= 32'h80000000 && mem_addr <= 32'h80000FFF;
wire t4 = mem_addr >= 32'h80100000 && mem_addr <= 32'h80100FFF;
wire is_uart = 32'h10000000 <= mem_addr && 32'h10000008 >= mem_addr;
assign err = is_uart? 1'b0 : sv32_en ? ~(t1 | t2 | t3 | t4) : mem_acc_fault;

endmodule