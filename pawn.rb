# -*- coding: utf-8 -*-

require_relative './piece.rb'

class Pawn < Piece

  MOVE_DELTA = [1, 0]
  FIRST_MOVE_DELTA = [2, 0]
  CAPTURE_DELTAS = [[1, 1], [1, -1]]
  INITIAL_ROW = { :white => 1, :black => 6 }


  def moves
    moves = []

    multiplier = @color == :white ? 1 : -1

    normal_move = MOVE_DELTA.map { |i| i * multiplier }
    first_move = FIRST_MOVE_DELTA.map { |i| i * multiplier }

    capture_moves = CAPTURE_DELTAS.map do |delta|
      delta.map { |i| i * multiplier }
    end

    if @pos.first == INITIAL_ROW[@color]
      x = @pos.first + first_move.first
      y = @pos.last + first_move.last
      moves << [x, y] unless @board.occupied?([(x - multiplier), y], @color)
    end

    capture_moves.each do |delta|
      x = @pos.first + delta.first
      y = @pos.last + delta.last
      moves << [x, y] if @board.occupied_opp_color?([x, y], @color)
    end

    x = @pos.first + normal_move.first
    y = @pos.last + normal_move.last
    moves << [x, y] unless @board.occupied?([x, y], @color)

    moves
  end

  def to_s
    @color == :white ? "♙ " : "♟ "
  end
end