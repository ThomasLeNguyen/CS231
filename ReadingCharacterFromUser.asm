# This program reads 10 character from user and utilizes loop to copy each character one by one to an array. 

.data		#start of the data

space:	.asciiz	"\n"
enter:	.byte	'-','-','-','-','-','-','-','-','-','-'
output: .byte   '-','-','-','-','-','-','-','-','-','-' 


.text		#start of the code

main:
	
	la	$s1,output
	li 	$t0,10
	
	li 	$v0,8
	la 	$a0, enter
	li 	$a1,10
	syscall

	li 	$v0,4
	la 	$a0, space
	syscall	
	
	
#-----------------------	output the string that user enters
	la	$a0,enter
	li 	$v0,4
	syscall
	
	
	
	la $s2,enter
	#--------------------------
	li 	$v0,4
	la 	$a0, space
	syscall	
	
	

loop: beq $t0,$0,print 
	lb 	$t1,0($s2)
	sb 	$t1,0($s1)
	li 	$t1,0
	addi 	$s2, $s2,1
	addi 	$s1,$s1,1
	sub 	$t0,$t0,1
	j 	loop

	


print:	li 	$v0,4
	la 	$a0, space
	syscall	
	
	li 	$v0,4
	la 	$a0,output
	syscall

	
	
exit:	li 	$v0,10
	syscall
