require './board'
#require 'settings'

class Game
  def initialize settings
    @board = Board.new(
                settings["height"],
                settings["width"],
                settings["snake_length"],
                settings["snake_increment"],
                settings["food_probability"])
    @controls = settings["controls"]
    @snake = @board.snake
  end

  def game_loop
    until false
      system "clear"
      puts @board.render
      puts @snake.segments.map{|seg| seg.pos.to_s + " => " + seg.dir.to_s + "& #{seg.delay}" }
      input = gets.chomp
      @snake.change_dir @controls[input]
      @board.next_frame
    end
  end
end