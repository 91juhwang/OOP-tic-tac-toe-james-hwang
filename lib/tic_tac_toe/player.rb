module TicTacToe
  class Player
    attr_accessor :board

    def initialize(args)
      @player = retrieve_player_name
      @board = args[:board]
    end

    def retrieve_player_name
      puts "Please provide a player's name"
      player_name = gets.chomp
      select_horse(player_name)
    end

    def select_horse(player_name)
      puts 'Please choose a play horse: (O or X) '
      player_selection = gets.chomp.capitalize
      assign_horses(player_name, player_selection)
    end

    def assign_horses(player_name, player_selection)
      horses = %w(O X)
      if horses.include? player_selection
        horses.delete(player_selection)
        @computer = { player_name: 'Computer', horse: horses.join('') }
        @player = { player_name: player_name, horse: player_selection }
      else
        puts "Please select 'O' or 'X' and not something else."
        select_horse(player_name)
      end
    end

    def player
      @player
    end

    def computer
      @computer
    end

    def player_horse
      @player[:horse]
    end

    def computer_horse
      @computer[:horse]
    end

    def computer_random_coordinates
      random_row = board.board_info.sample
      computer_random_play([random_x(random_row), random_y(random_row)])
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

    def random_x(random_row)
      board.board_info.index(random_row)
    end

    def random_y(random_row)
      random_row.index(random_row[random_index])
    end
  end
end
