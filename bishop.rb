# -*- coding: utf-8 -*-

require_relative './sliding_piece.rb'

class Bishop < SlidingPiece

  DELTAS = [
    [-1, -1],
    [-1, 1],
    [1, -1],
    [1, 1]
  ]

  def to_s
    @color == :white ? "♗ " : "♝ "
  end
end