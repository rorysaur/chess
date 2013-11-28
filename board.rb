load 'pieces.rb'
require_relative 'errors'
require 'colorize'

# -*- coding: utf-8 -*-


class Board

  BOARD_SIZE = 8

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8, nil) }
  end

  def place_pieces
    back_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

    back_row.each_with_index do |piece_class, index|
      self[0, index] = piece_class.new([0, index], :black, self)
    end

    8.times do |y|
      self[1, y] = Pawn.new([1, y], :black, self)
    end

    8.times do |y|
      self [6, y] = Pawn.new([6, y], :white, self)
    end

    back_row.each_with_index do |piece_class, index|
      self[7, index] = piece_class.new([7, index], :white, self)
    end
  end

  def [](x, y)
    @grid[x][y]
  end

  def []=(x, y, val)
    @grid[x][y] = val
  end

  def on_board?(pos)
    x, y = pos
    x.between?(0,7) && y.between?(0,7)
  end

  def pieces
    @grid.flatten.compact
  end

  def move(from_pos, to_pos, turn)
    from_x, from_y = from_pos
    to_x, to_y = to_pos

    piece = self[from_x, from_y]

    validate_move(piece, to_pos, turn)

    self[to_x, to_y] = self[from_x, from_y]
    self[from_x, from_y] = nil
    piece.pos = to_pos
  end

  def move!(from_pos, to_pos)
    from_x, from_y = from_pos
    to_x, to_y = to_pos

    piece = self[from_x, from_y]

    self[to_x, to_y] = self[from_x, from_y]
    self[from_x, from_y] = nil
    piece.pos = to_pos
  end

  def occupied?(pos, color)
    occupied_same_color?(pos, color) || occupied_opp_color?(pos, color)
  end

  def occupied_same_color?(pos, color)
    x, y = pos
    self[x,y] && self[x, y].color == color
  end

  def occupied_opp_color?(pos, color)
    x, y = pos
    self[x,y] && self[x, y].color != color
  end

  def dup
    duped_board = Board.new

    @grid.each_index do |x|
      @grid[x].each_index do |y|
        duped_board[x, y] = self[x, y].dup(duped_board) if self[x, y]
      end
    end

    duped_board
  end

  def in_check?(color)
    king_pos = find_king(color)

    self.pieces.each do |piece|
      if piece.color != color && piece.moves.include?(king_pos)
        return true
      end
    end

    false
  end

  def checkmate?(color)
    own_pieces = self.pieces.select { |piece| piece.color == color }
    in_check?(color) && own_pieces.all? { |piece| piece.valid_moves.empty? }
  end

  def display
    square_color = :red

    puts "  " + ('a'..'h').to_a.join(" ").colorize(:white)
    @grid.each_index do |x|
      print "#{8 - x} ".colorize(:white)
      @grid[x].each_index do |y|
        if self[x,y].nil?
          print "  ".colorize(:background => square_color)
        else
          print (self[x,y].to_s).colorize(:color => :white,
            :background => square_color)
        end
        square_color = square_color == :red ? :black : :red
      end
      print " #{8 - x} \n".colorize(:white)
      square_color = square_color == :red ? :black : :red
    end
    puts "  " + ('a'..'h').to_a.join(" ").colorize(:white)
  end


  private

  def validate_move(piece, to_pos, turn)

    if piece.nil?
      raise InvalidMoveError.new("There is no piece at that position.")
    elsif piece.color != turn
      raise InvalidMoveError.new("Can't move opponent's piece.")
    elsif !piece.moves.include?(to_pos)
      piece.show_valid_moves
      raise InvalidMoveError.new("Invalid move.")
    elsif !piece.valid_moves.include?(to_pos)
      piece.show_valid_moves
      raise InvalidMoveError.new("Can't move into check.")
    end

    true
  end

  def find_king(color)
    self.pieces.each do |piece|
      if piece.is_a?(King) && piece.color == color
        return piece.pos
      end
    end
  end

end

