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

    output reg mem_wr,              // 是否要写内存
    output reg[`DataBus] mem_wr_data,
    output reg[`DataAddrBus] mem_addr,

    output reg wb,                  // 是否要写回
    output wire[`RegAddrBus] wb_reg_addr,
    output reg[`DataBus] wb_data,
    
    output reg[3:0] ram_be_n
);


wire[6:0] op = inst[6:0];
assign reg1_addr_o = inst[19:15]; // rs1
assign reg2_addr_o =inst[24:20]; // rs2
assign wb_reg_addr = inst[11:7]; // rd

wire[11:0] rawI = inst[31:20];
wire[19:0] extI = rawI[11] ? 20'hfffff: 20'h0;
wire[`RegBus] immI = {extI, rawI};


wire[4:0] shamt = inst[24:20];  // SLLI SRLI 移位立即数

wire[11:0] rawS = {inst[31:25], inst[11:7]};
wire[19:0] extS = rawS[11] ? 20'hfffff: 20'h0;
wire[`RegBus] immS = {extS, rawS};

wire[12:0] rawB = {inst[31], inst[7], inst[30 : 25], inst[11 : 8], 1'b0};
wire[18:0] extB = rawB[12] ? 19'hfffff: 19'h0;
wire[`RegBus] immB = {extB, rawB};

wire[`RegBus] immU = {inst[31:12], 12'b0};

wire[20:0] rawJ = {inst[31], inst[19:12], inst[20], inst[30:21], 1'b0};
wire[10:0] extJ = rawJ[20] ? 11'hffff: 11'h0;
wire[`RegBus] immJ = {extJ, rawJ};

wire [2:0] funct3 = inst[14:12];
wire [6:0] funct7 = inst[31:25];

// wire arith_sign = inst[30];
wire[1:0] mem_addr_offset = mem_addr - { mem_addr[31:2], 2'b0 };

always @(*) begin
    instValid <= 1;
    mem_rd <= 0;
    mem_wr <= 0;
    mem_wr_data <= 0;
    mem_addr <= 0;
    wb <= 0;
    wb_data <= 0;
    branch <= 0;
    branch_addr <= 0;
    ram_be_n <= 4'b0000;
    case (op)
        `OP_ARITH: begin
            wb <= 1;
            case(funct3)
                `ARITH_ADD: begin 
                    if(funct7 == `ARITH_SUB_FUNCT7)
                        wb_data <= reg1_data_i - reg2_data_i; // SUB
                    else
                        wb_data <= reg1_data_i + reg2_data_i; // ADD
                end
                `ARITH_AND: begin
                    wb_data <= reg1_data_i & reg2_data_i; 
                end
                `ARITH_OR: begin
                    wb_data <= reg1_data_i | reg2_data_i; 
                end
                `ARITH_XOR: begin
                    if(funct7 == `ARITH_MIN_FUNCT7)
                        wb_data <= (reg1_data_i < reg2_data_i ? reg1_data_i : reg2_data_i);
                    else
                        wb_data <= reg1_data_i ^ reg2_data_i;
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
                `ARITH_ADD: begin
                    wb_data <= reg1_data_i + immI;
                end
                `ARITH_AND: begin
                    wb_data <= reg1_data_i & immI;
                end
                `ARITH_SLL: begin
                    wb_data <= reg1_data_i << shamt;
                end
                `ARITH_SRL: begin
                    wb_data <= reg1_data_i >> shamt;
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
                `BRANCH_BNE: begin
                    if(reg1_data_i != reg2_data_i) begin
                        branch <= 1;
                        branch_addr <= pc + immB;
                    end
                end
                default:
                    instValid <= 0;
            endcase
        end
        `OP_JAL: begin
            wb <= 1;
            wb_data <= pc + 4;
            branch <= 1;
            branch_addr <= pc + immJ;
        end
        `OP_JALR: begin
            wb <= 1;
            wb_data <= pc + 4;
            branch <= 1;
            branch_addr <= reg1_data_i + immJ; // 应该是取高31位拼0，但是由于RAM读取的时候忽略低两位，因此没必要去拼0
        end
        `OP_LUI: begin
            wb <= 1;
            wb_data <= immU;
        end
        `OP_AUIPC: begin
            wb <= 1;
            wb_data <= pc + immU;
        end
        `OP_LOAD: begin
            wb <= 1;
            mem_rd <= 1;  
            mem_addr <= reg1_data_i + immI;   
            case(funct3)                     
                `LS_W: begin
                    ram_be_n <= `BE_WORD;
                end
                `LS_B: begin         
                    case(mem_addr_offset)
                        2'b0:begin
                            ram_be_n <= `BE_BYTE_0;
                        end
                        2'b01:begin
                            ram_be_n <= `BE_BYTE_1;
                        end
                        2'b10:begin
                            ram_be_n <= `BE_BYTE_2;
                        end
                        2'b11:begin
                            ram_be_n <= `BE_BYTE_3;
                        end
                    endcase
                end
                default:
                    instValid <= 0;
            endcase  
        end
        `OP_STORE: begin
            mem_wr <= 1;
            mem_addr <= reg1_data_i + immS;      
            case (funct3)
                `LS_W:begin
                    ram_be_n <= `BE_WORD;
                    mem_wr_data <= reg2_data_i;
                end                
                `LS_B: begin         
                    case(mem_addr_offset)
                        2'b0:begin
                            ram_be_n <= `BE_BYTE_0;
                            mem_wr_data <= reg2_data_i;
                        end
                        2'b01:begin
                            ram_be_n <= `BE_BYTE_1;
                            mem_wr_data <= reg2_data_i << 8;
                        end
                        2'b10:begin
                            ram_be_n <= `BE_BYTE_2;
                            mem_wr_data <= reg2_data_i << 16;
                        end
                        2'b11:begin
                            ram_be_n <= `BE_BYTE_3;
                            mem_wr_data <= reg2_data_i << 24;
                        end
                    endcase
                end
                default:
                    instValid <= 0;
            endcase
        end
        default:
            instValid <= 0;
    endcase
end

endmodule
