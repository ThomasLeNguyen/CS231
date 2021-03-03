.data
arr1:	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

strdiv:	.asciiz "\n================================================================================\n"
strdes: .asciiz "Program Description: 			Finds the max of the array\n"
straut: .asciiz "Author: 				Thomas Thuan Le Nguyen\n"
strdat: .asciiz "Creation Date:				02/28/2021"

strtms: .asciiz "How many elements: "
strmax: .asciiz "The largest element is: "
strerr: .asciiz "Too many elements!!!\n"

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

# set first index to 0
li $s0, 0

la $s2, arr1 # $s2 points to first location of array(index zero) with address arr1
loop: beq $s0, $s1, next # when the loop is done jump to exit

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

# set first index to 0
li $s0, 0

la $s2, arr1 # $s2 points to first location of array(index zero) with address arr1
lw $t1, 0($s2)

max: beq $s0, $s1, end # when the loop is done jump to exit
lw $t0, 0($s2) # Take the element out of array and load it to register $t0
bge $t1, $t0, false
add $t1, $0, $t0

false:

addi $s0, $s0, 1 # update the counter
addi $s2, $s2, 4 # increment $s2 (the array pointer) by 4 to point to the next position
j max

end:

li $v0, 4
la $a0, strmax
syscall

li $v0, 1
add $a0, $t1, $0
syscall

#program end
  li $v0, 10
  syscall
