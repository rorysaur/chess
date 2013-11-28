# -*- coding: utf-8 -*-

require_relative './stepping_piece.rb'

class Knight < SteppingPiece

  DELTAS = [
    [-2, 1],
    [-2, -1],
    [2, 1],
    [2, -1],
    [-1, -2],
    [-1, 2],
    [1, -2],
    [1, 2]
  ]

  def to_s
    @color == :white ? "♞ " : "♘ "
  end


end