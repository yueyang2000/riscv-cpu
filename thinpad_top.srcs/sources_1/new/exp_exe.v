`include "defines.vh"
// exe阶段的异常检查
module exp_exe(
    input[`InstBus]  inst,
    input wire instValid,
    input wire mem_rd,
    input wire mem_wr,
    input wire[3:0] ram_be_n, // determine lw 
    wire[`DataBus] mem_addr,
    output wire[1:0] exception,
    output wire[`ExpBus] exp_code
);
wire[6:0] op = inst[6:0];
always @(*) begin
    exp_code <= 4'b1110; // exp_code that does not count
    exception <= `EXP_ERR; // default: exception happened
    if(op == `OP_SYS) begin
        exception <= `EXP_OP;
    end
    else begin
        // 以此类推，确定exp_code和exception的值
        if (!instValid) begin
            exp_code <= `exp_inst_illegal;
        end
        else begin
            exception <= `EXP_NONE;
        end
    end
end

endmodule