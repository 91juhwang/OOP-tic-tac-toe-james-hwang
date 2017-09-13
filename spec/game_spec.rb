require_relative '../lib/tic_tac_toe/game'
require_relative '../lib/tic_tac_toe/board'
require_relative '../lib/tic_tac_toe/player'
require 'stringio'

RSpec.describe TicTacToe::Game do
  describe '#play' do
    # before do
    #   @coordinates = []
    #   expect(TicTacToe::Player.new(board).player_name)
    # end

    # let(:player) { TicTacToe::Player.new(board) }
    # let(:board) { TicTacToe::Board.new }
    # let(:game) { TicTacToe::Game.new(board: board, player: player) }
    context 'when #check_player_turn is invoked' do

      it 'should check and get turn information and coordinates' do
        expect(game.check_player_turn).to be_an_instance_of(Array)
      end
    end
  end
end
