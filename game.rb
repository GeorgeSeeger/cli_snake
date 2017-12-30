require 'board'
require 'settings'

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
    until @snake.impact?
      input = gets.chomp
      @snake.change_dir @controls[input]
      @board.next_frame
    end
  end
end