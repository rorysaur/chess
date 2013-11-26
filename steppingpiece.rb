class SteppingPiece < Piece

  def moves
    moves = []

    self.class::DIFFS.each do |diff|
      x = @pos.first + diff.first
      y = @pos.last + diff.last
      if x.between?(0,7) && y.between?(0,7)
        moves << [x, y]
      end
    end

    moves
  end

end

