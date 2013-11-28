# -*- coding: utf-8 -*-

require_relative './sliding_piece.rb'

class Rook < SlidingPiece

  DELTAS = [
    [-1, 0],
    [0, 1],
    [0, -1],
    [1, 0],
  ]

  def to_s
    @color == :white ? "♜ " : "♖ "
  end
end