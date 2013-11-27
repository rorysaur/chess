require_relative './piece.rb'

class SlidingPiece < Piece

  def moves
    moves = []

    self.class::DELTAS.each do |delta|
      x = @pos.first + delta.first
      y = @pos.last + delta.last

      until !@board.on_board?([x, y]) || occupied?([x, y])
        moves << [x, y]
        x += delta.first
        y += delta.last
      end

      moves << [x, y] if @board.on_board?([x, y]) && occupied_opp_color?([x, y])
    end

    moves
  end

end

