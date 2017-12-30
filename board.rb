require 'snake'

class Board 
  attr_reader :snake

  def initialize height, width, snake_length, snake_incrememnt, food_probability
    @board = Array.new(height) { Array.new(width) { '.' }}
    @snake = Snake.new([height / 2, width / 2], snake_length, snake_incrememnt)
    @food_prob = food_probability
    @foods = []
    make_food
  end

  def next_frame
    @snake.move
    found_food = @foods.find{|f| f.pos == @snake.head.pos }
    if (!!found_food)
      @snake.eat
      @foods.delete found_food
    end
    make_food if rand < food_prob
    render
  end

  def render
    board = @board.dup
    @snake.segments.each do |seg|
      board[seg.pos[0]][seg.pos[1]] = '#'
    end
    board[@snake.head.pos[0]][@snake.head.pos[1]] = '@'
    return board
  end

  def make_food
    pos = @board.map.with_index{|r, i| r.map.with_index{|v, j| [i, j] }}
                .flatten(1)
                .reject{|p| @snake.segments.any?{|seg| seg.pos == p }}
                .sample
    @foods.push Food.new(pos)
  end
end

class Food
  attr_reader :pos
  def initialize pos
    @pos = pos
  end
end