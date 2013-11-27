require_relative './piece.rb'

class SteppingPiece < Piece

  def moves
    moves = []

    self.class::DELTAS.each do |delta|
      x = @pos.first + delta.first
      y = @pos.last + delta.last
      if @board.on_board?([x, y]) && !@board.occupied_same_color?([x, y], @color)
        moves << [x, y]
      end
    end

    moves
  end

end

