`include "defines.vh"
module exp_handle(
    input wire clk,
    input wire rst,
    input wire [1:0] exception,
    input wire[`ExpBus] exp_code,
    input wire[`InstBus] inst,
    input wire[`InstAddrBus] pc,
    input wire[`DataAddrBus] mem_addr,
    input wire csr_we,

    input wire[`DataBus] reg_data_i,
    output wire[`RegAddrBus] reg_addr_o,

    output reg ebranch,
    output reg[`InstAddrBus] ebranch_addr,

    output reg wb_reg,
    output wire[`RegAddrBus] wb_reg_addr,
    output reg[`DataBus] wb_reg_data
);


assign reg_addr_o = inst[19:15];
wire [2:0] funct3 = inst[14:12];
assign wb_reg_addr = inst[11:7];
// 0-mtvec 1-mcause 2-mepc 3-mtval 4-mstatus 5-mscratch
reg[`RegBus] csr[0:7];
wire[`CsrAddrBus] csr_addr = inst[31:20];
wire[2:0] csr_addr_map = csr_addr == `CSR_MTVEC ? `MTVEC :  csr_addr == `CSR_MCAUSE ? `MCAUSE : csr_addr == `CSR_MEPC ? `MEPC :
                        csr_addr == `CSR_MTVAL ? `MTVAL : csr_addr == `CSR_MSTATUS ? `MSTATUS : csr_addr == `CSR_MSCRATCH ? `MSCRATCH : `SATP;
// reg[`DataBus] mtvec;
// reg[`DataBus] mcause;
// reg[`DataBus] mepc;
// reg[`DataBus] mtval; 
// reg[`DataBus] mstatus;
// reg[`DataBus] mscratch;

// 异常处理后csr寄存器的新值
reg[`RegBus] csr_to_write[0:7];
// reg[`DataBus] mtvec_to_write;
// reg[`DataBus] mcause_to_write;
// reg[`DataBus] mepc_to_write;
// reg[`DataBus] mtval_to_write; 
// reg[`DataBus] mstatus_to_write;
// reg[`DataBus] mscratch_to_write;


always @(*) begin
    // 默认不做任何更新
    // mtvec_to_write <= mtvec;
    // mcause_to_write <= mcause;
    // mepc_to_write <= mepc;
    // mtval_to_write <= mtval;
    // mstatus_to_write <= mstatus;
    // mscratch_to_write <= mscratch;
    csr_to_write[`MTVEC] <= csr[`MTVEC];
    csr_to_write[`MCAUSE] <= csr[`MCAUSE];
    csr_to_write[`MEPC] <= csr[`MEPC];
    csr_to_write[`MTVAL] <= csr[`MTVAL];
    csr_to_write[`MSTATUS] <= csr[`MSTATUS];
    csr_to_write[`MSCRATCH] <= csr[`MSCRATCH];

    ebranch <= 0;
    ebranch_addr <= 0;
    wb_reg <= 0;
    wb_reg_data <= 0;
    if (exception == `EXP_OP) begin
        ebranch <= 0;
        // ecall 只实现了U模式的30:sys_putc
        if(funct3 == `EXP_CSRRC) begin
            csr_to_write[csr_addr_map] <= csr[csr_addr_map] & (~reg_data_i);
            wb_reg <= 1;
            wb_reg_data <= csr[csr_addr_map];
        end
        else if(funct3 == `EXP_CSRRS) begin
            csr_to_write[csr_addr_map] <= csr[csr_addr_map] | reg_data_i;
            wb_reg <= 1;
            wb_reg_data <= csr[csr_addr_map];
        end
        else if(funct3 == `EXP_CSRRW) begin
            csr_to_write[csr_addr_map] <= reg_data_i;
            wb_reg <= 1;
            wb_reg_data <= csr[csr_addr_map];
        end
        else if(inst[31:7] == `EBREAK_PREFIX) begin
            ebranch <= 1;
            ebranch_addr <= csr[`MTVEC];
            csr_to_write[`MCAUSE] <= `exp_break;
            csr_to_write[`MEPC] <= pc;
            // TODO mtval mstatus
        end
        else if(inst[31:7] == `ECALL_PREFIX) begin
            ebranch <= 1;
            ebranch_addr <= csr[`MTVEC];
            csr_to_write[`MCAUSE] <= `exp_ecall_u;
            csr_to_write[`MEPC] <= pc;
            // TODO mtval mstatus
        end
        else if(inst[31:7] == `MRET_PREFIX) begin
            ebranch <= 1;
            ebranch_addr <= csr[`MEPC];
            // TODO  mstatus
        end
    end
    else begin
        // EXP_ERR
        // 这些都是fatal
        ebranch <= 0;
    end
end

always @(posedge clk or posedge rst) begin
    if(rst) begin
        csr[`MTVEC] <= `ZeroWord;
        csr[`MCAUSE] <= `ZeroWord;
        csr[`MEPC] <= `ZeroWord;
        csr[`MTVAL] <= `ZeroWord;
        csr[`MSTATUS] <= `ZeroWord;
        csr[`MSCRATCH] <= `ZeroWord;
    end
    else if(csr_we) begin
        // mtvec <= mtvec_to_write;
        // mcause <= mcause_to_write;
        // mepc <= mepc_to_write;
        // mtval <= mtval_to_write;
        // mstatus <= mstatus_to_write;
        // mscratch <= mscratch_to_write;
        csr[`MTVEC] <= csr_to_write[`MTVEC];
        csr[`MCAUSE] <= csr_to_write[`MCAUSE];
        csr[`MEPC] <= csr_to_write[`MEPC];
        csr[`MTVAL] <= csr_to_write[`MTVAL];
        csr[`MSTATUS] <= csr_to_write[`MSTATUS];
        csr[`MSCRATCH] <= csr_to_write[`MSCRATCH];
    end
end
endmodule