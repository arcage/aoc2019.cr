module AoC2019::Day4
  PASSWORD_FORMAT = /\A\d{6}\z/

  def self.correct_password?(password : String)
    raise "Invalid password(#{password})" unless password =~ PASSWORD_FORMAT
    digits = password.chars
    double_digit = false
    last_digit = '\0'
    while digit = digits.shift?
      double_digit = true if digit == last_digit
      return false if digit < last_digit
      last_digit = digit
    end
    return double_digit
  end

  def self.correct_password2?(password : String)
    raise "Invalid password(#{password})" unless password =~ PASSWORD_FORMAT
    digits = password.chars
    double_digit = false
    continus_digits = 0
    last_digit = '\0'
    while digit = digits.shift?
      if digit == last_digit
        continus_digits += 1
      else
        double_digit = true if continus_digits == 2
        continus_digits = 1
      end
      return false if digit < last_digit
      last_digit = digit
    end
    double_digit = true if continus_digits == 2
    return double_digit
  end

  def self.run(io : IO)
    line = io.read_line
    from, to = line.split('-')
    raise "Invalid input" unless from =~ PASSWORD_FORMAT || to =~ PASSWORD_FORMAT
    correct = 0
    (from.to_i..to.to_i).each do |i|
      correct += 1 if correct_password?(i.to_s.rjust(6, '0'))
    end
    correct
  end

  def self.run2(io : IO)
    line = io.read_line
    from, to = line.split('-')
    raise "Invalid input" unless from =~ PASSWORD_FORMAT || to =~ PASSWORD_FORMAT
    correct = 0
    (from.to_i..to.to_i).each do |i|
      correct += 1 if correct_password2?(i.to_s.rjust(6, '0'))
    end
    correct
  end
end
