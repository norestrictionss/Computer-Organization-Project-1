.text


# To function the program properly, the following instructions must be obeyed.
# Initially, number of inputs must be entered.
# Then, each input must be entered one-by-one.

main:
	
	addi $t7, $t7, 1
	li $v0, 4
	la $a0, first_string
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0 # Number of integers
	
	move $a0, $v0
	move $a1, $zero
	move $a2, $zero
	jal read_inputs
	
	
	addi $a1, $zero, 49
	addi $a2, $zero, 24
	
	addi $sp, $sp, -8
	sw $a1, 0($sp)
	sw $a2, 4($sp)
	jal find_gcd
	lw $a1, 0($sp)
	lw $a2, 4($sp)
	addi $sp, $sp, 8
	move $a3, $v0
	
	addi $sp, $sp, -8
	sw $a1, 0($sp)
	sw $a2, 4($sp)
	jal find_lcf
	lw $a1, 0($sp)
	lw $a2, 4($sp)
	move $a3, $v0
	
	
	
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
	addi $sp, $sp, -8
	sw $a1, 0($sp) # First number(bigger one)
	sw $a2, 4($sp) # Second number(smaller one)
	jal find_gcd
	lw $a1, 0($sp)
	lw $a2, 4($sp)
	addi $sp, $sp, 8
	move $a2, $v0 # GCD of two numbers
	jal find_lcf
	move $a3, $v0 # LCF of two numbers
	
	beq $a2, $t7, if_not_coprime
	sw $a3, second_elements($t0)
	addi $t0, $t0, 8
	j jump_end 
	if_not_coprime:
		lw $t4, elements($t0)
		sw $t4, second_elements($t0)
	        addi $t0, $t0, 4
	        lw $t4, elements($t0)
		sw $t4, second_elements($t0)
	     
	     	jump_end:
			addi $t2, $a0, -2
			beq $a0, $a1, end
			addi $a1, $a1, 1
			j iterate_list
	end:
	    jr $ra

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
	mul $a1, $a1, $a2
	div $a1, $a3
	mflo $t0
	move $v0, $t0
	jr $ra

.data
	elements: .space 100
	first_string: .asciiz "Please enter the number of integers you want to print: "
	second_string: .asciiz "Output: The new array is: "
	second_elements: .space 100
