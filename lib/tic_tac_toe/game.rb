module TicTacToe
  class Game
    attr_accessor :board, :human, :computer, :turn

    def initialize
      @board = Board.new
      board.create_board
      @human = Human.new(board: board)
      @computer = Computer.new(board: board, other_horse: human.player_info[:horse])
      @turn = [human.player_info, computer.player_info].sample
    end

    def play
      board.print_board
      coordinates = retrieve_player_move
      update_player_move(coordinates)
      play unless game_has_ended?(coordinates)
      play_again?
    end

    def retrieve_player_move
      if turn == human.player_info
        human.check_duplicate_location(human.ask_coordinates)
      else
        computer.play
      end
    end

    def update_player_move(coordinates)
      if turn == human.player_info
        update_player_stats(human, coordinates)
        @turn = computer.player_info
      else
        update_player_stats(computer, coordinates)
        @turn = human.player_info
      end
    end

    def update_player_stats(player, coordinates)
      board.update_board(coordinates, player)
      player.update_scores(coordinates)
    end

    # checking if the game ended by deteceting the winner
    def game_has_ended?(coordinates)
      return false if coordinates.length != 2
      return display_winner(human) if human_win_scenarios(coordinates)
      return display_winner(computer) if computer_win_scenarios(coordinates)
      return display_winner('draw') unless board.board_info.flatten.include? '.'
      false
    end

    def human_win_scenarios(coordinates)
      return true if human.scores[:row_stats][coordinates[0]] == board.length
      return true if human.scores[:column_stats][coordinates[1]] == board.length
      return true if human.scores[:diag_stats] == board.length
      return true if human.scores[:inverse_diag_stats] == board.length
    end

    def computer_win_scenarios(coordinates)
      return true if computer.scores[:row_stats][coordinates[0]] == board.length
      return true if computer.scores[:column_stats][coordinates[1]] == board.length
      return true if computer.scores[:diag_stats] == board.length
      return true if computer.scores[:inverse_diag_stats] == board.length
    end

    # Win & ending methods
    def display_winner(player)
      board.print_board
      if player == 'draw'
        puts '----DRAW GAME---'
      else
        puts '--------WINNER--------'
        puts "#{player.player_info[:name]} - '#{player.player_info[:horse]}' has won the game!"
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
