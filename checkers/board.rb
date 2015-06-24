require_relative "pieces.rb"
require 'colorize'
require 'unicode'

class Board
  attr_accessor :grid

  PIECE = "\u25cf"
  KING =  "\u265a"

  def initialize(setup = true)
    @grid = []
    setup_board if setup
  end

  def [](pos)
    row,col = pos
    @grid[row][col]
  end

  def []=(pos,piece)
    row,col = pos
    @grid[row][col] = piece
  end

  def deep_dup
    duped_board = Board.new(false)
    @grid.each do |row|
      duped_row = []
      row.each do |square|
        unless square.nil?
          duped_row << Piece.new(duped_board, square.color,
                                 square.pos.dup, square.king)
        else
          duped_row << nil
        end
      end
      duped_board.grid << duped_row.dup
    end

    duped_board
  end


  def display(cursor)
    #system 'clear'
    puts "   0  1  2  3  4  5  6  7 "
    @grid.each_with_index do |row,idx_x|
      print "#{idx_x} "
      row.each_with_index do |square,idx_y|
        if cursor == [idx_x,idx_y]
          display_cursor(square)
        elsif square.nil?
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

  def display_cursor(square)
    if square.nil?
      print "   ".on_light_yellow
    elsif square.color == :black && square.king == true
      print " #{KING} ".on_light_yellow
    elsif square.color == :black
      print " #{PIECE} ".on_light_yellow
    elsif square.king == true
      print " #{KING} ".colorize(:white).on_light_yellow
    else
      print " #{PIECE} ".colorize(:white).on_light_yellow
    end
  end


  def display_kings(square)
    if square.color == :black
      print " #{KING} ".on_light_red
    else
      print " #{KING} ".colorize(:white).on_light_red
    end
  end

  def display_pieces(square)
    if square.color == :black
      print " #{PIECE} ".on_light_red
    else
      print " #{PIECE} ".colorize(:white).on_light_red
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
    @grid = Array.new(8) { Array.new(8) }
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
