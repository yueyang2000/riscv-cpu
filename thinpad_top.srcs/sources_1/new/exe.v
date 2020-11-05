`include "defines.vh"

module exe(
    input wire[`InstAddrBus] pc,
    input wire[`InstBus] inst,
    input wire[`RegBus] reg1_data_i,
    input wire[`RegBus] reg2_data_i,
    output wire[`RegAddrBus]       reg1_addr_o,
    output wire[`RegAddrBus]       reg2_addr_o,
    output reg instValid,

    output reg branch,// 是否要分支跳转
    output reg[`InstAddrBus] branch_addr, // 跳转到的地址

    output reg mem_rd,    //是否要读内存
    output reg[2:0] load_type, // funct3 of load inst

    output reg mem_wr,              // 是否要写内存
    output reg[`DataBus] mem_wr_data,
    output reg[`DataAddrBus] mem_addr,

    output reg wb,                  // 是否要写回
    output wire[`RegAddrBus] wb_reg_addr,
    output reg[`DataBus] wb_data
);


wire[6:0] op = inst[6:0];
assign reg1_addr_o = inst[19:15]; // rs1
assign reg2_addr_o =inst[24:20]; // rs2
assign wb_reg_addr = inst[11:7]; // rd

wire[11:0] rawI = inst[31:20];
wire[19:0] extI = rawI[11] ? 20'hfffff: 20'h0;
wire[`RegBus] immI = {extI, rawI};

wire[11:0] rawS = {inst[31:25], inst[11:7]};
wire[19:0] extS = rawS[11] ? 20'hfffff: 20'h0;
wire[`RegBus] immS = {extS, rawS};

wire[12:0] rawB = {inst[31], inst[7], inst[30 : 25], inst[11 : 8], 1'b0};
wire[18:0] extB = rawB[12] ? 19'hfffff: 19'h0;
wire[`RegBus] immB = {extB, rawB};

wire[`RegBus] immU = {inst[31:12], 12'b0};

wire[20:0] rawJ = {inst[31], inst[19:12], inst[20], inst[30:21], 1'b0};
wire[10:0] extJ = rawJ[20] ? 11'hffff: 11'h0;

wire [2:0] funct3 = inst[14:12];
wire [6:0] funct7 = inst[31:25];

wire arith_sign = inst[30];

always @(*) begin
    instValid <= 1;
    mem_rd <= 0;
    load_type <= 3'b100; // invalid load type
    mem_wr <= 0;
    mem_wr_data <= 0;
    mem_addr <= 0;
    wb <= 0;
    wb_data <= 0;
    branch <= 0;
    branch_addr <= 0;
    case (op)
        `OP_ARITH: begin
            wb <= 1;
            case(funct3)
                `ARITH_ADD: begin
                    if(arith_sign)
                        wb_data <= reg1_data_i - reg2_data_i;
                    else
                        wb_data <=reg1_data_i + reg2_data_i;
                end
                default:
                    instValid <= 0;
            endcase
        end
        `OP_ARITH_I: begin
            wb <= 1;
            case(funct3)
                `ARITH_OR: begin
                    wb_data <= reg1_data_i | immI;
                end
                default:
                    instValid <= 0;
            endcase
        end
        `OP_BRANCH: begin
            case(funct3)
               `BRANCH_BEQ: begin
                    if(reg1_data_i == reg2_data_i) begin
                        branch <= 1;
                        branch_addr <= pc + immB;
                    end
                end
                default:
                    instValid <= 0;
            endcase
        end
        `OP_LOAD: begin
            wb <= 1;
            mem_rd <= 1;
            mem_addr <= reg1_data_i + immI;
            load_type <= funct3;
        end
        `OP_STORE: begin
            mem_wr <= 1;
            mem_addr <= reg1_data_i + immS;
            case (funct3)
                `LS_W:
                    mem_wr_data <= reg2_data_i;
                default:
                    instValid <= 0;
            endcase
        end
        default:
            instValid <= 0;
    endcase
end

endmodule
