require "../spec_helper"

describe AoC2019::Day3 do
  describe ".run" do
    it "returns correct distance." do
      io1 = IO::Memory.new("R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83")
      AoC2019::Day3.run(io1).should eq 159
      io2 = IO::Memory.new("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\nU98,R91,D20,R16,D67,R40,U7,R15,U6,R7")
      AoC2019::Day3.run(io2).should eq 135
    end
  end

  describe ".run2" do
    it "returns fewest steps." do
      io1 = IO::Memory.new("R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83")
      AoC2019::Day3.run2(io1).should eq 610
      io2 = IO::Memory.new("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\nU98,R91,D20,R16,D67,R40,U7,R15,U6,R7")
      AoC2019::Day3.run2(io2).should eq 410
    end
  end
end
