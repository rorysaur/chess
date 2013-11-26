class Piece

  attr_accessor :color, :pos, :board, :moves

  def initialize(pos, options = {})
    @color = options[:color]
    @pos = pos
    @board = options[:board]
    @moves = []
  end

  def moves
  end

  def valid_moves
  end

  def to_s
  end
end


