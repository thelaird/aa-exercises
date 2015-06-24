
require_relative 'pieces.rb'
require 'byebug'

class ChessBoard
  attr_accessor :board

  BACK_ROW = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

  def initialize(setup = true)
    @board = Array.new(8) { Array.new(8) }
    create_board if setup == true
  end

  def [](pos)
    row, col = pos
     @board[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    @board[row][col] = piece
  end

  def create_board
      rows,color = [0,1], :black

      2.times do
        board[rows.first] = BACK_ROW.each_with_index.map do |piece, idx|
          piece.new(self, color, [rows.first, idx])
        end
        board[rows.last] = (0..7).to_a.map do |el|
          Pawn.new(self, color, [rows.last,el])
        end

        rows, color = [7,6], :white
      end
  end

  def check?(color)
    king_pos = []
    possible_moves = []

    @board.each_with_index do |row, x|
      row.each do |square, y|
        if !square.nil? && square.color != color
          possible_moves += square.moves
        end
        if square.class == King && square.color == color
          king_pos = square.pos
        end
      end
    end

    return true if possible_moves.include?(king_pos)
    false
  end

  def checkmate?(color)
    possible_moves = []
    pieces = @board.flatten.compact.select!{ |piece| piece.color == color }
    pieces.each do |piece|
      piece.moves.each do |move|
        unless move_into_check?(piece.pos,move)
          possible_moves += move
        end
      end
    end
    possible_moves.empty?
  end

  def deep_dup
    duped_board = ChessBoard.new(false)
    duped_array = []

    @board.each do |row|
      duped_row = []
      row.each do |square|
        if square.nil?
          duped_row << square
        else
          duped_row << square.dup(duped_board)
        end
      end
      duped_array << duped_row
    end

    duped_board.board = duped_array
    duped_board
  end

  def move_into_check?(start,endpoint)
    duped_board = self.deep_dup
    duped_board.move!(start, endpoint)
    return true if duped_board.check?(duped_board[endpoint].color)
    false
  end

  def move(start,endpoint)
    if !self[start].valid_moves.include?(endpoint)
      raise "Invalid move"
    else
      move!(start,endpoint)
    end
    self[endpoint].moved = true
  end

  def move!(start,endpoint)
    self[endpoint] = self[start]
    self[start] = nil
    self[endpoint].pos = endpoint
  end

  def occupied?(pos)
    !self[pos].nil?
  end

  def piece_at(pos)
    self[pos].class
  end

  def on_board?(pos)
    row,col = pos
    row.between?(0,7) && col.between?(0,7)
  end

  def stop_piece
  end

  def capture_piece
  end
end

if __FILE__ == $PROGRAM_NAME

  board  = ChessBoard.new
#  queen = Queen.new(board,:white,[2,1])
#  board[[2,1]] = queen
  p board[[6,1]].moved
  board.move([6,1],[5,1])
  p board[[5,1]].moved
  p board[[5,1]].valid_moves



end
