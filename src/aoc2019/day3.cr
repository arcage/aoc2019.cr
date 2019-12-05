module AoC2019::Day3
  struct Point
    include Comparable(self)
    getter x : Int32
    getter y : Int32

    def initialize(@x, @y)
    end

    def manhattan_distance(from : Point = ZERO)
      (@x - from.x).abs + (@y - from.y).abs
    end

    def <=>(other : self)
      manhattan_distance <=> other.manhattan_distance
    end

    def move(command : String)
      dir = command[0]
      step = command[1..-1].to_i
      case dir
      when 'U'
        return up(step)
      when 'D'
        return down(step)
      when 'L'
        return left(step)
      when 'R'
        return right(step)
      end
      raise "Invalid move"
    end

    def up(step : Int32)
      Point.new(x, y + step)
    end

    def down(step : Int32)
      Point.new(x, y - step)
    end

    def left(step : Int32)
      Point.new(x - step, y)
    end

    def right(step : Int32)
      Point.new(x + step, y)
    end

    def to_s(io : IO)
      inspect(io)
    end

    ZERO = self.new(0, 0)
  end

  struct Line
    getter p1 : Point
    getter p2 : Point
    @x1 : Int32?
    @x2 : Int32?
    @y1 : Int32?
    @y2 : Int32?

    def initialize(@p1 : Point, @p2 : Point)
    end

    def x1
      @x1 ||= @p1.x < @p2.x ? @p1.x : @p2.x
    end

    def x2
      @x2 ||= @p1.x >= @p2.x ? @p1.x : @p2.x
    end

    def y1
      @y1 ||= @p1.y < @p2.y ? @p1.y : @p2.y
    end

    def y2
      @y2 ||= @p1.y >= @p2.y ? @p1.y : @p2.y
    end

    def length
      (x2 - x1) + (y2 - y1)
    end

    def step_to(point : Point)
      return nil unless includes?(point)
      @p1.manhattan_distance(point)
    end

    def includes?(point : Point)
      x1 <= point.x && x2 >= point.x && y1 <= point.y && y2 >= point.y
    end

    def vertical?
      @p1.x == @p2.x
    end

    def horizontal?
      @p1.y == @p2.y
    end

    def x
      if vertical?
        @p1.x
      else
        raise "Not vertical line #{self}"
      end
    end

    def y
      if horizontal?
        @p1.y
      else
        raise "Not horizontal line #{self}"
      end
    end

    def intersection(other : Line)
      return nil if self.vertical? == other.vertical?
      if self.vertical?
        vline = self
        hline = other
      else
        vline = other
        hline = self
      end
      if hline.x1 < vline.x && hline.x2 > vline.x && vline.y1 < hline.y && vline.y2 > hline.y
        Point.new(vline.x, hline.y)
      else
        nil
      end
    end

    def to_s(io : IO)
      inspect(io)
    end
  end

  class Wire
    getter lines : Array(Line)

    @lines = Array(Line).new

    def initialize(input : String)
      pos = Point.new(0, 0)
      commands = input.split(',')
      while command = commands.shift?
        next_pos = pos.move(command)
        @lines << Line.new(pos, next_pos)
        pos = next_pos
      end
    end

    def steps_to(point : Point)
      steps = 0
      @lines.each do |line|
        if step = line.step_to(point)
          return steps + step
        else
          steps += line.length
        end
      end
      raise "Not reached to #{point}."
    end

    def all_intersections(other : Wire)
      intersections = Array(Point).new
      lines.product(other.lines) do |line1, line2|
        if intersection = line1.intersection(line2)
          intersections << intersection
        end
      end
      intersections
    end

    def to_s(io : IO)
      inspect(io)
    end
  end

  def self.nearest_intersection_distance(wire1 : Wire, wire2 : Wire)
    wire1.all_intersections(wire2).map(&.manhattan_distance).min
  end

  def self.run(io : IO)
    wire1 = Wire.new(io.read_line)
    wire2 = Wire.new(io.read_line)
    nearest_intersection_distance(wire1, wire2)
  end

  def self.run2(io : IO)
    wire1 = Wire.new(io.read_line)
    wire2 = Wire.new(io.read_line)
    intersections = wire1.all_intersections(wire2)
    intersections.map { |pt| wire1.steps_to(pt) + wire2.steps_to(pt) }.min
  end
end
