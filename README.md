# Tic-Tac-Toe

## Challenge

To create a terminal interfaced tic-tac-toe game, which the board size is chosen by the user and the winning pattern is not hard coded.

## Install & Run

1. Clone the repository
2. `bundle install`
3. run `ruby bin/tic-tac-toe` to play

## Included Core Features

* Playable tic-tac-toe game against computer.
* Allowing user to choose who becomes `O` or `X`.
* Winner announcement and a choice to play again or quit.
* Variable Grid Size (User can choose how big the board is.)
* Randomly choosing who starts the game first.

## Win Detection Algorithm

Because the grid size of the game is variable, it is not possible to hard code the entire winning results of both computer and the player.

Therefore, we need to keep track of how many `O` or `X` has been placed in each row and column.
I have created 2-dimensional arrays to separate and easily keep track of the moves.

For example, in typical 3 x 3 tic-tac-toe game, the board looks like this.
```
board = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8]
]
```
With the above setup, we can have a score tracker that is the same length as the board, which each element represents the row or column.
> `row_stats = [0, 0, 0]`

> `column_stats = [0, 0, 0]`

Then, with every coordinate that is given by the player, we can take the first index of the coordinate to update our `row_stats` to keep track of the moves.
> player gives the coordinate [0,1]

> update the stats as > `row_stats = [1, 0, 0]` and > `column_stats = [0, 1, 0]`

When the stats are equal to the `board.length`, we know that the row or the column has been fully filled by the player, which he or she would be the winner.

For the diagonal winning detection, there could be only 1 possible outcome for each diagonal and inverse-diagonal.
For diagonal:
With every move, if x-coordinate and y-coordinate value is same, then we increment the diagonal value since diagonal can only be reached same coordinates.
> `diagonal_stats = 0`

> player gives [0,0]

> update diagonal_stats to `diagonal_stats = 1`

When the stats is equal to the `board.length`, we have the winner by the diagonal.

For inverse-diagonal:

With every move, if x-coordinate and y-coordinate's total is equal to `board.length`, then we increment the inverse-diagonal value since inverse-diagonal points are always equal to the board.length.
> `inverse_diagonal_stats = 0`

> player gives [0,2]

> 0 + 2 + 1 = 3

> update diagonal_stats to `diagonal_stats = 1`
