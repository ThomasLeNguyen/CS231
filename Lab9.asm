	.data
arr1:	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

strdiv:	.asciiz "\n================================================================================\n"
strdes: .asciiz "Program Description: 			Calculates the sum of two integers twice and prints it\n"
straut: .asciiz "Author: 				Thomas Thuan Le Nguyen\n"
strdat: .asciiz "Creation Date:				03/07/2021"

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

end:
	li $v0, 1
	add $a0, $t1, $0
	syscall

	#program end
  	li $v0, 10
  	syscall
