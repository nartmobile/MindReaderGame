.data
	cardInitialValues: .word 1, 2, 4, 8, 16, 32
	
.text

	#Randomizing array
	
	li $t0, 5
	li $t1, 0
	
RandomizeArray:
	beq $t1, $t0, exitRandomizeLoop
	move $a1, $t0  			#$a1 is max bound
    	li $v0, 42  			#generates random number.
    	syscall
    	
    	beq $a0, $t0, skipSwap
    	li $t5, 4
    	mul $t3, $t0, $t5		#$t3 is the array offset of counter variable
    	mul $t4, $a0, $t5 		#$t4 is the array offset of random variable
    	lw $t2, cardInitialValues($t3)	#$t2: value of counter index
    	lw $t6, cardInitialValues($t4)	#$t6: value of random index
    	
    	#swap
    	sw $t2, cardInitialValues($t4)
    	sw $t6, cardInitialValues($t3)
    	
skipSwap:
	subi $t0, $t0, 1
    	j RandomizeArray
	
	
	
exitRandomizeLoop:
		
	#Print randomized array, only for debugging
	li $t0, 0
	li $t1, 24
	
PrintArray:
	beq $t0, $t1, exitLoop
	lw $t2, cardInitialValues($t0)
	
	# Printing out the number
    	li $v0, 1
    	move $a0, $t2
    	syscall
    	
    	# print space
	li $a0, 32
	li $v0, 11
	syscall
	
	addi $t0, $t0, 4
	j PrintArray
	
	
exitLoop:
		
	#Looping through array to print cards
	
		#print cards function call
		
		
		
	#Print cards function
