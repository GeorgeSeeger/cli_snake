require_relative './snake'

class Board 
  attr_reader :snake

  def initialize height, width, snake_length, snake_incrememnt, food_probability
    @height = height
    @width = width
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
    make_food if rand < @food_prob
    periodically_bounder_snake
    render
  end

  def render
    board = @board.map{|r| r.dup }
    @foods.each do |f|
      render_to board, f, 'o'
    end
    @snake.segments.each do |seg|
      render_to board, seg, '#'
    end
    render_to board, @snake.tail, render_tail
    render_to board, @snake.head, '@'
    return board.map{|r| r.join("")}
  end

  private
  def make_food
    pos = @board.map.with_index{|r, i| r.map.with_index{|v, j| [i, j] }}
                .flatten(1)
                .reject{|p| @snake.segments.any?{|seg| seg.pos == p }}
                .sample
    @foods.push Food.new(pos)
  end

  def render_to(board, item, char)
    board[item.pos[0]][item.pos[1]] = char
  end

  def periodically_bounder_snake
    @snake.segments.each do |seg|
      seg.pos[0] = @height - 1 if seg.pos[0] <  0
      seg.pos[0] = 0           if seg.pos[0] >= @height
      seg.pos[1] = @width - 1  if seg.pos[1] <  0
      seg.pos[1] = 0           if seg.pos[1] >= @width
    end
  end

  def render_tail
    chars = {up: "v", right: "<", left: ">", down: "^"}
    @snake.dirs.select{|k, v| v == @snake.tail.dir}.map{|k, v| chars[k]}.first
  end
end

class Food
  attr_reader :pos
  def initialize pos
    @pos = pos
  end
end