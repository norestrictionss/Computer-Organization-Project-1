.text
.globl main


main:
	li $t0, 1
	lb $s0, matrix($zero) # rows
	lb $s1, matrix($t0) 	# columns
	li $s2, 2 # beginning
	mul $s3, $s0, $s1 # element count
	addi $s3, $s3, 2
	li $s5, 0 # temp val
	li $s6, 0 # island width
	
	
	move $a0, $s2 # Beginning
	move $a1, $s3 # Element Count
	move $a3, $s1 # Column count
	jal print_island
	move $a0, $zero
	move $a1, $zero
	move $a3, $zero
	move $t1, $zero
	move $a2, $zero
	
	for_loop:
		lb $s4, matrix($s2) 
		bne $s4, $t0, if_not_one # As long as current element is not 1, jump to the end.
		move $a0, $s2 # Assignment of the index as an argument
		move $a1, $zero 
		jal dfs
		move $s5, $v1
		slt $t1, $s6, $s5
		bne $t1, $t0, if_not_one
		addi $s6, $s5, 1
		if_not_one:
			addi $s2, $s2, 1
			beq $s2, $s3, exit
			j for_loop
	exit:
		li $v0, 4
		la $a0, islandText
		syscall
		li $v0, 1
		move $a0, $s6
		syscall
		li $v0, 10
		syscall
	dfs:
		addi $sp, $sp, -16
		sw $ra, 0($sp)
		sb $a0, 4($sp) # beginning
		sb $zero, matrix($a0)
		addi $t7, $a0, -2
		div $t7, $s1

		mflo $t2 # i
		mfhi $t4 # j
		
		# It stores current i and j to the stack
		sb $t2, 8($sp) 
		sb $t4, 12($sp)
		
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
			addi $sp, $sp, 16
			lb $a0, 4($sp)
			lw $ra, 0($sp)
			lb $t2, 8($sp)
			lb $t4, 12($sp)
			
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
				addi $sp, $sp, 16
				lb $a0, 4($sp)
				lw $ra, 0($sp)
				lb $t2, 8($sp)
				lb $t4, 12($sp)
		third_if:
					slt $t3, $t4, $t0 # j<1
					beq $t3, $t0, fourth_if
					addi $t5, $a0, -1
					lb $t5, matrix($t5) # grid[i][j-1]
					beq $t5, $zero, fourth_if
					addi $a0, $a0, -1 #j-=1
					addi $a1, $a1, 1 # result+1
					jal dfs
					addi $sp, $sp, 16
					lb $a0, 4($sp)
					lw $ra, 0($sp)
					lb $t2, 8($sp)
					lb $t4, 12($sp)
				fourth_if:
						slt $t3, $t2, $t0 # i<1
						beq $t3, $t0, end_of_recursive
						sub $t5, $a0, $s1
						lb $t5, matrix($t5)
						beq $t5, $zero, end_of_recursive
						sub $a0, $a0, $s1 # i-1
						addi $a1, $a1, 1
						jal dfs
						addi $sp, $sp, 16
						lb $a0, 4($sp)
						lw $ra, 0($sp)
						lb $t2, 8($sp)
						lb $t4, 12($sp)
						end_of_recursive:
							move $v1, $a1
							jr $ra
			
	print_island:
		addi $a0, $a0, -1
		div $t1, $a0, $a3
		mfhi $t1
		addi $a0, $a0, 1
		
		li $v0, 1
		move $a2, $a0
		lb $a0, matrix($a0)
		syscall
		move $a0, $a2
		
		move $a2, $a0
		li $v0, 4
		la $a0, blank
		syscall
		move $a0, $a2
			
		bne $t1, $zero, jump_underline
		move $a2, $a0
		li $v0, 4
		la $a0, underline
		syscall
		move $a0, $a2
		jump_underline:
		
			
			addi $a0, $a0, 1
			bne $a0, $a1, print_island
			jr $ra

.data
   matrix: .byte 5, 6, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0
   islandText: .asciiz "Number of the 1s on the largest island is: "
   underline: .asciiz "\n"
   blank: .asciiz " "
   .text
	
	

