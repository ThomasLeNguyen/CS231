	.data

# arrays
pceArr:	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
cpnArr:	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

# header
strdiv:	.asciiz "================================================================================\n"
strdes: .asciiz "Program Description: 			Grocery store to calculate the total charge for customers\n"
straut: .asciiz "Author: 				Thomas Thuan Le Nguyen\n"
strdat: .asciiz "Creation Date:				03/14/2021"

# number of items
strit1: .asciiz "Please enter the number of item you are purchasing:\n"
striiv: .asciiz "Invalid number of items!!!\nPlease enter number of items you are purchasing:\n"

# price of items
strpie: .asciiz "Please enter the price of item "
strpng: .asciiz "Price is negative, try again!!!\n"

# number of coupons
strcpn: .asciiz "Please enter the number of coupons that you want to use.\n"
strciv: .asciiz "Invalid number of coupons!!! Please enter the number of coupons that you want to use.\n"

# amount of coupon
strpcn: .asciiz "Please enter the amount of coupon "
strpna: .asciiz "This coupon is not acceptable\n"

# done
strtcg: .asciiz "Your total charge is: $"
strtys: .asciiz "\nThank you for shopping with us.\n"

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

  	# ask item count 1
  	la $a0, strit1
  	syscall

  	# get user input
  	li $v0, 5
  	syscall
  	add $s0, $v0, $0

# checks the item count 1
CheckItemCount1:
	# if items count is greater than 0 go to CheckItemCount2
	bgt $s0, 0, CheckItemCount2
		# items count is less than 0 go to ItemCountInvalid
		j ItemCountInvalid

# checks the item count 2
CheckItemCount2:
	# if items is less than 0 go to ItemCountValid
	ble $s0, 20, ItemCountValid

# if items count is greater than 20 or less than 0
ItemCountInvalid:
	# prints out error
	li $v0, 4
	la $a0, striiv
	syscall

	# get user input
	li $v0, 5
	syscall
	add $s0, $v0, $0

	# jumps back to CheckItemCount1 to recheck value
	j CheckItemCount1

# if items count is less than 20 and greater than 0
ItemCountValid:
	# parameters
	add $a1, $s0, $0
	# FillPriceArray subroutine
	jal FillPriceArray
	# puts the returned value into $s1
	add $s1, $v1, $0
	
	# ask coupon count
	li $v0, 4
	la $a0, strcpn
	syscall
	
	# get user input
	li $v0, 5
	syscall
	add $s0, $v0, $0

	# checks the coupon count
	CheckCouponCount:
		# if coupons count is not equal to the items count
		beq $s0, $a1, CouponCountValid
			# coupons count is not equal to items count
			j CouponCountInvalid

	# if coupons count is not equal to the items count
	CouponCountInvalid:
		# prints out error
		li $v0, 4
		la $a0, strciv
		syscall

		# get user input
		li $v0, 5
		syscall
		add $s0, $v0, $0

		# jumps back to CheckCouponCount to recheck value
		j CheckCouponCount

	# coupons count is not equal to the items count
	CouponCountValid:
		# parameters
		add $a2, $s0, $0
		# FillCouponArray subroutine
		jal FillCouponArray
		# puts the returned value into $s2
		add $s2, $v1, $0
		
		# Your total charge is: $
		li $v0, 4
		la $a0, strtcg
		syscall
		
		# calculates the total charge
		sub $s1, $s1, $s2
		li $v0, 1
		add $a0, $s1, $0
		syscall
		
		# Thank you for shopping with us.
		li $v0, 4
		la $a0, strtys
		syscall

# everything is done running
Done:
	# -- program is finished running --
	li $v0, 10
	syscall

########################### FillPriceArray subroutine ###########################
FillPriceArray:
	# taking in the parameter
	add $t1, $a1, $0
	
	# ================================================================================
	li $v0, 4
	la $a0, strdiv
	syscall
	
	# gets the price total
	li $t2, 0
	
	# $t8 points to the first location of array with address pceArr
	la $t8, pceArr
	
	# index $t0 starts at 0
	li $t0, 0
	
	# PriceLoop goes through $t1 many times starting at $t0
	PriceLoop:
		beq $t0, $t1, PriceDone
			# Please enter the amount of coupon
			li $v0, 4
			la $a0, strpie
			syscall
			
			# $t0 + 1 // index + 1
			li $v0, 1
			add $a0, $t0, 1
			syscall
			
			# :
			li $v0, 4
			la $a0, strcln
			syscall
			
			# get user input
  			li $v0, 5
  			syscall
  			add $t3, $v0, $0
			
			# checks to see if price is appropriate
			bgt $t3, 0, PriceAppropriate
				# jump to PriceInAppropriate
				j PriceInappropriate
			
			# if price is negative or is 0
			PriceInappropriate:
				# Price is negative, try again!!!
				li $v0, 4
				la $a0, strpng
				syscall
				
				# jump to PriceLoop
				j PriceLoop
				
			# if price is positive than 0
			PriceAppropriate:
				# adds the user input to the price total
				add $t2, $t2, $t3
			
				# adds price to the pceArr
				sw $v0, 0($t8)
				addi $t8, $t8, 4
			
				# $t0 = $t0 + 1 // $t0++
				addi $t0, $t0, 1
		
			# jump to PriceLoop
			j PriceLoop
	# PriceLoop is done
	PriceDone:
	
	# ================================================================================
	li $v0, 4
	la $a0, strdiv
	syscall
	
	# prints out the price total
	# li $v0, 1
	# add $a0, $t2, $0
	# syscall

	# returns $v1 which is equal to the price total
	add $v1, $t2, $0

	# jumps back to jal
	jr $ra
	
########################### FillCouponArray subroutine ###########################
FillCouponArray:
	# taking in the parameter
	add $t1, $a2, $0

	# ================================================================================
	li $v0, 4
	la $a0, strdiv
	syscall
	
	# gets the coupon total
	li $t2, 0
	
	# $t8 points to the first location of array with address pceArr
	la $t8, pceArr
	
	# $t9 points to the first location of array with address cpnArr
	la $t9, cpnArr
	
	# index $t0 starts at 0
	li $t0, 0
	
	# CouponLoop goes through $t1 many times starting at $t0
	CouponLoop:
		beq $t0, $t1, CouponDone
			# Please enter the amount of coupon
			li $v0, 4
			la $a0, strpcn
			syscall
			
			# $t0 + 1 // index + 1
			li $v0, 1
			add $a0, $t0, 1
			syscall
			
			# :
			li $v0, 4
			la $a0, strcln
			syscall
			
			# get user input
  			li $v0, 5
  			syscall
  			add $t3, $v0, $0
  			
  			# $t0 = $t0 + 1 // $t0++
			addi $t0, $t0, 1
			
			# takes our the element from pceArr
			lw $t4, 0($t8)
			addi $t8, $t8, 4
			# prints out element
			# li $v0, 1
			# add $a0, $t4, $0
			# syscall
			
			# checks to see if coupon is greater than item price
			bgt $t4, $t3, CouponAppropriate
				# jump to CouponInAppropriate
				j CouponInappropriate
				
			# checks to see if coupon is greater than 10
			bgt $t3, 10, CouponAppropriate
				# jump to CouponInAppropriate
				j CouponInappropriate
			
			# if coupon is greater than 10 or exceeds the item price
			CouponInappropriate:
				# This coupon is not acceptable
				li $v0, 4
				la $a0, strpna
				syscall
				
				# adds 0 to the cpnArr
				sw $0, 0($t9)
				addi $t9, $t9, 4
				
				j CouponLoop
				
			# if coupon is positive than 0
			CouponAppropriate:
				# adds the user input to the coupon total
				add $t2, $t2, $t3
			
				# adds coupon to the cpnArr
				sw $v0, 0($t9)
				addi $t9, $t9, 4
		
			# jump to CouponLoop
			j CouponLoop
	
	# CouponLoop is done
	CouponDone:
	
	# ================================================================================
	li $v0, 4
	la $a0, strdiv
	syscall
	
	# prints out the coupon total
	# li $v0, 1
	# add $a0, $t2, $0
	# syscall

	# returns $v1 which is equal to the coupon total
	add $v1, $t2, $0

	# jumps back to jal
	jr $ra
