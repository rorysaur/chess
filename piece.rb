class InvalidMoveError < StandardError
end

class Piece

  attr_accessor :color, :pos, :board, :moves

  def initialize(pos, options = {})
    @color = options[:color]
    @pos = pos
    @board = options[:board]
    @moves = []
  end

  def moves
    # can't move to square occupied by same color
  end

  def same_color?(pos)
    x, y = pos
    if @board[x, y].nil?
      false
    elsif @board[x, y].color == @color
      true
    else
      false
    end
  end

  def valid_moves
  end

  def to_s
  end
end


