	.data
strdiv:	.asciiz "\n================================================================================\n"
strdes: .asciiz "Program Description: 			A simple program to output string and integer\n"
straut: .asciiz "Author: 				Thomas Thuan Le Nguyen\n"
strdat: .asciiz "Creation Date:				02/01/2021"
strcrn: .asciiz "\nThe Course number			"
strgrd: .asciiz "\nThe year in program 			"
	.text

main:
	li $v0, 4
	la $a0, strdiv
	syscall
	
	la $a0, strdes
	syscall
	
	la $a0, straut
	syscall
	
	la $a0, strdat
	syscall
	
	la $a0, strcrn
	syscall
	
	li $v0, 1
	la $a0, 231
	syscall
	
	li $v0, 4
	la $a0, strgrd
	syscall
	
	li $v0, 1
	la $a0, 1
	syscall
	
	li $v0, 4
	la $a0, strdiv
	syscall
	
	li $v0, 10
	syscall
