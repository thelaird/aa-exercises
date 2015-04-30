require_relative "pieces.rb"
require 'colorize'
require 'unicode'

class Board
  attr_accessor :grid

  WHITE_PIECE = "\u2687"
  WHITE_KING =  "\u2654"
  BLACK_PIECE = "\u2689"
  BLACK_KING =  "\u265a"

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    setup_board
  end

  def [](pos)
    row,col = pos
    @grid[row][col]
  end

  def []=(pos,piece)
    row,col = pos
    @grid[row][col] = piece
  end

  def display
    system 'clear'
    puts "   0  1  2  3  4  5  6  7 "
    @grid.each_with_index do |row,idx_x|
      print "#{idx_x} "
      row.each_with_index do |square,idx_y|
        if square.nil?
          display_squares(square,idx_x,idx_y)
        elsif square.king
          display_kings(square)
        else
          display_pieces(square)
        end
      end
      puts
    end
    puts ''
  end

  def display_kings(square)
    if square.color == :black
      print " #{BLACK_KING} ".on_light_red
    else
      print " #{WHITE_KING} ".on_light_red
    end
  end

  def display_pieces(square)
    if square.color == :black
      print " #{BLACK_PIECE} ".on_light_red
    else
      print " #{WHITE_PIECE} ".on_light_red
    end
  end

  def display_squares(square,x,y)
    if x.even? && y.odd? || x.odd? && y.even?
      print "   ".on_light_blue
    else
      print "   ".on_light_red
    end
  end

  def setup_board
    color = :white
    @grid.each_with_index do |row, idx_x|
      color = :black if idx_x == 4
      next if idx_x.between?(3,4)
      row.each_with_index do |square, idx_y|
        if idx_x.even? && idx_y.even?
          self[[idx_x,idx_y]] = Piece.new(self, color, [idx_x, idx_y])
        elsif idx_x.odd? && idx_y.odd?
          self[[idx_x,idx_y]] = Piece.new(self, color, [idx_x, idx_y])
        end
      end
    end
  end
end

board = Board.new
board[[2,2]].perform_slide([3,3])
board.display
