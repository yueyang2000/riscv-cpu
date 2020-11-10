`define True 1'b1
`define False 1'b0
`define ZeroWord 32'b0

`define RstEnable 1'b1
`define RstDisable 1'b0
`define WriteEnable 1'b1
`define WriteDisable 1'b0
`define ReadEnable 1'b1
`define ReadDisable 1'b0

`define RegAddrBus 4:0
`define RegBus 31:0
`define RegNum 32

`define InstAddrBus 31:0
`define InstBus 31:0
`define InstValid 1'b1
`define InstInvalid 1'b0

`define DataAddrBus 31:0
`define DataBus 31:0

`define OP_ARITH 7'b0110011
`define OP_ARITH_I 7'b0010011
`define OP_JAL 7'b1101111
`define OP_JALR 7'b1100111
`define OP_BRANCH 7'b1100011
`define OP_AUIPC 7'b0010111
`define OP_LUI 7'b0110111
`define OP_LOAD 7'b0000011
`define OP_STORE 7'b0100011
`define OP_SYS 7'b1110011

// funct3 of arith instructions
`define ARITH_ADD 3'b000
`define ARITH_SLL 3'b001
`define ARITH_SLT 3'b010 
`define ARITH_SLTU 3'b011 
`define ARITH_XOR 3'b100 
`define ARITH_SRL 3'b101 
`define ARITH_OR 3'b110
`define ARITH_AND 3'b111

// funct3 of jalr
`define JALR_FUNCT3 3'b000

// funct7 of arith instructions
`define ARITH_ADD_FUNCT7 7'b0000000
`define ARITH_AND_FUNCT7 7'b0000000
`define ARITH_OR_FUNCT7 7'b0000000
`define ARITH_XOR_FUNCT7 7'b0000000
`define ARITH_SUB_FUNCT7 7'b0100000
`define ARITH_MIN_FUNCT7 7'b0000101

// clz ctz prefix
`define CLZ_PREFIX 12'b011000000000
`define CTZ_PREFIX 12'b011000000001

// funct3 of branch instructions
`define BRANCH_BEQ 3'b000
`define BRANCH_BNE 3'b001 
`define BRANCH_BLT 3'b100 
`define BRANCH_BGE 3'b101 
`define BRANCH_BLTU 3'b110 
`define BRANCH_BGEU 3'b111

// funct3 of Load/Store instructions
`define LS_B 3'b000
`define LS_H 3'b001 
`define LS_W 3'b010 
`define LS_BU 3'b100 
`define LS_HU 3'b101 

// state machine for cpu
`define StateBus 3:0
`define STATE_BOOT 4'b0000
`define STATE_IF 4'b0001 
`define STATE_EXE 4'b0010 
`define STATE_MEM 4'b0011
`define STATE_WB 4'b0100 
`define STATE_EXP 4'b0101 

`define USE_NOTHING 2'b00
`define USE_BASE 2'b01 
`define USE_EXT 2'b10 
`define USE_UART 2'b11 

`define START_ADDR 32'h80000000
// `define START_ADDR 32'h0
// uart
`define UART_DATA_ADDR 32'h10000000
`define UART_STATUS_ADDR 32'h10000005 
`define BE_WORD 4'b0000
`define BE_BYTE_0 4'b1110
`define BE_BYTE_1 4'b1101
`define BE_BYTE_2 4'b1011
`define BE_BYTE_3 4'b0111

// exp_code
`define ExpBus 3:0
`define exp_inst_addr_mis 4'b0000  
`define exp_inst_acc_fault 4'b0001  
`define exp_inst_illegal 4'b0010  
`define exp_break 4'b0011 
`define exp_load_addr_mis 4'b0100 
`define exp_load_acc_fault 4'b0101 
`define exp_store_addr_mis 4'b0110 
`define exp_store_acc_fault 4'b0111 
`define exp_ecall_u 4'b1000 
`define exp_ecall_s 4'b1001 
`define exp_ecall_m 4'b1011 
`define exp_inst_page_fault 4'b1100 
`define exp_load_page_fault 4'b1101
`define exp_store_page_fault 4'b1111 

// three type of issue for exp_handle
`define EXP_NONE 2'b00  
`define EXP_ERR 2'b01   
`define EXP_OP 2'b10

//ebreak ecall mret prefix 
`define EBREAK_PREFIX 25'b0000000000010000000000000
`define ECALL_PREFIX 25'b0000000000000000000000000
`define MRET_PREFIX 25'b0011000000100000000000000

`define CsrAddrBus 11:0

