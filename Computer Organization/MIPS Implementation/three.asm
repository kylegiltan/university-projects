.data
Prompt1: .asciiz "\n Please input a value for b \n"
#Prompt2: .asciiz "\n Please input a value \n"
.text
main: 
li $v0, 4
la $a0, Prompt1
syscall # This syscall is for printing
li $v0, 5
syscall # This syscall is for reading
move $t1, $v0 # value for b

#li $v0, 4
#la $a0, Prompt2
#syscall # This syscall is for printing
#li $v0, 5
#syscall # This syscall is for reading
#move $t1, $v0 # value for b

li $t0,2 #value for a
li $t2,1

while: 
     beqz $t1, end
     mult $t2,$t0
     mflo $t2
     #move $t2,$t0
     addi $t1,$t1,-1
     b while
end:
