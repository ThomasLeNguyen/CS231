.data
arr1: .word 10, 60, 30, 40,150
str: .asciiz "\n"
.text
main:
li $s1, 5 # $s1 indicates there are 5 numbers in the array
la $s2, arr1 # $s2 points to first location of array(index zero) with address arr1
loop: beq $s1, $0, exit # when the loop is done jump to exit
lw $t0, 0($s2) # Take the element out of array and load it to register $t0
li $v0,1 # output the content of one element of array
add $a0,$0,$t0
syscall
li $v0, 4 # go to next line
la $a0, str
syscall
addi $s1, $s1, -1 # update the counter
addi $s2, $s2, 4 # increment $s2 (the array pointer) by 4 to point to the next position
j loop
exit:
li $v0, 10
syscall