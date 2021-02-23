	.data
strdiv:	.asciiz "\n================================================================================\n"
strdes: .asciiz "Program Description: 			Asks user for number from 0-10 then finds the factorial of the number\n"
straut: .asciiz "Author: 				Thomas Thuan Le Nguyen\n"
strdat: .asciiz "Creation Date:				02/17/2021"

strask: .asciiz "How many times do you want to run?\n"
stretr: .asciiz "Enter an integer between 0-10\n"
strerr: .asciiz "Invalid number\n"

# for end result
stropn: .asciiz "("
strcls: .asciiz "!)="
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
	la $a0, strask
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
		la $a0, strask
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
		# ask
		li $v0, 4
		la $a0, stretr
		syscall
		
		# user's input
		li $v0, 5
		syscall
		add $t1, $0, $v0
		
		bgt $t1, 10, error # if user input is greater than 10
		blt $t1, 0, error # if user input is less than 0 or equal to
		
		# sets factorial sum to 1
		li $t2, 1
		
		beq $t1, 0, factorialSum # if N is 0
		beq $t1, 1, factorialSum # if N is 1
		
		# starts at index 1
		li $t0, 1
		
	factorial:
		bgt $t0, $t1, factorialSum
			mult $t2, $t0
			mflo $t2
			
			addi $t0, $t0, 1
			j factorial
		
		factorialSum:
		
		# "("
		li $v0, 4
		la $a0, stropn
		syscall
		
		li $v0, 1
		add $a0, $t1, $0
		syscall
		
		# "!)="
		li $v0, 4
		la $a0, strcls
		syscall
		
		# answer
		li $v0, 1
		add $a0, $t2, $0
		syscall
		
		# "\n"
		li $v0, 4
		la $a0, strskp
		syscall
		
		addi $s0, $s0, 1
		j loop
		
		error:
			li $v0, 4
			la $a0, strerr
			syscall
			j loop

exit:
	
	#program end
	li $v0, 10
	syscall
