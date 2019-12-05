require "../spec_helper"

describe AoC2019::Day4 do
  describe ".correct_password?" do
    it "returns true when the password is correct." do
      AoC2019::Day4.correct_password?("111111").should be_true
    end
    it "returns false when the password is incorrect." do
      AoC2019::Day4.correct_password?("223450").should be_false
      AoC2019::Day4.correct_password?("123789").should be_false
    end
  end

  describe ".correct_password2?" do
    it "returns true when the password is correct." do
      AoC2019::Day4.correct_password2?("112233").should be_true
      AoC2019::Day4.correct_password2?("111122").should be_true
    end
    it "returns false when the password is incorrect." do
      AoC2019::Day4.correct_password2?("123444").should be_false
    end
  end
end
