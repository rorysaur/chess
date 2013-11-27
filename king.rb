# -*- coding: utf-8 -*-

require_relative './stepping_piece.rb'

class King < SteppingPiece

  DELTAS = [
    [-1, -1],
    [-1, 0],
    [-1, 1],
    [0, 1],
    [0, -1],
    [1, -1],
    [1, 0],
    [1, -1]
  ]

  def to_s
    @color == :white ? "♔ " : "♚ "
  end
end