`include "defines.vh"

module regfile(
    input wire clk,
    input wire rst,

    input wire we,
    input wire[`RegAddrBus] waddr,
    input wire[`RegBus] wdata,

    input wire[`RegAddrBus] raddr1,
    output wire[`RegBus] rdata1,
    
    input wire[`RegAddrBus] raddr2,
    output wire[`RegBus] rdata2,

    input wire[`RegAddrBus] raddr3,
    output wire[`RegBus] rdata3
);
    reg[`RegBus] regs[0:`RegNum-1];


    assign rdata1 = regs[raddr1];
    assign rdata2 = regs[raddr2];
    assign rdata3 = regs[raddr3];

    always @ (posedge clk) begin
        if (rst == `RstDisable) begin
            if ((we == `WriteEnable) && (waddr != 0))
                regs[waddr] <= wdata;
        end else begin
            regs[0] <= `ZeroWord;
            regs[1] <= `ZeroWord;
            regs[2] <= `ZeroWord;
            regs[3] <= `ZeroWord;
            regs[4] <= `ZeroWord;
            regs[5] <= `ZeroWord;
            regs[6] <= `ZeroWord;
            regs[7] <= `ZeroWord;
            regs[8] <= `ZeroWord;
            regs[9] <= `ZeroWord;
            regs[10] <= `ZeroWord;
            regs[11] <= `ZeroWord;
            regs[12] <= `ZeroWord;
            regs[13] <= `ZeroWord;
            regs[14] <= `ZeroWord;
            regs[15] <= `ZeroWord;
            regs[16] <= `ZeroWord;
            regs[17] <= `ZeroWord;
            regs[18] <= `ZeroWord;
            regs[19] <= `ZeroWord;
            regs[20] <= `ZeroWord;
            regs[21] <= `ZeroWord;
            regs[22] <= `ZeroWord;
            regs[23] <= `ZeroWord;
            regs[24] <= `ZeroWord;
            regs[25] <= `ZeroWord;
            regs[26] <= `ZeroWord;
            regs[27] <= `ZeroWord;
            regs[28] <= `ZeroWord;
            regs[29] <= `ZeroWord;
            regs[30] <= `ZeroWord;
            regs[31] <= `ZeroWord;
        end
    end
endmodule