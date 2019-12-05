module AoC2019::Day2
  def self.i2c(input : String)
    input.split(',').map(&.to_i)
  end

  def self.c2i(command : Array(Int32))
    command.join(',')
  end

  def self.exec_command(command : Array(Int32))
    pos = 0
    size = command.size
    while size > pos
      case command[pos]
      when 1
        command[command[pos + 3]] = command[command[pos + 1]] + command[command[pos + 2]]
      when 2
        command[command[pos + 3]] = command[command[pos + 1]] * command[command[pos + 2]]
      when 99
        break
      else
        raise "Invalid input"
      end
      pos += 4
    end
    command
  end

  def self.process(command : Array(Int32), noun : Int32 = 12, verb : Int32 = 2)
    command[1] = noun
    command[2] = verb
    command
    exec_command(command)[0]
  end

  def self.run(io : IO)
    input = io.gets_to_end
    process(AoC2019::Day2.i2c(input))
  end

  def self.run2(io : IO, expect : Int32)
    input = io.gets_to_end
    0.upto(99) do |noun|
      0.upto(99) do |verb|
        actual = process(AoC2019::Day2.i2c(input), noun, verb)
        if actual == expect
          return noun * 100 + verb
        end
      end
    end
    raise "Answer not found"
  end
end
