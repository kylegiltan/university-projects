.data
Prompt1: .asciiz "\nPlease input value for r0: "
.text

main: 
li $v0, 4 # x = 4
la $a0, Prompt1
syscall # This syscall is for printing


li $v0,5
syscall #read

move $t0,$v0 #t0 is input

li $t3,1 #r3
li $t1,0 #r1 counter


while: 

     beqz $t3,end
     and $t4, $t3, $t0
     add $t3,$t3,$t3
     beqz $t4,while
     addi $t1,$t1,1
     b while

end:

