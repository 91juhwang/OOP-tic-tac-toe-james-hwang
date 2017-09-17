module TicTacToe
  class Player
    attr_accessor :board, :scores, :already_played, :coordinates

    def initialize(args)
      @board = args[:board]
      @scores = {
        row_stats: Array.new(board.length, 0),
        column_stats: Array.new(board.length, 0),
        diag_stats: 0,
        inverse_diag_stats: 0
      }
      @coordinates = []
      post_initialize(args)
    end

    def player_info
      {}.merge(local_player_info)
    end

    def post_initialize(args)
      nil
    end

    def update_scores(coordinates)
      scores[:row_stats][coordinates[0]] += 1
      scores[:column_stats][coordinates[1]] += 1
      scores[:diag_stats] += 1 if coordinates[0] == coordinates[1]
      scores[:inverse_diag_stats] += 1 if coordinates.inject(&:+) + 1 == board.length
    end
  end
end
