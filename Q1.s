	.data
msg1: .asciiz "Please enter the coefficient a:"
msg2: .asciiz "Please enter the coefficient b:"
msg3: .asciiz "Please enter first number of the sequence(x0): "
msg4: .asciiz "Please enter second number of the sequence(x1): "
msg5: .asciiz "Enter the number you want to calculate (it must be greater than 1): "
msg6: .asciiz "th element of the sequence is "
	.text
	.globl main

# Both $s0 and $s1 defines the a and b
# $s2 and $s3 defines x0 and x1



main:

	

	# Getting a as an input
	li $v0, 4
	la $a0, msg1 # Print the first message
	syscall
	li $v0, 5
	syscall
	addi $s0, $v0, 0 # Assigning a to temporary register
	
	# Getting b as an input
	li $v0, 4
	la $a0, msg2 # Print the second message
	syscall
	li $v0, 5
	syscall
	addi $s1, $v0, 0 # Assigning b to temporary register
	
	
	# Getting x0 as an input
	li $v0, 4
	la $a0, msg3 # Print the second message
	syscall
	li $v0, 5
	syscall
	addi $s2, $v0, 0 # Assigning x0 to temporary register
	
	
	# Getting x1 as an input
	li $v0, 4
	la $a0, msg4 # Print the second message
	syscall
	li $v0, 5
	syscall
	addi $s3, $v0, 0 # Assigning x1 to temporary register
	
	li $t7, 1 
	
	get_n:
		# Getting n as an input
		li $v0, 4
		la $a0, msg5 # Print the second message
		syscall
		li $v0, 5
		syscall
	
	slt $t2, $v0, $t7
	bne $t2, $zero, get_n
	
	move $t5, $v0
	addi $s4, $v0, -2 # Assigning target number to be calculated to temporary register
	addi $t5, $t5, -1
	beq $t5, $zero, if_one
	
	
	
	
	calculate:
		beq $s5, $s4, exit
		mul $t0, $s0, $s3
		mul $t1, $s1, $s2
		add $t0, $t0, $t1
		addi $t0, $t0, -2
		
		addi $s2, $s3, 0
		addi $s3, $t0, 0
		
		addi $s5, $s5, 1
		j calculate
	
	if_one:
		move $s3, $s2
	
	exit:
		addi $s4, $s4, 2
		li $v0, 1
		move $a0, $s4 # Print the second message
		syscall
		
		li $v0, 4
		la $a0, msg6 # Print the second message
		syscall
		
		li $v0, 1
		move $a0, $s3 # Print the second message
		syscall
		
		li $v0, 10
		syscall
	
	
	
	
		
	
	
	
