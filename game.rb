load 'board.rb'
load 'errors.rb'

class Game

  attr_accessor :turn

  def initialize
    @board = Board.new
    @board.place_pieces
    @turn = :white
  end

  def play

    until won?
      @board.display
      puts "Black in check!" if @board.in_check?(:black)
      puts "White in check!" if @board.in_check?(:white)

      take_turn
    end

    winner = @turn == :white ? :black : :white
    winner_name = winner.to_s.capitalize

    @board.display
    puts "Checkmate! #{winner_name} wins."
  end


  private

  def take_turn
    begin
      turn = @turn.to_s.capitalize
      puts "#{turn}! Your move: ( Ex: c2 c3 )"

      input = gets.chomp
      coords = parse_input(input)

      @board.move(coords.first, coords.last, @turn)
      @turn = @turn == :white ? :black : :white
    rescue ArgumentError => e
      puts "Couldn't parse input."
      retry
    rescue ParseInputError => e
      puts e
      retry
    rescue InvalidMoveError => e
      puts e
      retry
    end
  end

  def parse_input(input)
    if input.empty?
      raise ParseInputError.new("Enter a move.")
    end

    positions = input.split

    from_arr = positions.first.split("")
    from_x = 8 - Integer(from_arr.last)
    from_y = from_arr.first.ord - 97
    from_pos = [from_x, from_y]

    to_arr = positions.last.split("")
    to_x = 8 - Integer(to_arr.last)
    to_y = to_arr.first.ord - 97
    to_pos = [to_x, to_y]

    unless (from_pos + to_pos).all? { |i| i.is_a?(Integer) }
      raise ParseInputError.new("Couldn't parse input.")
    end

    [from_pos, to_pos]
  end

  def won?
    @board.checkmate?(@turn)
  end

end

Game.new.play