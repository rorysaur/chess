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
    invalid_moves = []

    moves.each do |move|
      invalid_moves << move if move_into_check?(move)
    end

    moves - invalid_moves
  end

  def move_into_check?(to_pos)
    board_copy = @board.dup

    board_copy.move!(@pos, to_pos)
    board_copy.in_check?(@color)
  end

  def to_s
  end

  def dup(board)
    self.class.new(@pos, { :color => @color, :board => board } )
  end

  def show_valid_moves
    board_copy = @board.dup
    moves.each do |pos|
      x, y = pos
      board_copy[x, y] = "# "
    end

    board_copy.display
  end
end


