`include "defines.vh"

module mmu(
    input wire sv32_en,
    input wire[`DataAddrBus] addr_i,
    output wire[`DataAddrBus] addr_o
);

wire t1 = addr_i >= 32'h0 && addr_i <= 32'h002FFFFF;
wire t2 = addr_i >= 32'h7FC10000 && addr_i <= 32'h7FFFFFFF;
wire t3 = addr_i >= 32'h80000000 && addr_i <= 32'h80000FFF;
wire t4 = addr_i >= 32'h80100000 && addr_i <= 32'h80100FFF;
wire is_uart = 32'h10000000 <= addr_i && 32'h10000008 >= addr_i;
assign addr_o = is_uart? addr_i :t1? addr_i + 32'h80100000 : t2? addr_i + 32'h007F0000 : addr_i;

endmodule