require_relative 'player'
require_relative 'board'
require_relative 'game'

module TicTacToe
  class TicTacToe
    def initialize
      board = Board.new
      player = Player.new(board: board)
      Game.new(player: player, board: board).play
    end
  end
end
