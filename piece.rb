class InvalidMoveError < StandardError
end

class Piece

  attr_accessor :color, :pos, :board, :moves

  def initialize(pos, options = {})
    @color = options[:color]
    @pos = pos
    @board = options[:board]
  end

  def moves
  end

  def valid_moves
  end

  def to_s
  end

  def show_moves
    board_copy = @board.dup
    moves.each do |pos|
      x, y = pos
      board_copy[x, y] = "# "
    end

    board_copy.display
  end
end


