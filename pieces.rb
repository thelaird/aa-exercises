require 'byebug'

class Piece

  attr_accessor :pos, :king
  attr_reader :color, :grid

  ALL_MOVES = [[1,1],[1,-1],[-1,-1],[-1,1]]

  def initialize(board, color, pos, king = false)
    @grid = board
    @color = color
    @pos = pos
    @king = king
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

  def perform_jump(endpoint)
    # debugger
    jumped = [(endpoint[0] + @pos[0])/2,(endpoint[1] + @pos[1])/2]
    if !grid[jumped].nil? && grid[jumped].color != self.color
      if move_diff.any? { |x,y| [@pos[0] + x, @pos[1] + y] == jumped }
        if grid[endpoint].nil?
          grid[@pos] = nil
          grid[jumped] = nil
          grid[endpoint] = self
          @pos = endpoint
        else
          false
        end
      end
    end
  end

  def perform_moves(moves)
  end

  def perform_moves!(moves)
    moved = true
    if moves.length == 2
      moved = self.perform_slide(moves.last)
      if moved == false
        moved = self.perform_jump(moves.last)
      end
    else
      moves.drop(1).each_with_index do |move,idx|
        grid[moves[idx]].perform_jump(move)
      end
    end
  end

  def perform_slide(endpoint)
    if grid[endpoint].nil?
      if move_diff.any? { |x,y| [@pos[0] + x, @pos[1] + y] == endpoint }
        grid[self.pos] = nil
        grid[endpoint] = self
        @pos = endpoint
      else
        false
      end
    end
  end

  def valid_move_seq?(moves)
    duped_board = @grid.deep_dup
    duped_board[moves.first].perform_moves!(moves)
  end

end
