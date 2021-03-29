	.data

input:	.space 1000
enc:	.space 1000
dec:	.space 1000

# header
strdiv:	.asciiz "================================================================================\n"
strdes: .asciiz "Program Description: 			Gets a 9 character line and encrypts using Number 10\n"
straut: .asciiz "Author: 				Thomas Thuan Le Nguyen\n"
strdat: .asciiz "Creation Date:				03/28/2021"

# program text
strsze: .asciiz "How many characters? Has to be between 1 and 9:\n"
strise: .asciiz "\tInvalid size, has to be between 1 and 9:\n"
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

	# How many characters? Has to be between 1 and 9:
  	la $a0, strsze
  	syscall
  	
  	# get user input
  	li $v0, 5
  	syscall
  	add $s0, $v0, $0
  	
# checks the size 1
CheckSize1:
	# if greater than 0
	bgt $s0, 0, CheckSize2
		# less than 0
		j InvalidSize

# checks the size 2
CheckSize2:
	# if less than or equal to 9
	ble $s0, 9, ValidSize

# not between 1 and 9
InvalidSize:
	# Invalid size, has to be between 1 and 9:
	li $v0, 4
	la $a0, strise
	syscall

	# get user input
	li $v0, 5
	syscall
	add $s0, $v0, $0

	# rechecks size
	j CheckSize1
	
ValidSize:

	add $t9, $s0, $0
	add $t8, $s0, $0

  	# Please enter the message to be sent:
  	li $v0, 4
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
  	
  	# Number 10
  	li $t3, 10
  	
  	# initializes arrays
  	la $s0, input
  	la $s1, enc
  	
BeforeEncryption:
	beq $t9, $0, Encrypted
	
	lb $t1, 0($s0)
	xor $t2, $t1, $t3
	sb $t2, 0($s1)
	
	addi $t9, $t9, -1
	addi $s0, $s0, 1
	addi $s1, $s1, 1
	
	j BeforeEncryption
	
Encrypted:
	# Your encrypted message is:
	li $v0, 4
	la $a0, strenc
	syscall

	la $a0, enc
	syscall

	# initializes arrays
	la $s0, enc
	la $s1, dec
	
BeforeDecryption:
	beq $t8, $0, Decrypted
	
	lb $t1, 0($s0)
	xor $t2, $t1, $t3
	sb $t2, 0($s1)
	
	addi $t8, $t8, -1
	addi $s0, $s0, 1
	addi $s1, $s1, 1
	
	j BeforeDecryption
	
Decrypted:
	# Your decrypted message is:
  	li $v0, 4
  	la $a0, strdec
  	syscall

	la $a0, dec
	syscall

# everything is done running
Done:
	# -- program is finished running --
	li $v0, 10
	syscall
