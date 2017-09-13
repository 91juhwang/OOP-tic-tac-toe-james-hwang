module TicTacToe
  class Game
    attr_accessor :board, :player, :coordinates

    def initialize(args)
      # intialize the game
      @player_turn = true
      @board = args[:board]
      @player = args[:player]
      board.create_board
      # player scores
      @player_row_stats = Array.new(board.length, 0)
      @player_column_stats = Array.new(board.length, 0)
      @player_diag_stats = 0
      @player_inverse_diag_stats = 0
      # computer scores
      @computer_row_stats = Array.new(board.length, 0)
      @computer_column_stats = Array.new(board.length, 0)
      @computer_diag_stats = 0
      @computer_inverse_diag_stats = 0
      @coordinates = []
    end

    # core game plays
    def play
      unless game_has_ended?(coordinates)
        board.print_board
        @coordinates = check_player_turn
        user_coordinates = check_duplicate_location(coordinates)
        if @player_turn
          board.update_board(user_coordinates, player, @player_turn)
          update_player_winning_board(user_coordinates)
        else
          board.update_board(coordinates, player, @player_turn)
          update_computer_winning_board(coordinates)
        end
        @player_turn = !@player_turn
        play
      end
      play_again?
    end

    def check_player_turn
      if player_turn?
        ask_coordinates
      else
        computer_play
      end
    end

    def player_turn?
      @player_turn
    end

    def computer_play
      puts ' ---- Computer Turn -----'
      player.computer_random_coordinates
    end

    # keep track and update winning moves
    def update_player_winning_board(coordinates)
      @player_row_stats[coordinates[0]] += 1
      @player_column_stats[coordinates[1]] += 1
      @player_diag_stats += 1 if coordinates[0] == coordinates[1]
      @player_inverse_diag_stats += 1 if coordinates.inject(&:+) + 1 == board.length
    end

    def update_computer_winning_board(coordinates)
      @computer_row_stats[coordinates[0]] += 1
      @computer_column_stats[coordinates[1]] += 1
      @computer_diag_stats += 1 if coordinates[0] == coordinates[1]
      @computer_inverse_diag_stats += 1 if coordinates.inject(&:+) + 1 == board.length
    end

    # checking duplicate coordinates and asking user to input correct values
    # Would move below codes to new LocationTracker class if I had more time
    def check_duplicate_location(location)
      x = location[0]
      y = location[1]
      element = board.board_info[x][y]
      if @player_turn && (element == 'O' || element == 'X')
        puts 'ERROR: Horse already placed there!! Please enter different coordinates'
        new_x = ask_x_coordinate
        new_y = ask_y_coordinate
        check_duplicate_location([new_x, new_y])
      elsif @player_turn == false
        @coordinates
      else
        @coordinates = [location[0], location[1]]
      end
    end

    def ask_coordinates
      puts '-----Your turn!! ------'
      puts ' '
      x = ask_x_coordinate
      y = ask_y_coordinate
      [x, y]
    end

    def ask_x_coordinate
      puts 'Row: Please enter the x-position for your play. (row)'
      puts '* Ex) Entering 0 would be the first row, 1 = second row etc..'
      x = user_coordinate
      return check_x_coordinate(x)
    end

    def ask_y_coordinate
      puts 'Column: Please enter the y-position for your play. (column)'
      puts '* Ex) Entering 0 would be the first column, 1 = second column etc..'
      y = user_coordinate
      return check_y_coordinate(y)
    end

    def user_coordinate
      Integer(gets)
    rescue ArgumentError
      puts 'ERROR: Please enter an integer.'
      user_coordinate
    end

    def check_x_coordinate(x)
      if x >= board.length || x < 0
        puts 'ERROR: Please provide valid coordinates for the board'
        ask_x_coordinate
      else
        x
      end
    end

    def check_y_coordinate(y)
      if y >= board.length || y < 0
        puts 'ERROR: Please provide valid coordinates for the board'
        ask_y_coordinate
      else
        y
      end
    end

    # checking if the game ended by deteceting the winner
    def game_has_ended?(coordinates)
      return false if coordinates.length != 2
      return display_winner('player') if @player_row_stats[coordinates[0]] == board.length
      return display_winner('player') if @player_column_stats[coordinates[1]] == board.length
      return display_winner('player') if @player_diag_stats == board.length
      return display_winner('player') if @player_inverse_diag_stats == board.length

      return display_winner('computer') if @computer_row_stats[coordinates[0]] == board.length
      return display_winner('computer') if @computer_column_stats[coordinates[1]] == board.length
      return display_winner('computer') if @computer_diag_stats == board.length
      return display_winner('computer') if @computer_inverse_diag_stats == board.length
      return display_winner('draw') if !board.board_info.flatten.include? '.'
      false
    end

    # Win & ending methods
    def display_winner(who_wins)
      board.print_board
      if who_wins == 'draw'
        puts "----DRAW GAME---"
      elsif who_wins == 'player'
        puts '--------WINNER--------'
        puts "#{player.player[:player_name]} - #{player.player[:horse]} has won the game!"
      else
        puts '--------WINNER--------'
        puts "#{player.computer[:player_name]} - '#{player.computer[:horse]}' has won the game!"
      end
      true
    end

    def play_again?
      puts 'Would you like to play the game again? (y/n)'
      answer = gets.chomp
      if answer == 'y'
        TicTacToe.new
      elsif answer == 'n'
        return game_ending
      else
        puts 'Please provide y or n as an answer.'
        play_again?
      end
    end

    def game_ending
      puts 'Thank you! Goodbye~ :)'
      exit
    end
  end
end
