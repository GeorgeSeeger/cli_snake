require './game'

settings = {
  "height" => 15,
  "width" => 15,
  "snake_increment" => 2,
  "snake_length" => 4,
  "food_probability" => 0.10,
  "controls" => {
    "w" => :up,
    "d" => :right,
    "a" => :left,
    "s" => :down,
  }
}

game = Game.new settings
game.game_loop