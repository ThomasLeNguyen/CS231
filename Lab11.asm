	.data

strdiv:	.asciiz "\n================================================================================\n"
strdes: .asciiz "Program Description: 			Converts decimal to binary\n"
straut: .asciiz "Author: 				Thomas Thuan Le Nguyen\n"
strdat: .asciiz "Creation Date:				03/07/2021"

stript: .asciiz "Input a number in decimal form: "
strfrt: .asciiz "The number "
strend: .asciiz " in binary is: "
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

	li $s0, 0

Loop:	beq $s0, 3, Done

	jal GetNum # go to GetNum routine
	add $s1, $v1, $0
	add $t9, $s1, $0
	
	add $a1, $s1, $0
	jal BaseChange # go to BaseChange routine
	
	add $a3, $v1, $0
	jal Print # go to Print routine
	
	addi $s0, $s0, 1
	j Loop

Done:
	
	li $v0, 10
	syscall

# GetNum
GetNum:
	li $v0, 4 # print str1
	la $a0, stript
	syscall

	li $v0, 5 # get first number
	syscall
	
	add $t5, $0, $v0 # put the number of integer need to inputed to $t5

	add $v1, $0, $t5 # Passing to function by $v1

	jr $ra

# BaseChange
BaseChange:
	add $t5, $0, $a1 # Passing to function by $a1
	
	li $t2, 2
	
	Push: beq $t5, 0, PushDone
	
		div $t5, $t2
		mflo $t6
		mfhi $t7
	
		add $t5, $0, $t6
	
		# li $v0, 1 # print first number $s0
		# add $a0, $0, $t7
		# syscall
		
		sub $sp, $sp, 4
		sw $t7, 0($sp)
		addi $t0, $t0, 1
		
		j Push
		
	PushDone:
	
	Zero: beq $t0, 32, ZeroDone
		sub $sp, $sp, 4
		sw $0, 0($sp)
		addi $t0, $t0, 1
		
		j Zero
	ZeroDone:
	
	add $v1, $0, $t0
	
	jr $ra
	
# Print
Print:
	add $t0, $0, $a3

	li $v0, 4
	la $a0, strfrt
	syscall
	
	li $v0, 1
	add $a0, $0, $t9
	syscall
	
	li $v0, 4
	la $a0, strend
	syscall
	
	li $t1, 0
	Pop: beq $t0, $t1, PopDone
		
		lw $s5, 0($sp)
		li $v0, 1
		add $a0, $0, $s5
		syscall
		
		addi $sp, $sp, 4
		addi $t0, $t0, -1
		
		j Pop
		
	PopDone:
	
	li $v0, 4 # print str1
	la $a0, strskp
	syscall

	jr $ra
