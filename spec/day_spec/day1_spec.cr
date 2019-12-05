require "../spec_helper"

describe AoC2019::Day1 do
  describe ".fuel_to_launch" do
    it "calcurates module from math" do
      AoC2019::Day1.fuel_to_launch(12).should eq 2
      AoC2019::Day1.fuel_to_launch(14).should eq 2
      AoC2019::Day1.fuel_to_launch(1969).should eq 654
      AoC2019::Day1.fuel_to_launch(100756).should eq 33583
    end
  end

  describe ".fuel_to_louhch2" do
    AoC2019::Day1.fuel_to_launch2(14).should eq 2
    AoC2019::Day1.fuel_to_launch2(1969).should eq 966
    AoC2019::Day1.fuel_to_launch2(100756).should eq 50346
  end
end
