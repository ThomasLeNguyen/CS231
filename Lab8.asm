	.data
arr1:	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

strdiv:	.asciiz "\n================================================================================\n"
strdes: .asciiz "Program Description: 			Finds the median of the array\n"
straut: .asciiz "Author: 				Thomas Thuan Le Nguyen\n"
strdat: .asciiz "Creation Date:				02/28/2021"

strtms: .asciiz "How many numbers you like to enter: "
strmed: .asciiz "The median is: "
stretr: .asciiz "Enter number "
strerr: .asciiz "Error array can't have more than 10 elements, try again!!\n"

strcol: .asciiz ": "
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
  	la $a0, strtms
  	syscall

  	# user's input
  	li $v0, 5
  	syscall
  	add $s1, $0, $v0

check:
	bgt $s1, 0, secondCondition
	
	j fail
	
secondCondition:
	
        ble $s1, 10, works
        
fail:	# invalid number
    	li $v0, 4
    	la $a0, strerr
    	syscall

    	# ask
   	la $a0, strtms
    	syscall

    	# user's input
    	li $v0, 5
    	syscall
    	add $s1, $0, $v0

   	j check

works:
	add $s1, $0, $v0 # $s1 indicates there are N numbers in the array
	
	li $v0, 4
 	la $a0, strdiv
  	syscall
	
	# set first index to 0
	li $s0, 0
	
	la $s2, arr1 # $s2 points to first location of array(index zero) with address arr1
loop: beq $s0, $s1, next # when the loop is done jump to exit
	li $v0, 4
	la $a0, stretr
	syscall
	
	li $v0, 1
	add $a0, $s0, 1
	syscall
	
	li $v0, 4
	la $a0, strcol
	syscall

	li $v0, 5 # Get input from user
	syscall
	
	sw $v0, 0($s2) # Store the number into the array
	addi $s0, $s0, 1 # update the counter
	addi $s2, $s2, 4 # increment $s2 (the array pointer) by 4 to point to the next position
	j loop

next:

	# finds the middle index
	li $t2, 2
	div $s1, $t2
	mfhi $t3
	mflo $t4

	li $v0, 4
 	la $a0, strdiv
  	syscall
  	
  	li $v0, 4
	la $a0, strmed
	syscall
  	
  	# set first index to 0
	li $s0, 0
	
	la $s2, arr1 # $s2 points to first location of array(index zero) with address arr1
	
	# gets the proper index
	li $t6, 4
	mult $t4, $t6
	
	mflo $t4
	add $s2, $s2, $t4

done:	
	beq $t3, 0, even # if even number of elements
	
odd:
	lw $t0, 0($s2) # Take the element out of array and load it to register $t0
	li $v0, 1 # output the content of one element of array
	add $a0, $0, $t0 # gets data to print out
	syscall
	
	j end
  	
even:
	lw $t0, 0($s2) # Take the element out of array and load it to register $t0
	lw $t1, -4($s2) # Take the element out of array and load it to register $t1
	li $v0, 1 # output the content of one element of array
	add $t6, $t0, $t1 # adds them together
	
	div $t6, $t2 # divides number by 2
	mfhi $t3 # get hi
	mflo $t4 # get lo
	
	add $a0, $0, $t4 # gets lo to print out
	syscall
	
	j end

end:
	li $v0, 4
 	la $a0, strdiv
  	syscall

	#program end
  	li $v0, 10
  	syscall
