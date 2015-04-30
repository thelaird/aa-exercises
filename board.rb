require_relative "pieces.rb"

class Board
  attr_accessor :grid

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
p board.grid[5].all? { |x| x.nil? }
