require_relative 'board.rb'
require 'io/console'

class Game
  attr_reader :board, :cursor, :move

  def initialize
    @board = Board.new
    @cursor = [0,0]
    @move = []
  end

  def complete_move
    # if (move.first[0] - move.last[0]).abs == 1
    #   board[move.first].perform_slide(move.last)
    # else
    #   board[move.first].perform_jump(move.last)
    # end
  end

  def play
    while true
    @move = []
      until move.last == "q"
        user_input
      end
      # complete_move
      @move.pop
      board[move.first].perform_moves!(@move)
      p move.last
      p board[move.last]
      board[move.last].maybe_promote
    end
  end


  def user_input
    board.display(cursor)
    input = $stdin.getch
    case input
    when "w"
      cursor[0] -= 1 unless cursor[0] == 0
    when "a"
      cursor[1] -= 1 unless cursor[1] == 0
    when "s"
      cursor[0] += 1 unless cursor[0] == 7
    when "d"
      cursor[1] += 1 unless cursor[1] == 7
    when "q"
      move << "q"
    when "\r"
      move << cursor.dup
    end
  end

end

game = Game.new
game.play
