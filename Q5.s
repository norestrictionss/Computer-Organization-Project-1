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
	for_loop:
		lb $s4, matrix($s2) 
		bne $s4, $t0, if_not_one
		move $a0, $s2
		move $a1, $zero
		jal dfs
		move $s5, $v1
		slt $t1, $s6, $s5
		bne $t1, $t0, if_not_one
		addi $s6, $s5, 1
		if_not_one:
			beq $s2, $s3, exit
			addi $s2, $s2, 1
		j for_loop
	exit:
		li $v0, 10
		syscall
	dfs:
		addi $sp, $sp, -8
		sw $ra, 0($sp)
		sb $a0, 4($sp) # beginning
		sb $zero, matrix($a0)
		addi $t7, $a0, -2
		div $t7, $s1

		
		mflo $t2 # i
		mfhi $t4 # j
		
		first_if:
			addi $t6, $s0, -1 # grid.length-1
			slt $t3, $t2, $t6 # i<grid.length-1
			beq $t3, $zero, second_if # if i>=grid.length-1
			add $t5, $a0, $s1 # $t5 = beginning+column count
			lb $t5, matrix($t5) 
			beq $t5, $zero, second_if # grid[i+1][j] == 1
			add $a0, $a0, $s1  # i += 1
			addi $a1, $a1, 1 # result+1
			jal dfs
			lb $a0, 4($sp)
			lw $ra, 0($sp)
			addi $sp, $sp, 8
		second_if:
				addi $t6, $s1, -1 # grid[0].length-1
				slt $t3, $t4, $t6 # j<grid[0].length-1
				beq $t3, $zero, third_if
				addi $t5, $a0, 1 
				lb $t5, matrix($t5) # grid[i][j+1]
				beq $t5, $zero, third_if
				addi $a0, $a0, 1 # j+=1
				addi $a1, $a1, 1 # result + 1
				jal dfs
				lb $a0, 4($sp)
				lw $ra, 0($sp)
				addi $sp, $sp, 8
			third_if:
					slt $t3, $t4, $t0 # j<1
					bne $t3, $zero, fourth_if
					addi $t5, $a0, -1
					lb $t5, matrix($t5) # grid[i][j-1]
					beq $t5, $zero, fourth_if
					addi $a0, $a0, -1 #j-=1
					addi $a1, $a1, 1 # result+1
					jal dfs
					lb $a0, 4($sp)
					lw $ra, 0($sp)
					addi $sp, $sp, 8
				fourth_if:
						slt $t3, $t2, $t0 # i<1
						bne $t3, $zero, end_of_recursive
						sub $t5, $a0, $s1
						lb $t5, matrix($t5)
						beq $t5, $zero, end_of_recursive
						sub $a0, $a0, $s1 # i-1
						addi $a1, $a1, 1
						jal dfs
						lb $a0, 4($sp)
						lw $ra, 0($sp)
						addi $sp, $sp, 8
						end_of_recursive:
							move $v1, $a1
							jr $ra
			
		

.data
   matrix: .byte 5, 6, 0, 0, 0, 1, 1, 1 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0
	
	
	
	

