# -*- coding: utf-8 -*-

require_relative './piece.rb'

class Pawn < Piece


  def to_s
    @color == :white ? "♙ " : "♟ "
  end
end