require "../spec_helper"

describe AoC2019::Day2 do
  describe ".exec_command" do
    it "returns correct result." do
      AoC2019::Day2.exec_command(AoC2019::Day2.i2c("1,0,0,0,99")).should eq AoC2019::Day2.i2c("2,0,0,0,99")
      AoC2019::Day2.exec_command(AoC2019::Day2.i2c("2,3,0,3,99")).should eq AoC2019::Day2.i2c("2,3,0,6,99")
      AoC2019::Day2.exec_command(AoC2019::Day2.i2c("2,4,4,5,99,0")).should eq AoC2019::Day2.i2c("2,4,4,5,99,9801")
      AoC2019::Day2.exec_command(AoC2019::Day2.i2c("1,1,1,4,99,5,6,0,99")).should eq AoC2019::Day2.i2c("30,1,1,4,2,5,6,0,99")
    end
  end
end
