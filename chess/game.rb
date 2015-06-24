require_relative 'board.rb'
require 'unicode'
require 'colorize'

class Chess

  WHITE_SYMBOLS = {
                    King => "\u2654",
                    Queen => "\u2655",
                    Rook => "\u2656",
                    Bishop => "\u2657",
                    Knight => "\u2658",
                    Pawn => "\u2659"
                  }
  BLACK_SYMBOLS = {
                    King => "\u265a",
                    Queen => "\u265b",
                    Rook => "\u265c",
                    Bishop => "\u265d",
                    Knight => "\u265e",
                    Pawn => "\u265f"
                  }

  def initialize()
    @board = ChessBoard.new
    @turn = :white
    @cursor = [4,3]
  end

  def play
    until over?
      system 'clear'
      display
      puts "#{@turn.capitalize}'s turn"
      begin
      begin
      puts "Select a piece to move: "
      player_input
      puts "I am HERHERH"
      start = @cursor
      p start
      color_check(start)
    rescue
      puts "Invalid selection"
      retry
    end
      puts "Where do you want to move that piece? "
      player_input
      endpoint = @cursor
      p endpoint
      @board.move(start,endpoint)
    rescue
      puts "Invalid move"
      retry
    end
    change_turn
    end

    puts "#{change_turn.capitalize} wins!!"

    display
  end

  def change_turn
    @turn == :white ? @turn = :black : @turn = :white
  end

  def color_check(pos)
    unless @board[pos].color == @turn
      raise "Invalid selection"
    end
  end



  def player_input
    selected = false
    until selected
      system 'clear'
      display
      here = $stdin.getc.chr
      case here
      when "8"
        @cursor[0] -= 1 unless @cursor[0] == 0
      when "5"
        @cursor[0] += 1 unless @cursor[0] == 7
      when "4"
        @cursor[1] -= 1 unless @cursor[1] == 0
      when "6"
        @cursor[1] += 1 unless @cursor[1] == 7
      when "0"
        selected = true
        puts "Here"
     end
   end
  end

  def over?
    @board.checkmate?(:white) || @board.checkmate?(:black)
  end


  def display



    puts "     0  1  2  3  4  5  6  7 "
    puts "    ------------------------"
    @board.board.each_with_index do |row,x|
      print " #{x} |"
      row.each_with_index do |square, y|
        if square.nil?
          [x, y] == @cursor ? (print "   ".on_light_red) : (print "   ")
        else
          white_piece = " " + WHITE_SYMBOLS[square.class] + " "
          black_piece = " " + BLACK_SYMBOLS[square.class] + " "
          if square.color == :white
            [x, y] == @cursor ? (print white_piece.on_light_red) : (print white_piece)
          else
            [x, y] == @cursor ? (print black_piece.on_light_red) : (print black_piece)
          end
        end
      end
      puts ''
    end
    puts "    ------------------------"
    puts "White in check: #{@board.check?(:white)}"
    puts "Black in check: #{@board.check?(:black)}"
  end
end

game = Chess.new
game.play
