`include "defines.vh"

module addr_decode(
    input wire[`DataAddrBus] mem_addr,
    output reg[1:0] mem_use,
    output reg[19:0] ram_addr
);

wire[`DataAddrBus] mem_addr_sub = mem_addr - 24'h400000;
always @(*) begin
    mem_use <= `USE_NOTHING;
    // work for lab5
    // address of rv start from 0x80000000
    if(mem_addr[23:20] >= 4) begin
        mem_use <= `USE_EXT;
        ram_addr <= mem_addr_sub[21:2];
    end
    else begin
        mem_use <= `USE_BASE;
        ram_addr <= mem_addr[21:2];
    end
    // else begin
    //     mem_use <= `USE_UART;
    // end
end

endmodule
