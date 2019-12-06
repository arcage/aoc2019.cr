require "../src/aoc2019"

program = File.open("inputs/day5.txt").gets_to_end

diagnostic_code = AoC2019::Day5.run(program)

puts "Diagnostic Code: #{diagnostic_code}"
