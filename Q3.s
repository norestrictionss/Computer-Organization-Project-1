
.text
.globl main


main:

	
        li $v0, 4
        la $a0, inputText
        syscall
        
        li $v0, 8
        la $a0, input
        li $a1, 20
        syscall
        
        li $v0, 5
        syscall
        move $a3, $v0 # Second input
        
        la $t0, input
        jal strlen
        
        la $t5, input
        la $a0, input # our input
        li $a1, 0 # first index of the string
        move $a2, $v1 # last index of the string 
        addi $a3, $a3, -1
       
        addi $t0, $a2, 1
        srl $t0, $t0, 1
        
        jal modify
        li $v0, 4
        la $a0, input
        syscall
        
        li $v0, 10
        syscall
        
 
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
        
strlen:
	lb $t2, 0($t0)
	bne $t2, $zero, loop_on
	addi $v1, $t1, -2
	jr $ra
	loop_on:
	    addi $t0, $t0, 1
	    addi $t1, $t1, 1
	    j strlen
	    
modify:
	addi $sp, $sp, -24
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp) # First index
	sw $a2, 12($sp) # Last index
	sw $a3, 16($sp) # Second input
	sw $t0, 20($sp)
	
	bne $a3, $zero, continue
	
	move $t2, $zero
	jal substring
	
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
	 srl $t3, $t3, 1 # mid 
	 move $a1, $t3 # mid 
	 addi $a1, $a1, 1 # mid + 1
	 move $t2, $zero
	 jal substring
	 lw $a0, 4($sp)
	 lw $ra, 0($sp)
	 addi $a3, $a3, -1
	 srl $t0, $t0, 1
	 la $a0, input
	 add $a0, $a0, $a1
	 jal modify
	 lw $ra, 0($sp)
	 lw $a0, 4($sp)
	 lw $a1, 8($sp)
	 lw $a2, 12($sp)
	 lw $a3, 16($sp)
	 lw $t0, 20($sp)
	 
	 
	 add $t3, $a1, $a2
	 srl $t3, $t3, 1 # mid 
	 move $a2, $t3 # mid 
	 move $t2, $zero
	 addi $a3, $a3, -1
	 srl $t0, $t0, 1
	 la $a0, input
	 add $a0, $a0, $a1
	 jal modify
	 lw $ra, 0($sp)
	 lw $a0, 4($sp)
	 lw $a1, 8($sp)
	 lw $a2, 12($sp)
	 lw $a3, 16($sp)
	 lw $t0, 20($sp)
	 addi $sp, $sp, 24
	 
	 
	 jr $ra
	

.data
    input: .space 81
    inputText: .asciiz "Input:"
    outputText: .asciiz "Output"
	
	
	
	

