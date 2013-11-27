load 'board.rb'

class Game

  def initialize
    @board = Board.new
    @board.place_pieces
  end

  def play

    while true
      @board.display
      puts "Black in check? #{@board.in_check?(:black)}"
      puts "Black checkmated? #{@board.checkmate?(:black)}"
      puts "White in check? #{@board.in_check?(:white)}"
      puts "White checkmated? #{@board.checkmate?(:white)}"

      begin
        puts "Move: ( Ex: 7,1 5,2 )"
        input = gets.chomp
        coords = parse_input(input)
        @board.move(coords.first, coords.last)
      rescue ArgumentError => e
        # puts "Enter number coordinates."
        puts e
        retry
      rescue InvalidMoveError => e
        puts e
        retry
      rescue => e
        puts e
        retry
      end
    end
  end

  def parse_input(input)
    positions = input.split

    from = positions.first.split(",").map { |i| Integer(i) }
    to = positions.last.split(",").map { |i| Integer(i) }

    [from, to]
  end

end

# Game.new.play