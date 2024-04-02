
.text
.globl main


main:

	
        li $v0, 4
        la $a0, inputText
        syscall
        
        # Reading the string input
        li $v0, 8
        la $a0, input
        li $a1, 20
        syscall
        
        # Reading the second input(number that determines how many times that string will be shuffled)
        li $v0, 5
        syscall
        move $a3, $v0 # Second input
        
        la $t0, input
        jal strlen # It will return the length of the string.
        
        la $t5, input
        la $a0, input # our input
        li $a1, 0 # first index of the string
        move $a2, $v1 # last index of the string 
        addi $a3, $a3, -1
       
        addi $t0, $a2, 1
        srl $t0, $t0, 1 # Middle point of the string
        
        # Invoking the recursive function
        jal modify
        li $v0, 4
        la $a0, input
        syscall
        
        li $v0, 10
        syscall
        
 # That function swaps the substring's elements according to the second input
substring:
	
	add $t1, $a0, $t0
	
	lb $t3, 0($t1)
	lb $t4, 0($a0)
	sb $t4, 0($t1)
	sb $t3, 0($a0)
	
	addi $t2, $t2, 1
	beq $t2, $t0, exit
	
	addi $a0, $a0, 1
	j substring
	exit:
	   jr $ra

# That function 
strlen:
	lb $t2, 0($t0)
	bne $t2, $zero, loop_on
	addi $v1, $t1, -2
	jr $ra
	loop_on:
	    addi $t0, $t0, 1
	    addi $t1, $t1, 1
	    j strlen
	    
# It modifies the string according to the rule given in the instruction PDF.
modify:
	addi $sp, $sp, -24
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp) # First index
	sw $a2, 12($sp) # Last index
	sw $a3, 16($sp) # Second input
	sw $t0, 20($sp) # Middle point of the substring
	
	bne $a3, $zero, continue
	
	move $t2, $zero
	jal substring
	# Loading the values back through the stack pointers
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	lw $t0, 20($sp)
	addi $sp, $sp, 24
	jr $ra
	
	continue:
	
	 add $t3, $a1, $a2
	 srl $t3, $t3, 1 # Calculation of middle
	 move $a1, $t3 # Assignment of middle to the $a1 register
	 addi $a1, $a1, 1 # mid + 1
	 move $t2, $zero 
	 jal substring
	 lw $a0, 4($sp) # Returning the previous value of $a0
	 lw $ra, 0($sp) # Returning the previosu value of $ra 
	 addi $a3, $a3, -1 # It reduces the second input until 0
	 srl $t0, $t0, 1 # It divides the length of the substring by two. Swapping follows by exchanging the substring by the power of two.
	 la $a0, input 
	 add $a0, $a0, $a1 # Calculation of the beginning of the new substring
	 jal modify
	 # After each recursion, previous values are reloaded back through stack pointer.
	 lw $ra, 0($sp)
	 lw $a0, 4($sp)
	 lw $a1, 8($sp)
	 lw $a2, 12($sp)
	 lw $a3, 16($sp)
	 lw $t0, 20($sp)
	 
	 
	 add $t3, $a1, $a2
	 srl $t3, $t3, 1 # middle point calculation again
	 move $a2, $t3 # Assignment of the middle index as a ceil value.
	 move $t2, $zero
	 addi $a3, $a3, -1
	 srl $t0, $t0, 1 # It divides the length of the substring by two. Swapping follows by exchanging the substring by the power of two.
	 la $a0, input # 
	 add $a0, $a0, $a1 # It locates the address pointer to the beginning of the substring for the next recursion.
	 jal modify
	 lw $ra, 0($sp)
	 lw $a0, 4($sp)
	 lw $a1, 8($sp)
	 lw $a2, 12($sp)
	 lw $a3, 16($sp)
	 lw $t0, 20($sp)
	 # Finally, all values are popped out of the stack.
	 addi $sp, $sp, 24
	 
	 
	 jr $ra
	

.data
    input: .space 128
    inputText: .asciiz "Input:"
    outputText: .asciiz "Output"
	
	
	
	

