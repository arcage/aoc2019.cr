module AoC2019::Day5
  class Computer
    class ProgramError < Exception; end

    enum ParametorMode
      POSITION
      IMMEDIATE
    end

    @memory = Array(Int32).new
    @program_size = 0
    @output = 0
    @pointer = 0
    @opcode : String?
    @parameter_modes : {ParametorMode, ParametorMode, ParametorMode} | Nil
    @instructions = Hash(String, Proc(Bool)).new
    @params = Array(Tuple(Int32, Int32)).new
    @values = Array(Int32).new

    def initialize(*, @io_in : IO = STDIN, @io_out : IO = STDOUT, @debug_mode : Bool = false)
      @instructions["01"] = ->add
      @instructions["02"] = ->multiply
      @instructions["03"] = ->input
      @instructions["04"] = ->output
      @instructions["05"] = ->jump_if_true
      @instructions["06"] = ->jump_if_false
      @instructions["07"] = ->less_than
      @instructions["08"] = ->equals
      @instructions["99"] = ->halt
    end

    def run(program : String)
      memory_initialize(program)
      while @program_size > @pointer
        break unless process_current_instruction
      end
      return @output
    end

    def check_last_test_result
      raise "Test failed before #{@pointer}" unless @output == 0
    end

    def memory_initialize(program : String)
      @memory = program.chomp.split(',').map(&.to_i)
      @program_size = @memory.size
      @store = 1
      @pointer = 0
    end

    def process_current_instruction
      parse_opcode
      @instructions[opcode].call
    end

    def error(message)
      raise ProgramError.new("Error: #{message} at @#{@pointer}")
    end

    def opcode
      @opcode || raise "Opcode is uninitialized."
    end

    def parameter_modes
      @parameter_modes || raise "Parameter modes are uninitialized."
    end

    def parse_opcode
      instruction_type = @memory[@pointer].to_s.rjust(5, '0')
      @opcode = instruction_type[3..4]
      error("Invalid Opcode #{@opcode}") unless @instructions.has_key?(opcode)
      parameter_mode_list = instruction_type[0..2].chars.map { |c| ParametorMode.new(c.to_i) }
      @parameter_modes = {parameter_mode_list[2], parameter_mode_list[1], parameter_mode_list[0]}
      true
    end

    def get_params(*modes : ParametorMode)
      @params.clear
      @values.clear
      modes.each_index do |i|
        read_pointer = @pointer + i + 1
        @params << {@memory[read_pointer], modes[i].value}
        @values << read(read_pointer, modes[i])
      end
      @values
    end

    def read(pointer : Int32, parameter_mode : ParametorMode)
      case parameter_mode
      when .position?
        @memory[@memory[pointer]]
      when .immediate?
        @memory[pointer]
      else
        raise "Invalid parameter mode."
      end
    end

    def write(pointer : Int32, value : Int32)
      @memory[pointer] = value
    end

    def step_forward(step : Int32)
      @pointer += step
    end

    def jump_to(pointer : Int32)
      @pointer = pointer
    end

    def add
      check_last_test_result
      value1, value2, write_pointer = get_params(parameter_modes[0], parameter_modes[1], ParametorMode::IMMEDIATE)
      debug
      write(write_pointer, value1 + value2)
      step_forward(4)
      true
    end

    def multiply
      check_last_test_result
      value1, value2, write_pointer = get_params(parameter_modes[0], parameter_modes[1], ParametorMode::IMMEDIATE)
      debug
      write(write_pointer, value1 * value2)
      step_forward(4)
      true
    end

    def input
      check_last_test_result
      write_pointer = get_params(ParametorMode::IMMEDIATE)[0]
      debug
      value = @io_in.gets.not_nil!.to_i
      write(write_pointer, value)
      step_forward(2)
      true
    end

    def output
      check_last_test_result
      @output = get_params(parameter_modes[0])[0]
      debug
      @io_out.puts @output
      step_forward(2)
      true
    end

    def jump_if_true
      check_last_test_result
      value, jump_pointer = get_params(parameter_modes[0], parameter_modes[1])[0..1]
      debug
      unless value == 0
        jump_to(jump_pointer)
      else
        step_forward(3)
      end
      true
    end

    def jump_if_false
      check_last_test_result
      value, jump_pointer = get_params(parameter_modes[0], parameter_modes[1])[0..1]
      debug
      if value == 0
        jump_to(jump_pointer)
      else
        step_forward(3)
      end
      true
    end

    def less_than
      check_last_test_result
      value1, value2, write_pointer = get_params(parameter_modes[0], parameter_modes[1], ParametorMode::IMMEDIATE)
      debug
      write(write_pointer, value1 < value2 ? 1 : 0)
      step_forward(4)
      true
    end

    def equals
      check_last_test_result
      value1, value2, write_pointer = get_params(parameter_modes[0], parameter_modes[1], ParametorMode::IMMEDIATE)
      debug
      write(write_pointer, value1 == value2 ? 1 : 0)
      step_forward(4)
      true
    end

    def halt
      debug
      step_forward(1)
      false
    end

    def debug
      if @debug_mode
        @io_out.puts "Debug:"
        @io_out.puts "  Pointer: #{@pointer}"
        @io_out.puts "  Opcode:  #{opcode}"
        @io_out.puts "  Params:  #{@params.inspect}"
        @io_out.puts "  Values:  #{@values.inspect}"
        @io_out.puts "  #{@memory.inspect}"
      end
    end
  end

  def self.run(program : String, *, debug_mode : Bool = false)
    cpu = Computer.new(debug_mode: debug_mode)
    cpu.run(program)
  end
end
