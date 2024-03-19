
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
	exit:
		li $v0, 10
		syscall
	dfs:
		addi $sp, $sp, -12
		sw $ra, 0($sp)
		sb $a0, 4($sp)
		sb $a1, 8($sp)
		sb $zero, matrix($a0)
		addi $t1, $a0, -1
		div $t1, $s1
		
		mflo $t2 # i
		mfhi $t4 # j
		
		first_if:
			addi $t6, $s0, -1
			slt $t3, $t2, $t6
			bne $t3, $zero, first_else
			add $t5, $a0, $s1
			lb $t5, matrix($t5)
			bne $t5, $t0, first_else
			add $a0, $a0, $s1
			addi $a1, $s7, 1
			jal dfs
			lb $a0, 4($sp)
			lb $a1, 8($sp)
		first_else:
			second_if:
				addi $t6, $s1, -1
				slt $t3, $t4, $t6
				bne $t3, $zero, third_else
				addi $t5, $a0, 1
				lb $t5, matrix($t5)
				bne $t5, $t0, third_else
				addi $a0, $a0, 1
				addi $a1, $s7, 1
				jal dfs
				lb $a0, 4($sp)
				lb $a1, 8($sp)
			second_else:
				third_if:
					slt $t3, $t4, $t0
					beq $t3, $zero, third_else
					addi $t5, $a0, -1
					lb $t5, matrix($t5)
					bne $t5, $t0, third_else
					addi $a0, $a0, -1
					addi $a1, $s7, 1
					jal dfs
					lb $a0, 4($sp)
					lb $a1, 8($sp)
				third_else:
					fourth_if:
						slt $t3, $t2, $t0
						beq $t3, $zero, end_of_recursive
						sub $t5, $a0, $s1
						lb $t5, matrix($t5)
						bne $t5, $t0, end_of_recursive
						sub $a0, $a0, $s1
						addi $a1, $s7, 1
						jal dfs
						lb $a0, 4($sp)
						lb $a1, 8($sp)
		
		end_of_recursive:
			lb $v0, $a1
			lw $ra, 0($sp)
			lw $a0, 4($sp)
			lw $a1, 8($sp)
			addi $sp, $sp, 12
			jr $ra
			
		

.data
    matrix: .byte 5, 6, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0
	
	
	
	

