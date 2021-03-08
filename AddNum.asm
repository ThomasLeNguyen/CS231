#This program will pass two integers to printnum routine, printnum routine will print the #numbers 
#and pass it to addsub routine. addsub will add the numbers together and pass the result # # to printnum to print it.

.data
str1: .asciiz "\nInput two integer :\n"
str2: .asciiz "the number that you enterd are:\n"
str3: .asciiz "Bye\n"
str4: .asciiz "\n"
str5: .asciiz "\nthe sum of the numbers are:"
.text

main:

li $v0,4 #print str1
la $a0,str1
syscall

li $v0,5 # input for how many number
syscall


add $t5,$0,$v0   # put the number of integer need to inputed to $t5

li $v0,5                  # input for how many number
syscall


add $t6,$0,$v0  # put the number of integer need to inputed to $t6

add $a1,$0,$t5  # Passing to function by $a1
add $a2,$0,$t6  # Passing to function by $a2

jal addsub            # go to getnum rutine

add $t0, $v1, $0


li $v0,1 #print first number $s0
add $a0,$t0,$0
syscall

li $v0, 10
syscall

##################################START OF ###addsub######################################## 
addsub: 
add $t5,$0,$a1 # Passing to function by $a1
add $t6,$0,$a2 # Passing to function by $a2


add $t7, $t5, $t6

add $v1, $t7, $0 # returning the result to main

jr $ra