require 'byebug'
class Pieces
  attr_reader :color
  attr_accessor :pos, :moved

  def initialize(board, color, starting_position, moved = false)
    @board = board
    @color = color
    @pos = starting_position
    @moved = moved
  end

  def dup(dup_board)
    self.class.new(dup_board, color, pos.dup, moved)
  end

  def inspect
    p self.class
    p @pos
  end

  def valid_moves
    moves.select {|move| !@board.move_into_check?(@pos, move) }
  end

end


class SteppingPieces < Pieces

  def step_moves(steps)
    moves = []
    endpoint = @pos.dup

    steps.each do |x, y|
      endpoint[0] += x
      endpoint[1] += y

      if @board.on_board?(endpoint)
        if @board[endpoint].nil? || @board[endpoint].color != self.color
          moves << endpoint
        end
      end

      endpoint = @pos.dup
    end

    moves
  end

end

class SlidingPieces < Pieces
  DIAGONALS = [[1, 1], [-1,-1], [1, -1], [-1, 1]]
  STRAIGHTS = [[1, 0], [0,  1], [-1, 0], [0, -1]]

  def diagonal_moves
    moves = []
    endpoint = @pos.dup

    DIAGONALS.each do |x, y|

      endpoint[0] += x
      endpoint[1] += y

      while @board.on_board?(endpoint) && @board[endpoint].nil?
        moves << endpoint.dup
        endpoint[0] += x
        endpoint[1] += y
      end
      if @board.on_board?(endpoint) && @board[endpoint].color != self.color
        moves << endpoint.dup
      end

      endpoint = @pos.dup
    end

    moves
  end

  def straight_moves
    moves = []
    endpoint = @pos.dup
    STRAIGHTS.each do |x, y|

      endpoint[0] += x
      endpoint[1] += y

      while @board.on_board?(endpoint) && @board[endpoint].nil?
        moves << endpoint.dup
        endpoint[0] += x
        endpoint[1] += y
      end
      if @board.on_board?(endpoint) && @board[endpoint].color != self.color
        moves << endpoint.dup
      end

      endpoint = @pos.dup
    end

    moves
  end

  def mover(x,y)

  end
end





class Rook < SlidingPieces
  def moves
    straight_moves
  end
end

class Bishop < SlidingPieces
  def moves
    diagonal_moves
  end
end

class Queen < SlidingPieces
  def moves
    diagonal_moves + straight_moves
  end
end




class Knight < SteppingPieces
  STEPS = [[-1, 2], [1, 2], [-2, 1], [2, 1],
           [-2,-1], [2,-1], [-1,-2], [1,-2]]

  def moves
    step_moves(STEPS)
  end
end

class King < SteppingPieces
  STEPS = [[1, 0], [-1, 0], [0, 1], [ 0, -1],
           [1, 1] ,[-1,-1], [1,-1], [-1,  1]]

   def moves
     step_moves(STEPS)
   end
end








class Pawn < SteppingPieces

  def pawn_steps
    steps = []

    x = @pos[0]
    y = @pos[1]

    if color == :black
      if moved == false
        steps += [[ 2, 0]] if @board.board[x + 2][y].nil? && @board.board[x + 1][y].nil?
        steps += [[ 1, 0]] if @board.board[x + 1][y].nil?
      else
        steps += [[1, 0]] if @board.board[x + 1][y].nil?
      end

      if !@board.board[x + 1][y + 1].nil? && @board.board[x + 1][y + 1].color != color
        steps += [[1, 1]]
      end

      if !@board.board[x + 1][y - 1].nil? && @board.board[x + 1][y - 1].color != color
        steps += [[1, -1]]
      end
    else
      if moved == false
        steps += [[ -2, 0]] if @board.board[x - 1][y].nil? && @board.board[x - 2][y].nil?
        steps += [[ -1, 0]] if @board.board[x - 1][y].nil?
      else
        steps += [[-1, 0]] if @board.board[x - 1][y].nil?
      end

      if !@board.board[x - 1][y - 1].nil? && @board.board[x - 1][y - 1].color != color
        steps += [[-1, -1]]
      end

      if !@board.board[x - 1][y + 1].nil? && @board.board[x - 1][y + 1].color != color
        steps += [[-1, 1]]
      end
    end
    steps
  end

  def moves
    step_moves(pawn_steps)
  end
end
