load 'piece.rb'

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
      x, y = pos.first, pos.last
      self[x, y] = Rook.new(pos, options)
    end

    [[0,1], [0,6]].each do |pos|
      x, y = pos.first, pos.last
      self[x, y] = Knight.new(pos, options)
    end

    [[0,3], [0,5]].each do |pos|
      x, y = pos.first, pos.last
      self[x, y] = Bishop.new(pos, options)
    end

    self[0,3] = Queen.new([0,4], options)

    self[0,4] = King.new([0,4], options)

    x = 1
    (0..7).each do |y|
      self[x, y] = Pawn.new(pos, options)
    end

    options = { :color => :black, :board => self }

    [[7,0], [7,7]].each do |pos|
      x, y = pos.first, pos.last
      self[x, y] = Rook.new(pos, options)
    end

    [[7,1], [7,6]].each do |pos|
      x, y = pos.first, pos.last
      self[x, y] = Knight.new(pos, options)
    end

    [[7,3], [7,5]].each do |pos|
      x, y = pos.first, pos.last
      self[x, y] = Bishop.new(pos, options)
    end

    x = 6
    (0..7).each do |y|
      self[x, y] = Pawn.new(pos, options)
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

  def dup
  end

  def in_check?(color)
  end

  def checkmate?(color)
  end

  def display
    @grid.each_index do |x|
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
r = Rook.new([3,3], { :color => :black, :board => b })
b[3,3] = r
b.display
p r.color
p r.pos
p r.board