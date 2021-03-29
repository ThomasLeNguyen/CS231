	.data

input:	.byte '-', '-', '-', '-', '-', '-', '-', '-', '-', '-'
output:	.byte '-', '-', '-', '-', '-', '-', '-', '-', '-', '-'

# header
strdiv:	.asciiz "================================================================================\n"
strdes: .asciiz "Program Description: 			Gets a 9 character line and encrypts using Number 10\n"
straut: .asciiz "Author: 				Thomas Thuan Le Nguyen\n"
strdat: .asciiz "Creation Date:				03/28/2021"

# program text
strask: .asciiz "Please enter the message to be sent:\n"
strenc: .asciiz "\nYour encrypted message is:\n"
strdec: .asciiz "\nYour decrypted message is:\n"

# display strings
strcln: .asciiz ": "
strskp: .asciiz "\n"

	.text

########################### main ###########################
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
	la $a0, strskp
	syscall
  	la $a0, strdiv
  	syscall
  	# header end

  	# Please enter the message to be sent:
  	la $a0, strask
  	syscall

  	# get user input
  	la $a0, input
  	li $v0, 8
  	li $a1, 10
  	syscall
  	
  	# prints out the message inputted
  	# la $a0, input
  	# li $v0, 4
  	# syscall
  	
  	li $t0, 10
  	la $s1, output
  	la $s2, input
  	
Loop:	beq $t0, $0, Print

	lb $t1, 0($s2)
	sb $t1, 0($s1)
	li $t1, 0
	addi $s2, $s2, 1
	
	addi $s1, $s1, 1
	sub $t0, $t0, 1
	j Loop
	
Print:	# Your encrypted message is:
  	li $v0, 4
  	la $a0, strenc
  	syscall

	la $a0, output
	syscall

	# Your decrypted message is:
  	li $v0, 4
  	la $a0, strdec
  	syscall

	la $a0, output
	syscall

# everything is done running
Done:
	# -- program is finished running --
	li $v0, 10
	syscall