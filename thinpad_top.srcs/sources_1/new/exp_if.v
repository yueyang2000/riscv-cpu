`include "defines.vh"
// if 阶段的异常检查
module exp_if(
    input wire[`InstAddrBus] if_addr,
    output wire[1:0] exception,
    output wire[`ExpBus] exp_code
);

always @(*) begin
    exception <= `EXP_NONE; // default no exception
    exp_code <= 4'b1110; // exp_code that does not count
    // add code to determine whether if addr is valid
end

endmodule