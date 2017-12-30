require_relative './board'
require_relative './util/single_input'
#require 'settings'

class Game
  def initialize settings
    @board = Board.new(
                settings["height"],
                settings["width"],
                settings["snake_length"],
                settings["snake_increment"],
                settings["food_probability"])
    @controls = settings["controls"].map{|k, v| [k, v.to_sym]}.to_h
    @hz       = 1.0 / settings["frames_per_second"].to_i
    @snake = @board.snake
  end

  def game_loop
    system "clear"
    puts @board.render
    begin
      input = char_if_pressed
      @snake.change_dir @controls[input]
      @board.next_frame            
      system "clear"
      puts @board.render
      sleep @hz
    end until @snake.impact?
  end
end