require_relative 'player'
require_relative 'board'
require_relative 'game'
require_relative 'human'
require_relative 'computer'

module TicTacToe
  class TicTacToe
    def initialize
      Game.new.play
    end
  end
end
