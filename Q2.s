.text


# To function the program properly, the following instructions must be obeyed.
# Initially, number of inputs must be entered.
# Then, each input must be entered one-by-one.
# Approach is settling the elements from first array to the second array and finding the least common factor of two numbers. 
# If there exists a least common factor of two numbers, that is settled to the second_elements array. Otherwise, the number itself is settled.
# So, final state of the elements are held in the second _elements array.
main:
	

	addi $t7, $t7, 1
	li $v0, 4
	la $a0, first_string
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0 # Number of integers that array will hold
	
	move $a0, $v0
	move $a1, $zero
	move $a2, $zero
	jal read_inputs
	
	
	lw $a1, elements($t0)
	addi $t0, $t0, 4
	lw $a2, elements($t0)
	
	# addi $a1, $zero, 49
	# addi $a2, $zero, 24
	
	# addi $sp, $sp, -8
	# sw $a1, 0($sp)
	# sw $a2, 4($sp)
	# jal find_gcd
	# lw $a1, 0($sp)
	# lw $a2, 4($sp)
	# addi $sp, $sp, 8
	# move $a3, $v0
	
	# addi $sp, $sp, -8
	# sw $a1, 0($sp)
	# sw $a2, 4($sp)
	# jal find_lcf
	# lw $a1, 0($sp)
	# lw $a2, 4($sp)
	# move $a3, $v0
	
	addi $t4, $t4, 400
	sw $a1, second_elements($t4)
	addi $t3, $t3, 4
	jal iterate_list
	
	move $s0, $zero
	addi $s0, $s0, 400
	
	li $v0, 4
	la $a0, second_string
	syscall
	# Displaying the final second array.
	print_result:
		
		li $v0, 1
		lw $a0, second_elements($s0) # Printing the elements of second_elements array.
		syscall
		
		li $v0, 4
		la $a0, blank
		syscall
		beq $s0, $t4, end_of_program
		addi $s0, $s0, 4
		j print_result

	
	end_of_program:
		li $v0, 10
		syscall

# Function to read the inputs.
read_inputs:
	bne $a0, $a1, continue
	jr $ra
	continue:
		addi $a1, $a1, 1
		li $v0, 5
		syscall
		sw $v0, elements($a2)
		addi $a2, $a2, 4
		j read_inputs
		
# It aims to find the least common factor.
iterate_list:
	addi $sp, $sp, -16
	sw $ra, 0($sp)
	sw $a1, 4($sp) # First number(bigger one)
	sw $a2, 8($sp) # Second number(smaller one)
	

	sw $t4, 12($sp)
	jal scan_second_array
	lw $ra, 0($sp)
	lw $a1, 4($sp) # First number(bigger one)
	lw $a2, 8($sp) # Second number(smaller one)
	lw $t4, 12($sp)
	
	
	
	jal find_gcd
	lw $ra, 0($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
	
	move $a3, $v0 # GCD of two numbers
	move $t1, $a3 # $t1 holds the GCD value of both a1 and a2.
	
	jal find_lcf
	lw $ra, 0($sp)
	# $t4 stamds for the second array's current index
	# $t3 stands for the actual array's current index
	move $a3, $v0 # LCF of two numbers
	
	# In the case numbers are not coprime, operations below occurs.
	beq $t1, $t7, if_not_coprime
	sw $a3, second_elements($t4) # Value achieved by LCF operation is substituted at second_element array.
	move $a1, $a3 # For the next iteration, $a3(lcf) is assigned to a1.
	addi $t3, $t3, 4  
	lw $a2, elements($t3)
	
	addi $t6, $t6, 2 # It is incremented by two at first. Because, it determines the index. To compare this with length of array, I incremented by 2.
	# After comparison, I decreased by 1.
	beq $a0, $t6, end
	addi $t6, $t6, -1 
	beq $t5, $zero, iterate_list
	
	
	j iterate_list
	if_not_coprime:
		addi $t4, $t4, 4
		addi $sp, $sp, -4
		sw $t7, 0($sp) # I have done this because $t7 actually hold 1. So, after completing the operations below, I fetched the $t7 value back from sp.
		lw $t7, elements($t3) # Fetching the element from the actual eleement list
		sw $t7, second_elements($t4) # Then, replace the zero in the second array with the $t7 value.
		lw $t7, 0($sp)
		addi $sp, $sp, 4
		
		# Adjusting the arguments for the next iteration
		lw $a1, second_elements($t4)
		addi $t3, $t3, 4
		lw $a2, elements($t3)
		
		
		addi $t6, $t6, 2
		beq $a0, $t6, end
		addi $t6, $t6, -1
		
		beq $t5, $zero, iterate_list
		
		
		j iterate_list
	end:
	    jal scan_second_array
	    lw $ra, 0($sp)
	    addi $sp, $sp, 16

	    jr $ra

# After settling the elements in second array, each element is traversed back until the beginning of the array.
# Aim is finding the potential least common factors and rearranging the elements again.
scan_second_array:
	
	addi $t4, $t4, -400 # Decreasing the $t4 register to actually achieve the current posiiton in the second array.
	bne $t4, $zero, more_than_two # If current position in the second array is two or more, it will jump.
	addi $t4, $t4, 400 # After the operation, $t4 returns back to it's value.
	jr $ra
	more_than_two:
	addi $t4, $t4, 400 # Value is increased back
	lw $a1, second_elements($t4)
	addi $t4, $t4, -4
	lw $a2, second_elements($t4)
	
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $a1, 4($sp) # First number(bigger one)
	sw $a2, 8($sp) # Second number(smaller one)
	
	jal find_gcd
	lw $ra, 0($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
	
	
	move $a3, $v0
	bne $a3, $t7, go_on # If gcd is not 1, it will jump to go_on
	addi $sp, $sp, 12
	addi $t4, $t4, 4
	jr $ra
	go_on:
		jal find_lcf
		lw $ra, 0($sp)
		addi $sp, $sp, 12
		move $a2, $v0
		addi $t4, $t4, 4 # It was reduced 4 in the previous lines. So, I increased it back by 4.
		sw $zero, second_elements($t4) # Because there exists a lcf, last element is discarded.
		# And the least common factor will be settled to the previous position in the second array.
		addi $t4, $t4, -4
		sw $a2, second_elements($t4)
		sw $t4, 12($sp) # up-to-date $t4 value must be overwritten back to the sp to utilize it in the iterate_list procedure.
		move $a1, $a2 
		sw $a1, 4($sp) # New argument is also put back on the stack.
		j scan_second_array

# Greatest common divisor calculator
find_gcd:
	div $a1, $a2
	mfhi $t0 # Remainder

	beq $t0, $zero, exit
	move $a1, $a2
	move $a2, $t0
	j find_gcd
	exit:
	    move $v0, $a2
            jr $ra

# It finds least common factor depending on the the formula. lcf(a, b) = a*b/gcd(a, b)
find_lcf:
	mul $v0, $a1, $a2
	div $v0, $a3
	mflo $t0
	move $v0, $t0
	jr $ra

.data
	elements: .space 100
	second_elements: .space 100
	first_string: .asciiz "Please enter the number of integers you want to print: "
	second_string: .asciiz "Output: The new array is: "
	blank: .asciiz " "
