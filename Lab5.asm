	.data
strdiv:	.asciiz "\n================================================================================\n"
strdes: .asciiz "Program Description: 			Sums up positive multiples of 6 entered by user\n"
straut: .asciiz "Author: 				Thomas Thuan Le Nguyen\n"
strdat: .asciiz "Creation Date:				02/01/2021"
strcrn: .asciiz "\nThe Course number			"
strgrd: .asciiz "\nThe year in program 			"
strask: .asciiz "How many positive numbers that are divisible by 6 do you want to add?\n"
stretr: .asciiz "Enter a number: "
strarw: .asciiz "\n==>"
strisd: .asciiz " is divisible by 6\n"
strerr: .asciiz "**** ERROR: "
#potential errors
strpos: .asciiz " is not a positive number. Enter another number.\n"
strrge: .asciiz " is not in the range of 1 to 100. Enter another number.\n"
strnot: .asciiz " is not divisible by 6. Enter another number.\n"

strtot: .asciiz "\nThe sum of the positive numbers between 1 and 100 that are divisible by 6 is: "
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
	
	#ask
	la $a0, strask
	syscall
	
	#user's input
	li $v0, 5
	syscall
	
	#the amount the person wants
	add $s2, $0, $v0
	
	#set first index to 0
	li $s1, 0
	
	#user input
	li $t0, 0
	
	#sum
	li $s3, 0
	
	li $s4, 6
	
loop:	beq $s1, $s2, exit
		#asks for number
		li $v0, 4
		la $a0, stretr
		syscall
		
		li $v0, 5
		syscall
		
		add $t0, $v0, $0
		
		div $t0, $s4
		mfhi $t1
		mflo $t2
		
	bgt $t0, 100, error1
	beq $t0, 0, error1
	ble $t0, 0, error2
	
	bne $t1, $0, error3
		li $v0, 4
		la $a0, strisd
		syscall
		
		add $s3, $s3, $t0
		
	addi $s1, $s1, 1
	j loop

	error1:
		li $v0, 4
		la $a0, strrge
		syscall
		j loop
		
	error2:
		li $v0, 4
		la $a0, strpos
		syscall
		j loop
		
	error3:
		li $v0, 4
		la $a0, strnot
		syscall
		j loop

exit:
	#displays sum
	li $v0, 4
	la $a0, strtot
	
	li $v0, 1
	add $a0, $0, $s3
	syscall
	
	#program end
	li $v0, 10
	syscall
