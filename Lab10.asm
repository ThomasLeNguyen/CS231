	.data
arr1:	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

strdiv:	.asciiz "\n================================================================================\n"
strdes: .asciiz "Program Description: 			Calculates the sum of two integers twice and prints it\n"
straut: .asciiz "Author: 				Thomas Thuan Le Nguyen\n"
strdat: .asciiz "Creation Date:				03/07/2021"

stript: .asciiz "Input two integer: "
strsum: .asciiz "the sum of the numbers are: "
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

loop:	beq $s0, 2, done

	jal getNum # go to getNum routine
	add $s1, $v1, $0
	
	jal getNum # go to getNum routine
	add $s2, $v1, $0
	
	add $a1, $s1, $0
	add $a2, $s2, $0
	jal addFunc # go to getFunc routine
	
	add $a3, $v1, $0
	jal printNum # go to printNum routine
	
	addi $s0, $s0, 1
	j loop

done:
	
	li $v0, 10
	syscall

# getNum
getNum:
	li $v0, 4 # print str1
	la $a0, stript
	syscall

	li $v0, 5 # get first number
	syscall
	
	add $t5, $0, $v0 # put the number of integer need to inputed to $t5

	add $v1, $0, $t5 # Passing to function by $v1

	jr $ra

# addFunc
addFunc:
	add $t5, $0, $a1 # Passing to function by $a1
	add $t6, $0, $a2 # Passing to function by $a2

	add $t7, $t5, $t6

	add $v1, $t7, $0 # returning the result to main
	
	jr $ra
	
# printNum
printNum:
	add $t5, $0, $a3

	li $v0, 4 # print str1
	la $a0, strsum
	syscall

	li $v0, 1 # print first number $s0
	add $a0, $0, $t5
	syscall
	
	li $v0, 4 # print str1
	la $a0, strskp
	syscall

	jr $ra