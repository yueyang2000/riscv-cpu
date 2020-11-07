`include "defines.vh"

module addr_decode(
    input wire[`DataAddrBus] mem_addr,
    output reg[1:0] mem_use,
    output reg[19:0] ram_addr
);


localparam UART_ADDR_PERFIX = 32'h10000000;
wire[`DataAddrBus] mem_addr_sub = mem_addr - 24'h400000;

always @(*) begin
    mem_use <= `USE_NOTHING;
    // address of lab5 start from 0x0
    // address of kernel start from 0x80000000
    if(mem_addr[31:3] == UART_ADDR_PERFIX[31:3])
        mem_use <= `USE_UART;
    else begin
        if(mem_addr[23:22] == 2'b00) begin
            mem_use <= `USE_BASE;
            ram_addr <= mem_addr[21:2];
        end
        else begin
            mem_use <= `USE_EXT;
            ram_addr <= mem_addr_sub[21:2];
        end
    end
end

endmodule
