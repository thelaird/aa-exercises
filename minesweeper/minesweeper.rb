require 'yaml'

class Tile
  attr_reader :position, :flagged, :board
  attr_accessor :bomb, :revealed

  NEIGHBORS = [[1, 1], [-1,-1], [1, -1], [-1, 1],
               [0, 1],  [0,-1], [1,  0], [-1, 0]]


  def initialize(current_board, position, bomb)
    @board = current_board
    @position = position
    @bomb = bomb
    @flagged = false
    @revealed = false
  end

  def flag
    @flagged = !@flagged
  end

  def reveal
    queue = [self]
    until queue.empty?
      test_case = queue.shift
      test_case.bomb || test_case.flagged ? next : test_case.revealed = true
      queue += test_case.neighbors.reject {|neighbor| neighbor.revealed ||
                                                      neighbor.bomb ||
                                                      test_case.neighbor_bomb_count != 0 }
    end
  end

  def neighbors
    tile_neighbors = NEIGHBORS
      .map{ |idx| [idx.first + position.first, idx.last + position.last]}
      .select{ |idx1, idx2| (0..Board::BOARD_SIZE-1).include?(idx1) && (0..Board::BOARD_SIZE-1).include?(idx2)}

    temp_neighbors = []
    @board.board.each do |row|
      row.each do |tile|
        temp_neighbors << tile if tile_neighbors.include?(tile.position)
      end
    end
    temp_neighbors
  end

  def neighbor_bomb_count
    count = 0
    neighbors.each { |neighbor| count += 1 if neighbor.bomb }
    count
  end

  def inspect
    "#{@position}"
  end
end

class Board
  attr_reader :board
  BOARD_SIZE = 9

  def initialize
    @board = tile_setter
    @choice = []
  end

  def tile_setter
    set_board = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }

    BOARD_SIZE.times do |x|
      BOARD_SIZE.times do |y|
        rand(5) == 0 ? bomb = true : bomb = false
        set_board[x][y] = Tile.new(self ,[x,y],bomb)
      end
    end
    set_board
  end
end

class Game
  attr_reader :board

  def initialize()
    @board = Board.new.board
    @choice = nil
    @win = false
  end

  def play
    display_board
    until over?
      player_input
      display_board
    end
    display_outcome
  end

  def save
    File.open("#{Time.new.hour}-#{Time.new.min}.yml", 'w') do |f|
      f.puts @board.to_yaml
    end
  end

  def load(file_name)
    @board = YAML::load(File.open("#{file_name}.yml"))
  end

  private

  def display_board
    @board.each do |row|
      row.each do |tile|
        if tile.flagged
          print " F "
        elsif tile.neighbor_bomb_count > 0 && tile.revealed
         print " #{tile.neighbor_bomb_count} "
        elsif tile.revealed
          print " _ "
        elsif tile.bomb
          print " * "
        else
          print " * "
        end
      end
      puts ""
    end
  end

  def display_outcome
    if @won
      puts "BomB! You lose!"
    else
      puts "You win!"
    end
  end

  def over?
    return false if @choice.nil?
    return true if @board[@choice.first][@choice.last].bomb

    @board.each do |row|
      row.each do |tile|
        return false if tile.bomb == false && tile.revealed == false
      end
    end
    @win = true
    true
  end

  def player_input
    puts "Input coordinates you want to reveal or flag: "
    @choice = gets.chomp.split(',')
    if @choice.last == "f"
      @choice.map!(&:to_i)
      @board[@choice[0]][@choice[1]].flag
    else
      @choice.map!(&:to_i)
      @board[@choice.first][@choice.last].reveal
    end
  end


end

game = Game.new
#game.play
