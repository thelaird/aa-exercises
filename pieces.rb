class Piece
  attr_accessor :pos, :king
  attr_reader :color

  ALL_MOVES = [[1,1],[1,-1],[-1,-1],[-1,1]]

  def initialize(board, color, pos)
    @grid = board.grid
    @color = color
    @pos = pos
    @king = false
  end

  def inspect
    print " [#{color},#{pos}] "
  end


  def maybe_promote
    @king = true if self.pos.first == 0 || self.pos.first == 7
  end

  def move_diff
    if self.king
      ALL_MOVES
    elsif self.color == :white
      ALL_MOVES.take(2)
    else
      ALL_MOVES.drop(2)
    end
  end

  def perform_slide(endpoint)
    if move_diff.any? { |x,y| [pos[0] + x, pos[1] + y] == endpoint }
      @pos = endpoint
    else
      false
    end
  end

  def perform_jump(endpoint)
  end
end
