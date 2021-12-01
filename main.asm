.data
	cardInitialValues: .word 1, 2, 4, 8, 16, 32
	cardVisiblePrompt: .asciiz "Is your number shown on the card? (y for yes, n for no)"
	redoInputMessage: .asciiz "You entered an invalid input, enter again (y/n)"
	playAgainMessage: .asciiz "Do you want to play again? (y for yes, anything else for no)"
	guessMessage: .asciiz "\nYour number is: "
	userInput: .word 0
	repeat: .word 0
	newLine: .asciiz "\n"
	newGame: .asciiz "\n\n----------------------------------------------\n"
	buffer: .space 20
	
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
	
	# $t9 holds the sum
	li $t9, 0

startUX:
	beq $t0, $t1, endUX
	lw $t2, cardInitialValues($t0)	#t2 holds the value of the array at index $t0/4
	
	#Function call to print current card
	move $a1, $t2
	jal printCard
	
	# store input
	li $v0, 54
	la $a0, cardVisiblePrompt
	la $a1, userInput
	la $a2, 2
	syscall
	
	lw $t8, userInput
	move $t7, $a1	#moving status content of $a1 to $t0
	
	bne $t7, $zero, redoInput	#branch on invalid status
	
continueUX:
	beq $t8, 110, skipAdd
	beq $t8, 121, numExist
	
	#neither y/n at this point
	j redoInput
	
	
numExist: #card exist processing
	add $t9, $t9, $t2
skipAdd:
	addi $t0, $t0, 4	#increase to next index(offset)
	j startUX
	
redoInput:	#redoing input when user has entered invalid input
	li $v0, 54
	la $a0, redoInputMessage
	la $a1, userInput
	la $a2, 2
	syscall
	
	lw $t8, userInput
	move $t7, $a1	#moving status content of $a1 to $t0
	
	bne $t7, $zero, redoInput
	j continueUX

endUX:	#end user input loop

	#display the sum
	li $v0, 4
	la $a0, guessMessage
	syscall
	
	li $v0, 1
	la $a0, ($t9)
	syscall
	
	li $v0, 54
	la $a0, playAgainMessage
	la $a1, repeat
	la $a2, 2
	syscall
	
	
	move $t0, $a1	#moving status content of $a1 to $t0
	lw $t1, repeat	#loading repeat input message to $t1
	
	bne $t0, $zero, exitGame	#check invalid status
	
	bne $t1, 121, exitGame
	
	li $v0, 4
	la $a0, newGame
	syscall
	
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
	
