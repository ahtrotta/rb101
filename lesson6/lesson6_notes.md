# ** LESSON 6 **

=============================================================================

## **Introduction**

- this lesson contains more complicated programs than previous lessons
strategy:
1. break down the problem into smaller pieces, don't be afraid to start over
2. map out the flow of the program in a flowchart, using sub-processes to encapsulate well-defined components of the problem
3. when you're ready to tackle a component or sub-process, write out the pseudo-code for that sub-process only. it will most likely translate to a method (or methods), so devise clear inputs and outputs
4. don't copy and paste, write every line of code yourself
5. do the assignments in sequence
6. don't be afraid to watch the walk-through videos

=============================================================================

## **Tic Tac Toe Problem Decomposition**

- write out a description of the game:
```
Tic Tac Toe is a 2 player game played on a 3x3 board. Each player takes a turn and
marks a square on the board. First player to reach 3 squares in a row, including diagonals,
wins. If all 9 squares are marked and no player has 3 squares in a row, then the game is a tie.
```
- outline the sequence more:
```
1. Display the initial empty 3x3 board.
2. Ask the user to mark a square.
3. Computer marks a square.
4. Display the updated board state.
5. If winner, display winner.
6. If board is full, display tie.
7. If neither winner nor board is full, go to #2
8. Play again?
9. If yes, go to #1
10. Good bye!
```
- there are two main loops, one at step 7 and one at step 9
- notice that this description is still higher-level pseudo-code, not formal pseudo-code

