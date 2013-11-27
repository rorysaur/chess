require_relative './piece.rb'

class SlidingPiece < Piece

  def moves
    moves = []

    self.class::DELTAS.each do |delta|
      x = @pos.first + delta.first
      y = @pos.last + delta.last

      until !@board.on_board?([x, y]) || @board.occupied?([x, y], @color)
        moves << [x, y]
        x += delta.first
        y += delta.last
      end

      if @board.on_board?([x, y]) && @board.occupied_opp_color?([x, y], @color)
        moves << [x, y]
      end

    end

    moves
  end

end

