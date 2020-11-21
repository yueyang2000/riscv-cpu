# s9 0x20000000 s11 0x80100000 x4 返回地址
BACKGROUND:
.long 0b00000000000000111111111111111111  
.long 0b00000000000000111111111110000000  
.long 0b11111110000000111111111110000000    
.long 0b11111110000000111111111110000111 
.long 0b11111110000000111111111110000111 
.long 0b11111110000000111111111110000111
.long 0b11111110000000111111111110000111 
.long 0b11111110000000111111111110000111
.long 0b11111110000000111111111110000111 
.long 0b11111110000000000000011110000111
.long 0b11111110000000000000011110000111 
.long 0b11111111111111000000011110000111 
.long 0b11111111111111000000011110000111 
.long 0b11111111111111000000011110000111 
.long 0b11100000000000000000011110000111 
.long 0b11100000000000000000011110000111 
.long 0b11100000000000000000011110000111  
.long 0b11100001111111111111111110000111 
.long 0b11100001111111111111111110000111 
.long 0b11100001111111111111111110000111 
.long 0b11100001111111111111111110000111  
.long 0b11100001111111111111111110000111 
.long 0b11100000000000000000000000000111  
.long 0b11100000000000000000000000000111 
.long 0b11100000000000000000000000000111  
renderBackground:
    auipc s11, 0x0
    addi s11, s11, -0x64 # 背景起始地址
    mv s10, s11 # s11不可变 s10可以变
    mv x4, ra
    li s9, 0x20000000
    li a5, 0
    li a6, 0
    li a0, 0x0
    li a3, 32  # 最大列数
    li a4, 24  # 最大行数   
LINE: # a0是行 a1是列
    lw t0, 0(s10) # t0是本行01串
    li a1, 0x0
    li t2, 0x1f
SQUARE:
    sub t3, t2, a1 # t3 = t2 - a1 表示要右移的位数
    srl t4, t0, t3
    andi t4, t4, 0x1
    li a2, 0xff # 确定颜色
    bne t4, zero, COLOR_CONTINUE
    li a2, 0x0
COLOR_CONTINUE:
    sw a0, -4(sp)
    sw a1, -8(sp)
    sw a2, -12(sp)
    sw t0, -16(sp)
    sw t1, -20(sp)
    sw t2, -24(sp)
    sw s1, -28(sp)
    sw s2, -32(sp)
    sw s3, -36(sp)
    sw s8, -40(sp)
    # sw ra, -44(sp)
    jal renderSquare
    lw a0, -4(sp)
    lw a1, -8(sp)
    lw a2, -12(sp)
    lw t0, -16(sp)
    lw t1, -20(sp)
    lw t2, -24(sp)
    lw s1, -28(sp)
    lw s2, -32(sp)
    lw s3, -36(sp)
    lw s8, -40(sp)
    # lw ra, -44(sp)
    # 一个方格画完
    addi a1, a1, 0x1
    bne a1, a3, SQUARE
    # 一行画完
    addi a0, a0, 0x1
    addi s10, s10, 0x4
    bne a0, a4, LINE
    jal renderPerson # renderBackground 结束
    j OPERATION
mul25: # a0 = a0*25
    slli t0, a0, 4
    slli t1, a0, 3
    add t0, t0, t1
    add t0, t0, a0
    mv a0, t0
    ret
# 需要保存的有 a0,a1,a2,t0,t1,t2,s1,s2,s3,s8,ra
renderSquare:# 参数 a0:行, a1：列, a2: 颜色
    # s3 = a0*20000 + s9, 每次加800
    # s1 = a1*25, 每次加1
    mv s8, ra
    jal mul25  # a0 = a0*25
    jal mul25  # a0 = a0*25
    slli s3, a0, 5  # s3 = a0*20000
    add s3, s3, s9  # s3 = a0*20000 + s9
    mv a0, a1   # a0 = a1
    jal mul25 
    mv s1, a0 # s1 = a1*25
    li t2, 25 # t2 = 25
    li t0, 0    # t0是小行号
L1:
    li t1, 0    # t1是小列号 0~24
    add s2, s3, s1  #本行开头
L2:
    sb a2, 0(s2)
    addi t1, t1, 1
    addi s2, s2, 1 
    bne t1, t2, L2  # branch if t1!=25
L2_end:
    addi s3, s3, 800
    addi t0, t0, 1
    bne t0, t2, L1 # branch if t0!=25
    mv ra, s8
    ret
renderPerson: # a5, a6存当前位置
    mv a0, a5
    mv a1, a6
    li a2, 0b11000000
    mv s10, ra
    jal renderSquare
    mv ra, s10
    ret
OPERATION:
    li t0, 0x20075300
.TESTO:
    lw t1, 0(t0)
    beq t1, zero, .TESTO # 忙等待
    # 进入不同操作
    andi t2, t1, 0x1
    bne t2, zero, OP_R
    andi t2, t1, 0x2
    bne t2, zero, OP_L  
    andi t2, t1, 0x4
    bne t2, zero, OP_D 
    andi t2, t1, 0x8
    bne t2, zero, OP_U
OP_R:
    mv t0, a5
    mv t1, a6
    li t2, 31
    beq a6, t2, OPERATION_DONE # 右侧不能越界
    li t2, 30
    slli t3, t0, 0x2
    add t3, t3, s11
    lw t3, 0(t3)
    sub t4, t2, t1
    srl t5, t3, t4
    andi t5, t5, 0x1
    bne t5, zero, OPERATION_DONE # 右侧有墙
    # 可以向右移动了 先将本块涂黑
    mv a0, a5
    mv a1, a6
    li a2, 0x0
    jal renderSquare
    # 更新a5 a6
    addi a6, a6, 0x1
    j OPERATION_DONE
OP_L:
    mv t0, a5
    mv t1, a6
    li t2, 0
    beq a6, t2, OPERATION_DONE # 左侧不能越界
    li t2, 32
    slli t3, t0, 0x2
    add t3, t3, s11
    lw t3, 0(t3)
    sub t4, t2, t1
    srl t5, t3, t4
    andi t5, t5, 0x1
    bne t5, zero, OPERATION_DONE # 左侧有墙
    # 可以向左移动了 先将本块涂黑
    mv a0, a5
    mv a1, a6
    li a2, 0x0
    jal renderSquare
    # 更新a5 a6
    addi a6, a6, -0x1
    j OPERATION_DONE
OP_U:
    mv t0, a5
    mv t1, a6
    li t2, 0
    beq a5, t2, OPERATION_DONE # 上侧不能越界
    li t2, 31
    slli t3, t0, 0x2
    add t3, t3, s11
    addi t3, t3, -0x4
    lw t3, 0(t3)
    sub t4, t2, t1
    srl t5, t3, t4
    andi t5, t5, 0x1
    bne t5, zero, OPERATION_DONE # 上侧有墙
    # 可以向上移动了 先将本块涂黑
    mv a0, a5
    mv a1, a6
    li a2, 0x0
    jal renderSquare
    # 更新a5 a6
    addi a5, a5, -0x1
    j OPERATION_DONE
OP_D:
    mv t0, a5
    mv t1, a6
    li t2, 23
    beq a5, t2, OPERATION_DONE # 下侧不能越界
    li t2, 31
    slli t3, t0, 0x2
    add t3, t3, s11
    addi t3, t3, 0x4
    lw t3, 0(t3)
    sub t4, t2, t1
    srl t5, t3, t4
    andi t5, t5, 0x1
    bne t5, zero, OPERATION_DONE # 下侧有墙
    # 可以向下移动了 先将本块涂黑
    mv a0, a5
    mv a1, a6
    li a2, 0x0
    jal renderSquare
    # 更新a5 a6
    addi a5, a5, 0x1
    j OPERATION_DONE
OPERATION_DONE: # 操作结束 重新renderPerson
    jal renderPerson
    li t0, 0x0
    li t1, 0x0000ffff
WATING_LOOP:
    addi t0, t0, 1
    bne t0, t1, WATING_LOOP
    j OPERATION