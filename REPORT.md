# Project Report

## Program Description
&nbsp;&nbsp;&nbsp;&nbsp;The program shuffles 6 cards to display to the user. Each card contains certain numbers from 1-63 based on the algorithm discussed below, under 'Algorithms and Techniques'. After a card is displayed to the user, the user indicates whether their number was on the card of not. The steps are repeated until all 6 cards are displayed.  
&nbsp;&nbsp;&nbsp;&nbsp;Based on the user's answers to all 6 cards, the algorithm discussed under 'Algorithms and Techniques' calculates the secretly chosen number and is displayed to the user.  
&nbsp;&nbsp;&nbsp;&nbsp;The program asks the user if they would like to play again, looping back or exiting based on the answer. The program also features error handling, determining if the value inputted by the user is invalid. An error message will be displayed upon invalid input.

## Challenges

## What I Learned (Individual)

## Algorithms and Techniques
- Randomizing the cards  
&nbsp;&nbsp;&nbsp;&nbsp;To begin, the beginning values of all 6 cards are stored in an array, [1, 2, 4, 8, 16, 32] to be able to represent the cards individually. The program will be able traverse through the array and print out the cards using the beginning value.  
&nbsp;&nbsp;&nbsp;&nbsp;Card(array) randomizing was done using the **Fisher-Yates Shuffle**. The algorithm is used to generate a random permutation of a finite sequence. In this case, the algorithm shuffles the card array so when we traverse the array to print the cards, it is essentially random.  
&nbsp;&nbsp;&nbsp;&nbsp;The algorithm begins at the last index of the array. The program uses the syscall 42 command to generate a random number between 0 and a given bound(the index we are at). The values at the index and the random number index are swapped. We repeat down the array, decreasing the index by one and stopping at index 0. 
<br/>

- Displaying the Cards  
{Discuss how the printCard function works} - Brian
&nbsp;&nbsp;&nbsp;&nbsp;The printCard function requires the starting value of the desired card. Through a loop, iterating through numbers 1 to 63 (inclusive), the function will print out the corresponding numbers with that starting value.
&nbsp;&nbsp;&nbsp;&nbsp;For the loop, a counter starting at 1 is used. The AND operation is applied to the counter and starting value. The result of that operation is compared to the starting value, and if they are equal, the counter and a space is printed. Otherwise, printing is skipped. The counter is then incremented, and the program returns to the condition at the start of the loop. The program exits the function when the counter reaches 64, returning to where the function was called.
&nbsp;&nbsp;&nbsp;&nbsp;The reason why the AND operation is used is because for each card, when written in binary, each number on that card contains the starting value when written out in binary. For example, 5 is 101 in binary. 1 is 001 in binary. Both 5 and 1 contain a 1 in the rightmost bit (2^0). Therefore, if a user were to guess 5, we know that the leftmost bit should be 1, meaning 5 goes with the card starting with 1. The AND operation allows us to determine if a number contains the starting value, since by applying the AND operation on the number and the starting value, the result should be either the starting value (if the number contains it) or 0 (if the number doesn't contain it).
<br/>

- Determining the User's Number  
{Discuss how were able to determine the user's number based on their answer's to each card(y/n)} - Andrew  

## Team Member Contributions (Individual)

## Suggestions (Optional)

