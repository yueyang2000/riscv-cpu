`include "defines.vh"
// exe阶段的异常检查
module exp_exe(
    input wire[`InstBus] inst,
    input wire instValid,
    input wire mem_rd,
    input wire mem_wr,
    input wire[3:0] ram_be_n, // determine lw 
    input wire[`DataBus] mem_addr,
    output reg[1:0] exception,
    output reg[`ExpBus] exp_code
);
wire[6:0] op = inst[6:0];
//是否为 CSRRC CSRRS CSRRW
wire csr_op = inst[14:12] == 3'b011 ? 1'b1 : inst[14:12] == 3'b010 ? 1'b1 : inst[14:12] == 3'b001 ? 1'b1 : 1'b0;
//是否为 EBREAK ECALL MRET
wire other_op = inst[31:7] == `EBREAK_PREFIX ? 1'b1 : inst[31:7] == `ECALL_PREFIX ? 1'b1 : inst[31:7] == `MRET_PREFIX ? 1'b1 : 1'b0;
wire mem_acc_fault = mem_addr > 32'h807fffff ? 1'b1 : mem_addr < 32'h10000000 ? 1'b1 : mem_addr <= 32'h10000008 ? 1'b0 :
                    mem_addr < 32'h80000000 ? 1'b1 : 1'b0;
always @(*) begin
    exp_code <= 4'b1110; // exp_code that does not count
    exception <= `EXP_ERR; // default: exception happened
    if(op == `OP_SYS) begin
        if(csr_op || other_op) 
            exception <= `EXP_OP;
        else begin
            exception <= `EXP_ERR;
            exp_code <= `exp_inst_illegal;      
        end 
    end
    else begin
        // 以此类推，确定exp_code和exception的值
        if (!instValid) begin
            exp_code <= `exp_inst_illegal;
        end
        else if(mem_addr[1:0] != 2'b00 && ram_be_n == `BE_WORD) begin
            if(mem_rd) 
                exp_code <= `exp_load_addr_mis;
            else if(mem_wr) 
                exp_code <= `exp_store_addr_mis;
            else
                exception <= `EXP_NONE;
        end
        else if(mem_acc_fault)begin
            if(mem_rd) 
                exp_code <= `exp_load_acc_fault;
            else if(mem_wr) 
                exp_code <= `exp_store_acc_fault;
            else
                exception <= `EXP_NONE;
        end
        else begin
            exception <= `EXP_NONE;
        end
    end
end

endmodule