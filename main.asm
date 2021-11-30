.data
	cardInitialValues: .word 1, 2, 4, 8, 16, 32
	playAgainMessage: .asciiz "Do you want to play again? (y for yes, anything else for no)"
	repeat: .word 0
	newLine: .asciiz "\n"
	
.text

beginGame:
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
		
	li $t0, 0	#t0 is the index(offset) for the CardArray
	li $t1, 24	#t1 is the limit of the last offset before reaching out of bounds
	
startUX:
	beq $t0, $t1, endUX
	lw $t2, cardInitialValues($t0)	#t2 holds the value of the array at index $t0/4
	
	#Function call to print current card
	move $a1, $t2
	jal printCard
	
	#ANDREW'S PART
	#ask for user input to indicate if their number is on the card or not
	#if it is, add the starting card value($t2) to a sum
	#once all 6 cards are done(loop is done), display the sum
	
	addi $t0, $t0, 4	#increase to next index(offset)
	j startUX
	
	
endUX:	#end user input loop

	#display the sum

		
	#asking to play again
	#li $v0, 4
	#la $a0, playAgainMessage
	#syscall
	
	li $v0, 54
	la $a0, playAgainMessage
	la $a1, repeat
	la $a2, 2
	syscall
	
	
	move $t0, $a1	#moving input content of $a1 to $t0
	lw $t1, repeat	#loading repeat input message to $t1
	
	bne $t0, $zero, exitGame
	
	
	bne $t1, 121, exitGame
	
	j beginGame


	# start of printCard function
printCard:
	# assuming $a1 holds the value of startVal of the card being printed
	# using $a1, $a2, $a3, $t7 for the time being (decide later on registers to use)
	# $a1 = startVal, $a2 = counter, $a3 = 64, $t7 = startVal && counter
	li $a2, 1
	li $a3, 64
	
	# printing out new line (separate from previous output)
	li $v0, 4
	la $a0, newLine
	syscall
	
printCardLoop:
	beq $a2, $a3, exitPrintCard 	# exit when all 63 numbers (branch at 64) have been looped through
	and $t7, $a1, $a2		# $t7 = startVal && counter
	bne $t7, $a1, printCardInc	# skip printing number if (startVal && counter) != startVal
	
	# print number (counter) and a space
	li $v0, 1
	add $a0, $a2, $zero
	syscall
	
	li $v0, 11
	li $a0, 32
	syscall

printCardInc:
	addi $a2, $a2, 1		# increment counter by 1
	j printCardLoop			# go back to start of printCard loop (condition)
	
exitPrintCard:
	# by default, putting jr instruction (using jal to call printCard)
	jr $ra
	# end of printCard function
	
exitGame:
	li $v0, 10
	syscall
	
