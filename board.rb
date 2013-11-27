load 'pieces.rb'

# -*- coding: utf-8 -*-


class Board

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8, nil) }
  end

  def place_pieces
    back_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

    back_row.each_with_index do |piece_class, index|
      self[0, index] = piece_class.new([0, index], :white, self)
    end

    8.times do |y|
      self[1, y] = Pawn.new([1, y], :white, self)
    end

    8.times do |y|
      self [6, y] = Pawn.new([6, y], :black, self)
    end

    back_row.each_with_index do |piece_class, index|
      self[7, index] = piece_class.new([7, index], :black, self)
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

  def move(from, to)
    from_x, from_y = from
    to_x, to_y = to

    piece = self[from_x, from_y]

    if piece.nil?
      raise InvalidMoveError.new("There is no piece at that position.")
    elsif !piece.moves.include?(to)
      piece.show_valid_moves
      raise InvalidMoveError.new("Invalid move.")
    elsif !piece.valid_moves.include?(to)
      piece.show_valid_moves
      raise InvalidMoveError.new("Can't move into check.")
    elsif piece.valid_moves.include?(to)
      self[to_x, to_y] = self[from_x, from_y]
      self[from_x, from_y] = nil
      piece.pos = to
    end
  end

  def move!(from, to)
    from_x, from_y = from
    to_x, to_y = to

    piece = self[from_x, from_y]

    if piece.nil?
      raise InvalidMoveError.new("There is no piece at that position.")
    else
      self[to_x, to_y] = self[from_x, from_y]
      self[from_x, from_y] = nil
      piece.pos = to
    end
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

  def find_king(color)
    self.pieces.each do |piece|
      if piece.is_a?(King) && piece.color == color
        return piece.pos
      end
    end
  end

  def checkmate?(color)
    own_pieces = self.pieces.select { |piece| piece.color == color }

    own_pieces.each do |own_piece|
    end

    in_check?(color) && own_pieces.all? { |piece| piece.valid_moves.empty? }
  end

  def display
    puts "  " + ('0'..'7').to_a.join(" ")
    @grid.each_index do |x|
      print "#{x} "
      @grid[x].each_index do |y|
        if self[x,y].nil?
          print "_ "
        else
          print self[x,y].to_s
        end
      end
      print "\n"
    end
  end

end

# b = Board.new
# b.place_pieces
# b.display
# b.move([7,1], [5,2])
# b.display
# b.move([5,2], [6,2])
# b.display

# p1 = Queen.new([4,4], { :color => :black, :board => b })
# b[4,4] = p1
# p2 = Queen.new([4,1], { :color => :white, :board => b })
# b[4,1] = p2
# p3 = Queen.new([2,2], { :color => :white, :board => b })
# b[2,2] = p3
# p1.show_moves
# p p1.moves



# r = Rook.new([3,3], { :color => :black, :board => b })
# b[3,3] = r
# b.display
# p r.color
# p r.pos
# p r.board