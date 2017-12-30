class Snake
  attr_reader :segments, :head, :pos, :dir

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
    if @dirs.has_key? dir_code
      dir = @dirs[dir_code]
      @dir = dir unless dir == @dir.map{|i| -1 * i }
    end
  end

  def move
    (1...@size).reverse_each do |i|
      @segments[i].move(@segments[i - 1].dir)
    end
    @head.move(@dir)
  end

  def make_segments
    @segments = (0...@size).map{|i| Segment.new(@pos, @dir, i) }
    @head = segments.first
    @tail = segments.last
  end

  def impact?
    @segments[1].delay <= 0 && @segments[1..-1].any?{|seg| seg.pos == @head.pos }
  end

  def eat
    @size += @inc
    (1..@inc).each do |i|
      @segments.push(Segment.new(@tail.pos, @tail.dir, i))
    end
    @tail = @segments.last
  end
end

class Segment
  attr_reader :dir, :pos, :delay
  def initialize pos, dir, delay
    @dir = dir.dup
    @pos = pos.dup
    @delay = delay
  end

  def move dir
    if @delay <= 0
      @pos[0] += @dir[0]
      @pos[1] += @dir[1]
      @dir = dir
    else
      @delay -= 1
    end
  end
end