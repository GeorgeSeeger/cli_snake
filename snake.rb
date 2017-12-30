class Snake
  attr_reader :segments, :pos, :dir

  def initialize pos, size, inc
    @pos = pos
    @dir = [-1, 0]
    @dirs = {
      up: [-1, 0],
      right: [0, 1],
      down: [1, 0],
      left: [0, -1]
    }
    @size = size
    @inc = inc
    make_segments
  end

  def change_dir dir_code
    @dir= @dirs[dir_code]
  end

  def move
    @head.move @dir
    (1...@size).each do |i|
      @segments[i].move(@segments[i - 1].dir)
    end
  end

  def make_segments
    @segments = (0...size).map{|i| Segment.new(@pos, @dir, i) }
    @head = segments.first
  end

  def impact?
    @segments[1..-1].any?{|seg| seg.pos == @head.pos }
  end

  def eat 
    tail = @segments.last
    (1..@inc).each do |i|
      @segments.push(Segment.new(tail.pos, tail.dir, i))
  end
end

class Segment
  attr_reader :dir, :pos
  def initialize pos, dir, delay
    @dir = dir
    @pos = pos
    @delay = delay
  end

  def move dir
    if @delay <= 0
      @pos[0] += @dir[0]
      @pos[1] += @dir[0]
    else
      @delay -= 1
    end
    @dir = dir
  end
end