require_relative './piece.rb'

class SlidingPiece < Piece

  def moves
    moves = []

    self.class::DELTAS.each do |delta|
      x = @pos.first + delta.first
      y = @pos.last + delta.last

      until !@board.on_board?([x, y]) || occupied_same_color?([x, y]) ||
         occupied_opp_color?([x, y])
        moves << [x, y]
        x += delta.first
        y += delta.last
      end

      moves << [x, y] if @board.on_board?([x, y]) && occupied_opp_color?([x, y])
    end

    moves
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

