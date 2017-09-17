module TicTacToe
  class Human < Player
    attr_reader :name, :human_horse

    def local_player_info
      { name: 'Human', horse: retrieve_horse }
    end

    def retrieve_horse
      if human_horse
        human_horse
      else
        select_horse
      end
    end

    def select_horse
      puts 'Please choose a play horse: (O or X) '
      @human_horse = gets.chomp.capitalize
      if %w(O X).include? human_horse
        human_horse
      else
        puts "Please select 'O' or 'X' and not something else."
        select_horse
      end
    end

    def ask_coordinates
      puts '-----Your turn!! ------'
      puts ' '
      row = ask_row_coordinate
      column = ask_column_coordinate
      [row, column]
    end

    def ask_row_coordinate
      puts 'ROW: Please enter the position for your row. (row)'
      puts '* Ex) Entering 0 would be the first row, 1 = second row etc..'
      row = user_coordinate
      return check_row_coordinate(row)
    end

    def ask_column_coordinate
      puts 'COLUMN: Please enter the position for your column. (column)'
      puts '* Ex) Entering 0 would be the first column, 1 = second column etc..'
      column = user_coordinate
      return check_column_coordinate(column)
    end

    def user_coordinate
      Integer(gets)
    rescue ArgumentError
      puts 'ERROR: Please enter an integer.'
      user_coordinate
    end

    def check_row_coordinate(row)
      if row >= board.length || row < 0
        puts 'ERROR: Please provide valid coordinates for the board'
        ask_row_coordinate
      else
        row
      end
    end

    def check_column_coordinate(column)
      if column >= board.length || column < 0
        puts 'ERROR: Please provide valid coordinates for the board'
        ask_column_coordinate
      else
        column
      end
    end

    def check_duplicate_location(location)
      element = board.board_info[location[0]][location[1]]
      if element == 'O' || element == 'X'
        puts 'ERROR: Horse is already placed!! Please enter different coordinates'
        new_row = ask_row_coordinate
        new_column = ask_column_coordinate
        check_duplicate_location([new_row, new_column])
      else
        @coordinates = [location[0], location[1]]
      end
    end
  end
end
