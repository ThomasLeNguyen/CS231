	.data
strdiv:	.asciiz "\n================================================================================\n"
strdes: .asciiz "Program Description: 			Program that simulates a simple adder\n"
straut: .asciiz "Author: 				Thomas Thuan Le Nguyen\n"
strdat: .asciiz "Creation Date:				02/08/2021"
strask: .asciiz "How many numbers you like to add together? "
strsum: .asciiz "The sum of the even numbers is "
	.text
	
main:
	#header start
	li $v0, 4
	la $a0, strdiv
	syscall
	
	la $a0, strdes
	syscall
	
	la $a0, straut
	syscall
	
	la $a0, strdat
	syscall
	
	la $a0, strdiv
	syscall
	#header end

	#asks user for count
	la $a0, strask
	syscall

	#user's input
	li $v0, 5
	syscall
	
	#moves user's input into $s2
	add $s2, $0, $v0
	
	li $s1, 0
	
	li $t0, 0
	
	li $t1, 2
	
	#loop
loop:	beq $s1, $s2, exit

	#user input
	li $v0, 5
	syscall
	
	div $v0, $t1
	mfhi $t2
	
	#if statement
	bne $t2, $0, cont
		add $t0, $t0, $v0
cont:
	addi $s1, $s1, 1
	j loop

exit:

	li $v0, 4
	la $a0, strsum
	syscall
	
	li $v0, 1
	add $a0, $0, $t0
	syscall

	li $v0, 10
	syscall
