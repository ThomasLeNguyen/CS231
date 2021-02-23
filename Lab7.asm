	.data
strdiv:	.asciiz "\n================================================================================\n"
strdes: .asciiz "Program Description: 			Assemble language to write power function x^y\n"
straut: .asciiz "Author: 				Thomas Thuan Le Nguyen\n"
strdat: .asciiz "Creation Date:				02/22/2021"

strtms: .asciiz "How many times do you want to run?\n"
strgtx: .asciiz "What do you want x to be?\n"
strgty: .asciiz "What do you want y to be?\n"
stretr: .asciiz "Enter an integer between 0-11\n"
strerr: .asciiz "Invalid number\n"

# for end result
strpow: .asciiz "^"
streql: .asciiz "="
strskp: .asciiz "\n"
	.text
	
main:

	# header start
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
	# header end
	
	# ask
	la $a0, strtms
	syscall
	
	# user's input
	li $v0, 5
	syscall
	add $s1, $0, $v0
	
check:	bge $s1, 1, works
		# invalid number
		li $v0, 4
		la $a0, strerr
		syscall
		
		# ask
		la $a0, strtms
		syscall
		
		# user's input
		li $v0, 5
		syscall
		add $s1, $0, $v0
		
		j check
	
	works:
	
	add $s1, $0, $v0
	
	# set first index to 0
	li $s0, 0
	
loop:	beq $s0, $s1, exit

	loop2:
		# ask
		li $v0, 4
		la $a0, strgtx
		syscall
		
		# user's input
		li $v0, 5
		
		syscall
		add $t1, $0, $v0
		
		bgt $t1, 12, error1 # if user input is greater than 12
		blt $t1, 0, error1 # if user input is less than 0 or equal to
		
	loop3:
		# ask
		li $v0, 4
		la $a0, strgty
		syscall
		
		# user's input
		li $v0, 5
		
		syscall
		add $t2, $0, $v0
	
		bgt $t2, 12, error2 # if user input is greater than 12
		blt $t2, 0, error2 # if user input is less than 0 or equal to
		
		# sets answer to 1
		li $t3, 1
		
		beq $t2, 0, answer # if y is 0
		
		# sets answer to 0
		li $t3, 0
		
		beq $t1, 0, answer # if x is 0
		
		# sets answer to 1
		li $t3, 1
		
		# starts at index 1
		li $t0, 1
		
	power:
		bgt $t0, $t2, answer
			mult $t1, $t3
			mflo $t3
			mfhi $t4
			
			add $t3, $t3, $t4
			
			addi $t0, $t0, 1
			j power
		
		answer:
		
		li $v0, 1
		add $a0, $t1, $0
		syscall
		
		# "^"
		li $v0, 4
		la $a0, strpow
		syscall
		
		li $v0, 1
		add $a0, $t2, $0
		syscall
		
		# "="
		li $v0, 4
		la $a0, streql
		syscall
		
		
		# answer
		li $v0, 1
		add $a0, $t3, $0
		syscall
		
		# "\n"
		li $v0, 4
		la $a0, strskp
		syscall
		
		addi $s0, $s0, 1
		j loop
		
		error1:
			li $v0, 4
			la $a0, strerr
			syscall
			j loop2
			
		error2:
			li $v0, 4
			la $a0, strerr
			syscall
			j loop3

exit:
	
	#program end
	li $v0, 10
	syscall
