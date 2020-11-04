# 基础指令：19条

### 运算指令

```
ADD   0000000SSSSSsssss000ddddd0110011
reg[rd] = reg[rs1] + reg[rs2]
pc += 4

AND   0000000SSSSSsssss111ddddd0110011
reg[rd] = reg[rs1] & reg[rs2]
pc += 4

OR    0000000SSSSSsssss110ddddd0110011
reg[rd] = reg[rs1] | reg[rs2]
pc += 4

XOR   0000000SSSSSsssss100ddddd0110011
reg[rd] = reg[rs1] ^ reg[rs2]
pc += 4

ADDI  iiiiiiiiiiiisssss000ddddd0010011
reg[rd] = reg[rs1] + ext_imm
pc += 4

ANDI  iiiiiiiiiiiisssss111ddddd0010011
reg[rd] = reg[rs1] & ext_imm
pc += 4

ORI   iiiiiiiiiiiisssss110ddddd0010011
reg[rd] = reg[rs1] | ext_imm
pc += 4

SLLI  0000000iiiiisssss001ddddd0010011
reg[rd] = reg[rs1] << imm5
pc += 4

SRLI  0000000iiiiisssss101ddddd0010011
reg[rd] = reg[rs1] >> imm5
pc += 4
```

### 跳转与PC

```
JAL   iiiiiiiiiiiiiiiiiiiiddddd1101111
reg[rd] = pc + 4
pc = pc + ext_{imm20, 0}

JALR  iiiiiiiiiiiisssss000ddddd1100111
reg[rd] = pc + 4
pc = {(reg[rs1] + ext_imm)[31:1], 0} 


BEQ   iiiiiiiSSSSSsssss000iiiii1100011
immB = {imm[12:1], 0}
pc = (reg[rs1] == reg[rs2])? pc + immB:pc+4

BNE   iiiiiiiSSSSSsssss001iiiii1100011
immB = {imm[12:1], 0}
pc = (reg[rs1] != reg[rs2])? pc + immB:pc+4
```

### 高20位运算

```
AUIPC iiiiiiiiiiiiiiiiiiiiddddd0010111
reg[rd] = {imm20, 8'b0} + pc
pc = pc + 4

LUI   iiiiiiiiiiiiiiiiiiiiddddd0110111
reg[rd] = {imm20, 8'b0}
pc = pc + 4
```

### 访存指令

```
LB    iiiiiiiiiiiisssss000ddddd0000011
reg[rd] = ext(mem[reg[rs1]+ext_imm12][7:0])
pc = pc + 4

LW    iiiiiiiiiiiisssss010ddddd0000011
reg[rd] = mem[reg[rs1]+ext_imm12]
pc = pc + 4

SB    iiiiiiiSSSSSsssss000iiiii0100011
mem[reg[rs1]+ext_imm12] = reg[rs2][7:0]
pc = pc + 4

SW    iiiiiiiSSSSSsssss010iiiii0100011
mem[reg[rs1]+ext_imm12] = reg[rs2]
pc = pc + 4
```

### 额外指令

```
CTZ	rd, rs		
// The ctz operation counts the number of 0 bits at the LSB end of the argument.

CLZ	rd, rs		
// The clz operation counts the number of 0 bits at the MSB end of the argument.

MIN	rd, rs1, rs2
// return the smaller one
```



# 五级流水线

### 冲突：RAW

- 前语句还没写后语句就读了
- 对于算术指令，采用数据前推
- 对于load指令，插入一条nop

### 冲突：分支跳转



### 取指

取出存储器的指令

### 译码

- 从机器码生成控制信号
- 取出寄存器操作数
- 生成立即数

### 执行

- 执行运算

### 访存

### 写回

- 保存运算结果到寄存器

