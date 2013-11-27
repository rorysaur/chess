load 'board.rb'

class Game

  def initialize
    @board = Board.new
  end

  def play

    while true
      @board.display

      begin
        puts "Move: ( Ex: 7,1 5,2 )"
        input = gets.chomp
        coords = parse_input(input)
        @board.move(coords.first, coords.last)
      # rescue ArgumentError => e
#         # puts "Enter number coordinates."
#         puts e
#         retry
      # rescue InvalidMoveError => e
      #   puts e
      #   retry
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

Game.new.play