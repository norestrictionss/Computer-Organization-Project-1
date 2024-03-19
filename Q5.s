
.text
.globl main


main:

    
	li $t0, 1
	lb $s0, matrix($zero) # rows
	lb $s1, matrix($t0) 	# columns
	li $s2, 2 # beginning
	mul $s3, $s0, $s1 # element count
	li $s5, 0 # temp val
	li $s6, 0 # island width
	li $s7, 0 # result
	for_loop:
	
		lb $s4, matrix($s2) 
		bne $s4, $t0, if_not_one
		move $a0, $s2
		move $a1, $s7
		jal dfs
		move $s5, $v0
		slt $t1, $s6, $s5
		bne $t1, $zero, if_not_one
		addi $s6, $s5, 1
		if_not_one:
			beq $s2, $s3, exit
			addi $s2, $s2, 1
			j for_loop
	dfs:
		addi $sp, $sp, -12
		sw $ra, 0($sp)
		sb $a0, 4($sp)
		sb $a1, 8($sp)
		sb $zero, matrix($a0)
		subi $t1, $a0, 2
		div $t1, $s1
		mflo $t2 # i
		mul $t3, $t2, $s1
		subi $t4, $a0, $t3 # j
		
		
		
		
		lw $ra, 0($sp)
		lw $a0, 4($sp)
		lw $a1, 8($sp)
		addi $sp, $sp, 12
		jr $ra
		
	exit:
		li $v0, 10
		syscall
			
		

.data
    matrix: .byte 5, 6, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0
	
	
	
	

