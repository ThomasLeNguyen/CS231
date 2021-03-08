	.data
arr1:	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

strdiv:	.asciiz "\n================================================================================\n"
strdes: .asciiz "Program Description: 			Calculates the sum of two integers twice and prints it\n"
straut: .asciiz "Author: 				Thomas Thuan Le Nguyen\n"
strdat: .asciiz "Creation Date:				03/07/2021"

stript: .asciiz "Input two integer :\n"
strsum: .asciiz "\nthe sum of the numbers are:"

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

	jal getNum # go to getNum routine
	add $s0, $v1, $0
	
	jal getNum # go to getNum routine
	add $s1, $v1, $0
	
	add $a1, $s0, $0
	add $a2, $s1, $0
	jal addFunc # go to getFunc routine
	
	add $t3, $v1, $0
	
	add $a3, $t3, $0
	
	jal printNum # go to printNum routine
	
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

	add $a1, $0, $t5 # Passing to function by $a1

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
	add $t0, $v1, $0

	li $v0, 1 # print first number $s0
	add $a0, $t0, $0
	syscall

	jr $ra

	#program end
  	li $v0, 10
  	syscall
