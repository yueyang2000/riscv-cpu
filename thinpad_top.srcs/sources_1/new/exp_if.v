`include "defines.vh"
// if 阶段的异常检查
module exp_if(
    input wire[`InstAddrBus] if_addr,
    output reg[1:0] exception,
    output reg[`ExpBus] exp_code
);
wire inst_acc_fault = if_addr > 32'h807fffff ? 1'b1 : if_addr < 32'h80000000 ? 1'b1 : 1'b0;

always @(*) begin
    exception <= `EXP_NONE; // default no exception
    exp_code <= 4'b1110; // exp_code that does not count
    // add code to determine whether if addr is valid
    if(inst_acc_fault == 1'b1) begin
        exception <= `EXP_ERR;
        exp_code <= `exp_inst_acc_fault;
    end
    else if (if_addr[1:0]!= 2'b00) begin
        exception <= `EXP_ERR;
        exp_code <= `exp_inst_addr_mis;
    end
end

endmodule