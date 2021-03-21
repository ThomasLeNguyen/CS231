	.data
# store 1.8 = 9/5
num: .float 1.8

# header
strdiv:	.asciiz "================================================================================\n"
strdes: .asciiz "Program Description: 			Converts Celsius to Fahrenheit\n"
straut: .asciiz "Author: 				Thomas Thuan Le Nguyen\n"
strdat: .asciiz "Creation Date:				03/17/2021"

# program text
strask: .asciiz "Please input a temperature in Celsius\n=> "
strans: .asciiz "The temperature in Fahrenheit is: =>\n"

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

  	# ask for Celsius text
  	la $a0, strask
  	syscall

  	# get user input
  	li $v0, 5
  	syscall
  	add $s0, $v0, $0

	# parameters
	add $a1, $s0, $0
	# CelsiusToFahrenheit subroutine
	jal CelsiusToFahrenheit
	# puts the returned value into $f1
	add.s $f1, $f1, $f0
	
	# print out Fahrenheit text
	li $v0, 4
	la $a0, strans
	syscall
	
	# prints out the Fahrenheit answer
	li $v0, 2
	mov.s $f12, $f1
	syscall

# everything is done running
Done:
	# -- program is finished running --
	li $v0, 10
	syscall
	
########################### CelsiusToFahrenheit subroutine ###########################
CelsiusToFahrenheit:
	# taking in the parameter
	add $t1, $a1, $0
	
	# prints out 1.8
	# li $v0, 2
	# l.s $f12, num
	# syscall
	
	l.s $f2, num
	
	# converts user input (integer) to float
	mtc1 $t1, $f1
	cvt.s.w $f1, $f1
	
	# prints out user input as float
	# li $v0, 2
	# mov.s $f12, $f1
	# syscall
	
	# user input * 1.8
	mul.s $f3, $f1, $f2
	
	# converts 32 to 32.0
	li $t2, 32
	mtc1 $t2, $f4
	cvt.s.w $f4, $f4
	# prints out 32.0
	# li $v0, 2
	# mov.s $f12, $f4
	# syscall
	
	add.s $f3, $f3, $f4
	# li $v0, 2
	# mov.s $f12, $f3
	# syscall
	
	add.s $f1, $f3, $f0

	# jumps back to jal
	jr $ra
