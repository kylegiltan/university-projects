.data
Prompt1: .asciiz "\nPlease input value for A: "
Prompt2: .asciiz "\nPlease input value for B: "
PromptEqual: .asciiz "\nThe two values are equal."
.text

main: 
li $v0, 4 # x = 4
la $a0, Prompt1
syscall # This syscall is for printing
li $v0, 5 #y = 5
syscall # This syscall is for reading
move $t0, $v0

li $v0, 4
la $a0, Prompt2
syscall # This syscall is for printing
li $v0, 5
syscall # This syscall is for reading
move $t1, $v0

li $v0, 1
ble $t0, $t1, bgreaterthana
move $a0, $t0
syscall
b end

bgreaterthana:
beq $t0, $t1, equal
move $a0, $t1
syscall
b end



equal:
li $v0 4
la $a0, PromptEqual
syscall

end:


