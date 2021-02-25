.data
arr1: .word 0, 0, 0, 0,0
str: .asciiz "\n"
.text
main:
li $s1, 5 # $s1 indicates there are 5 numbers in the array
la $s2, arr1 # $s2 points to first location of array(index zero) with address arr1
loop: beq $s1, $0, exit # when the loop is done jump to exit
li $v0,5 # Get input from user
syscall
sw $v0, 0($s2) # Store the number into the array
addi $s1, $s1, -1 # update the counter
addi $s2, $s2, 4 # increment $s2 (the array pointer) by 4 to point to the next position
j loop
exit:
li $v0, 10
syscall