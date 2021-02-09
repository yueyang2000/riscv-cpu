`include "defines.vh"
// if 阶段的异常检查
module exp_if(
    input wire[`InstAddrBus] if_addr,
    input wire[1:0] curr_mode,
    input wire sv32_en,
    output reg[1:0] exception,
    output reg[`ExpBus] exp_code
);

wire err;
addr_check _addr_check(
    .sv32_en(sv32_en),
    .mem_addr(if_addr),
    .err(err),
    .mem_rd(1'b0),
    .mem_wr(1'b0),
    .mem_if(1'b1)
);
// wire inst_acc_fault = if_addr > 32'h807fffff ? 1'b1 : if_addr < 32'h80000000 ? 1'b1 : 1'b0;

always @(*) begin
    exception <= `EXP_NONE; // default no exception
    exp_code <= 4'b1110; // exp_code that does not count
    // add code to determine whether if addr is valid
    if(err) begin
        exception <= `EXP_ERR;
        if(~sv32_en)
            exp_code <= `exp_inst_acc_fault;
        else
            exp_code <= `exp_inst_page_fault;
    end
    else if (if_addr[1:0]!= 2'b00) begin
        exception <= `EXP_ERR;
        exp_code <= `exp_inst_addr_mis;
    end
end

endmodule