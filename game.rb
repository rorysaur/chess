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

    end_game
  end


  private

  def take_turn
    begin
      turn = @turn.to_s.capitalize
      puts "#{turn}! Your move: ([h] for help)"

      input = gets.chomp.downcase

      if input.match(/[hslq]/)
        game_menu(input)
        return nil
      end

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

  def game_menu(input)

    if input == "h"
      help
    end

    if input == "s"
      save
      puts "Game saved."
    end

    if input == "l"
      begin
        load
      rescue Errno::ENOENT
        puts "No saved game found."
      end
    end

    if input == "q"
      puts "Bye."
      exit
    end
  end

  def help
    puts "Example move: c2 c3"
    puts "[s] to save game"
    puts "[l] to load game"
    puts "[q] to quit"
    puts "Press any key."
    gets
  end

  def save
    board_yaml = @board.to_yaml
    File.open("saved_board", "w") do |f|
      f.puts board_yaml
    end
    turn_yaml = @turn.to_yaml
    File.open("saved_turn", "w") do |f|
      f.puts turn_yaml
    end
  end

  def load
    board_yaml = File.read("saved_board")
    @board = YAML.load(board_yaml)
    turn_yaml = File.read("saved_turn")
    @turn = YAML.load(turn_yaml)
    self.play
  end

  def parse_input(input)
    if input.empty?
      raise ParseInputError.new("Enter a move.")
    end

    if input == "q"
      puts "Bye."
      exit
    end

    move = []
    positions = input.split
    positions.each do |position|
      move << parse_coords(position.split(""))
    end

    move
  end

  def parse_coords(coords)
    x = Board::BOARD_SIZE - Integer(coords.last)
    y = coords.first.ord - 97

    unless [x, y].all? { |i| i.is_a?(Integer) }
      raise ParseInputError.new("Couldn't parse input.")
    end

    [x, y]
  end

  def won?
    @board.checkmate?(@turn)
  end

  def end_game
    winner = @turn == :white ? :black : :white
    winner_name = winner.to_s.capitalize

    @board.display
    puts "Checkmate! #{winner_name} wins."
  end

end

if $PROGRAM_NAME = __FILE__
  case ARGV.count
  when 0
    Game.new.play
  # when 1
    # YAML.load_file(ARGV.shift).play
  end
end
