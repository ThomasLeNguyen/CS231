	.data
strdiv:	.asciiz "\n================================================================================\n"
strdes: .asciiz "Program Description: 			This program is written to mimic a very basic calculator\n"
straut: .asciiz "Author: 				Thomas Thuan Le Nguyen\n"
strdat: .asciiz "Creation Date:				02/03/2021"
strin:	.asciiz "Please input the two numbers?\n\n"
strsum: .asciiz "\nSum is:		"
strdif: .asciiz "\nDifference is:	"
strpro: .asciiz "\nProduct is:  	"
strquo: .asciiz "\nQuotient is: 	"
strrem: .asciiz "\nRemainder is:	"
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

	la $a0, strin
	syscall

	#gets user input
	li $v0, 5
	syscall

	#stores the user's input inside another location
	add $s0, $0, $v0

	#gets user input
	li $v0, 5
	syscall

	#stores the user's input inside another location
	add $s1, $0, $v0

	#prints out sum desc
	li $v0, 4
	la $a0, strsum
	syscall

	#prints out sum
	li $v0, 1
	add $a0, $s0, $s1
	syscall

	#prints out difference desc
	li $v0, 4
	la $a0, strdif
	syscall

	#prints out difference
	li $v0, 1
	sub $a0, $s0, $s1
	syscall

	#prints out product desc
	li $v0, 4
	la $a0, strpro
	syscall

	#prints out product
	mult $s0, $s1

	mfhi $t0
	mflo $t1

	li $v0, 1
	add $a0, $t1, $0

	syscall

	#prints out quotient desc
	li $v0, 4
	la $a0, strquo
	syscall

	#calculates quotient and remainder
	div $s0, $s1

	mfhi $t0
	mflo $t1

	#prints out quotient
	li $v0, 1
	add $a0, $t1, $0

	syscall

	#prints out remainder desc
	li $v0, 4
	la $a0, strrem
	syscall

	#prints out remainder
	li $v0, 1
	add $a0, $t0, $0

	syscall

	li $v0, 10
	syscall
