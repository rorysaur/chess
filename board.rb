# load 'pieces.rb'

# -*- coding: utf-8 -*-

load 'piece.rb'
load 'stepping_piece.rb'
load 'sliding_piece.rb'
load 'pawn.rb'
load 'rook.rb'
load 'queen.rb'
load 'bishop.rb'
load 'knight.rb'
load 'king.rb'

class Board

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8, nil) }
    # place_pieces
  end

  # private

  def place_pieces

    options = { :color => :white, :board => self }

    [[0,0], [0,7]].each do |pos|
      x, y = pos
      self[x, y] = Rook.new(pos, options)
    end

    [[0,1], [0,6]].each do |pos|
      x, y = pos
      self[x, y] = Knight.new(pos, options)
    end

    [[0,2], [0,5]].each do |pos|
      x, y = pos
      self[x, y] = Bishop.new(pos, options)
    end

    self[0,3] = Queen.new([0,4], options)

    self[0,4] = King.new([0,4], options)

    x = 1
    (0..7).each do |y|
      self[x, y] = Pawn.new([x,y], options)
    end

    options = { :color => :black, :board => self }

    [[7,0], [7,7]].each do |pos|
      x, y = pos
      self[x, y] = Rook.new(pos, options)
    end

    [[7,1], [7,6]].each do |pos|
      x, y = pos
      self[x, y] = Knight.new(pos, options)
    end

    [[7,2], [7,5]].each do |pos|
      x, y = pos
      self[x, y] = Bishop.new(pos, options)
    end

    x = 6
    (0..7).each do |y|
      self[x, y] = Pawn.new([x,y], options)
    end

    self[7,3] = Queen.new([7,4], options)

    self[7,4] = King.new([7,4], options)

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

  def dup
    duped_board = Board.new

    @grid.each_index do |x|
      @grid[x].each_index do |y|
        duped_board[x, y] = self[x, y].dup if self[x, y]
      end
    end

    duped_board
  end

  def in_check?(color)
  end

  def checkmate?(color)
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

b = Board.new
b.place_pieces
b.display

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