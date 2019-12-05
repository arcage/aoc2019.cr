module AoC2019::Day1
  def self.fuel_to_launch(math : Int32)
    (math // 3) - 2
  end

  def self.fuel_to_launch2(math : Int32)
    fuel_tank = [] of Int32
    target_math = math
    loop do
      fuel = (target_math // 3) - 2
      if fuel > 0
        fuel_tank << fuel
        target_math = fuel
      else
        break
      end
    end
    fuel_tank.reduce { |t, f| t + f }
  end

  def self.run(io : IO)
    input = ARGF.gets_to_end

    input.split(/\n/).map { |math|
      AoC2019::Day1.fuel_to_launch(math.to_i)
    }.reduce { |total, fuel| total + fuel }
  end

  def self.run2(io : IO)
    input = ARGF.gets_to_end

    input.split(/\n/).map { |math|
      AoC2019::Day1.fuel_to_launch2(math.to_i)
    }.reduce { |total, fuel| total + fuel }
  end
end
