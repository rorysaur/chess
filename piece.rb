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

  def occupied?(pos)
    occupied_same_color?(pos) || occupied_opp_color?(pos)
  end

  def occupied_same_color?(pos)
    x, y = pos
    @board[x,y] && @board[x, y].color == @color
  end

  def occupied_opp_color?(pos)
    x, y = pos
    @board[x,y] && @board[x, y].color != @color
  end

  def unoccupied?(pos)
    x, y = pos
    @board[x, y].nil?
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


