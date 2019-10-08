.data
getString: .asciiz "\nPlease enter a word that is 7 chars long: \t"
true: .asciiz "\nYour word is a palindrome"
false: .asciiz "\nYour word is not a palindrome"
.text

main:
li $v0, 4 #syscall command for printing string
la $a0, getString
syscall

li $a1, 8

li $v0, 8
syscall

move $t0, $a0


lb $s0, 0($a0)
lb $s1, 1($a0)
lb $s2, 2($a0)
lb $s3, 3($a0)
lb $s4, 4($a0)
lb $s5, 5($a0)
lb $s6, 6($a0)

beq $s0, $s6, test2
b failed

test2:
beq $s1, $s5, test3
b failed

test3:
beq $s2, $s4, passed
b failed

passed:
li $v0, 4 #syscall command for printing string
la $a0, true
syscall
b end

failed:
li $v0, 4 #syscall command for printing string
la $a0, false
syscall
b end

end:
