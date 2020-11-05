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
`define STATE_UART 4'b0101