module TicTacToe
  class Computer < Player
    attr_reader :computer_horse

    def post_initialize(args)
      @computer_horse = assign_computer_horse(args[:other_horse])
    end

    def local_player_info
      { name: 'Computer', horse: computer_horse }
    end

    def play
      puts ' ---- Computer Turn -----'
      computer_random_coordinates
    end

    def assign_computer_horse(other_horse)
      horses = %(O X)
      horses.delete(other_horse).strip if horses.include? other_horse
    end

    def computer_random_coordinates
      random_row = board.board_info.sample
      computer_random_play([random_y(random_row), random_x(random_row)])
    end

    def computer_random_play(locations)
      location = board.board_info[locations[0]][locations[1]]
      if location == 'X' || location == 'O'
        computer_random_coordinates
      else
        locations
      end
    end

    private

    def random_index
      Random.new.rand(board.length)
    end

    def random_y(random_row)
      board.board_info.index(random_row)
    end

    def random_x(random_row)
      random_row.index(random_row[random_index])
    end
  end
end
