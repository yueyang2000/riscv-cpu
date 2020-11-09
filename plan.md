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



# 中断与异常

- 记录M模式与U模式

### 同步异常

- 访存异常
- ebreak
- ecall
- 指令非法，比如
- 地址不对齐异常

### 异步中断

- 外设请求，当前程序保存现场，处理中断，再恢复现场。
- 中断不能嵌套

### 有关寄存器

- mtvec：处理异常的程序入口；高30位base，低2位mode
  - mode = 0，则所有异常、中断响应时跳转到base指示的pc
  - mode = 1，狭义异常发生时去base，狭义中断发生跳到base + 4*cause，cause对应中断的异常编号。
- mcause：高1位是中断域，低31位为异常编号域。组合表示，12种中断和16种异常
- mepc
  - 出现中断时，mepc为下一条未执行指令
  - 出现异常时，mepc为下一条更新为当前发生异常的指令PC。（由软件防止异常死循环）
- mtval
  - 由存储器访问产生的异常，将访问地址存入
  - 由非法指令造成的异常，把非法指令存入
- mstatus
  - 机器模式状态寄存器，有很多位。。。
  - MIE为1时响应中断，MIE为0时不响应（由于已经在处理某个异常）
  - 发生异常时：
    - MPIE域保存异常发生前的MIE值，异常结束后恢复MIE
    - MIE值被更新为0
    - MPP被更新为异常发生前的模式，为了异常处理结束后恢复



### 有关指令

- mret
  - pc = mepc
  - 更新mstatus：MIE = MPIE, MPIE = 1
  - 