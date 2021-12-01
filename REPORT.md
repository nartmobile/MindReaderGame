# Project Report

## Program Description
The program shuffles 6 cards to display to the user. Each card contains certain numbers from 1-63 based on the algorithm discussed below, under 'Algorithms and Techniques'. After a card is displayed to the user, the user indicates whether their number was on the card of not. The steps are repeated until all 6 cards are displayed.  
Based on the user's answers to all 6 cards, the algorithm discussed under 'Algorithms and Techniques' calculates the secretly chosen number and is displayed to the user.  
The program asks the user if they would like to play again, looping back or exiting based on the answer. The program also features error handling, determining if the value inputted by the user is invalid. An error message will be displayed upon invalid input.

## Challenges
The biggest challenge that we faced when working on this project was figuring out how to all work on this project simultaneously. There were many parts of the project that depended on each other so we were unsure on which agile methodology would work best. We wanted to be able to do parts of the program ourselves without the need on waiting on other team members to finish their part in order to proceed. After coming up with the pseudocode, we decided that a Kanban agile management would work best. Based on the pseudocode, there were certain parts of the program that did not entire depend on previous parts in order to be written such as randomizing cards, generating individual cards, and calculating the secret number.  
Another challenge that we faced was mixing up registers used. Since each team member was working on their own part without much knowledge of how the other parts are being written, it was easy for more than one team member to use the same register, furthur corrupting the data that was needed in said register. To establish a consistent workflow to help with this issue, we decided to use github. Through github, we were able to send our changes often without changing the code of other team members and at the same time, notify which registers we were working with.

## What I Learned (Individual)

## Algorithms and Techniques
- Randomizing the cards  
To begin, the beginning values of all 6 cards are stored in an array, [1, 2, 4, 8, 16, 32] to be able to represent the cards individually. The program will be able traverse through the array and print out the cards using the beginning value.  
Card(array) randomizing was done using the **Fisher-Yates Shuffle**. The algorithm is used to generate a random permutation of a finite sequence. In this case, the algorithm shuffles the card array so when we traverse the array to print the cards, it is essentially random.  
The algorithm begins at the last index of the array. The program uses the syscall 42 command to generate a random number between 0 and a given bound(the index we are at). The values at the index and the random number index are swapped. We repeat down the array, decreasing the index by one and stopping at index 0. 
<br/>

- Displaying the Cards  
The printCard function requires the starting value of the desired card. Through a loop, iterating through numbers 1 to 63 (inclusive), the function will print out the corresponding numbers with that starting value.  
For the loop, a counter starting at 1 is used. The AND operation is applied to the counter and starting value. The result of that operation is compared to the starting value, and if they are equal, the counter and a space is printed. Otherwise, printing is skipped. The counter is then incremented, and the program returns to the condition at the start of the loop. The program exits the function when the counter reaches 64, returning to where the function was called.  
The reason why the AND operation is used is because for each card, when written in binary, each number on that card contains the starting value when written out in binary. For example, 5 is 101 in binary. 1 is 001 in binary. Both 5 and 1 contain a 1 in the rightmost bit (2^0). Therefore, if a user were to guess 5, we know that the leftmost bit should be 1, meaning 5 goes with the card starting with 1. The AND operation allows us to determine if a number contains the starting value, since by applying the AND operation on the number and the starting value, the result should be either the starting value (if the number contains it) or 0 (if the number doesn't contain it).
<br/>

- Determining the User's Number  
{Discuss how we're able to determine the user's number based on their answer's to each card(y/n)} - Andrew  

- Input Validation (General)  
We used syscall 54 (InputDialogString) to display a message to the user with a text box for input.  
When the program prompts the user if the card displayed contains their number, the program only accepts lowercase 'y' or lowercase 'n' as input. Anything other action (i.e., selecting cancel, entering invalid input) causes the prompt to display again. This is achieved by checking the status register ($a1). If the input is 1 character, then $a1 is assigned 0. The program branches to displaying the card again if $a1 is not equal to 0. The program also branches based on the ASCII value of that character, if $a1 is indeed 0. If it is equal to the ASCII value of lowercase 'y', then the program branches to adding the first number of the card and printing the next card. If it is equal to the ASCII value of lowercase 'n', then the program branches to printing the next card only. Otherwise, the program branches to displaying the prompt again.  
When the program prompts the user if they would like to play again or not, it only accepts lowercase 'y' to restart the game. Any other action causes the program to terminate. Checking the status register ($a1), if the input is not 1 character, the program branches to exiting the game. In addition, if the character is not equal to the ASCII value of lowercase 'y', then the program branches to exiting the game. Otherwise, the program branches to the start of the game.

## Team Member Contributions (Individual)

## Suggestions (Optional)

