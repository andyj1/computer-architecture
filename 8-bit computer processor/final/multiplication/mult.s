.data 
.byte num1 2
.byte num2 3
.text
la $sp num1
lw 0 $s1
lw 1 $s2
nand $ra $sp
sw 0 $s1
lw -1 $s1
addi -1 $sp
jal MULT
ADDITION: lw 1 $s2
add $s2 $s1
lw 0 $s2
MULT: lw -1 $ra
addi -1 $s2
sw 0 $s2
slt_0 $ra $s2
beq ADDITION
addi -1 $sp
sw 0 $s1
