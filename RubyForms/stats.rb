class Statistic
  attr_accessor :correct, :incorrect, :writer
  def initialize
    super
  end

  def correct_answer
    correct+1
  end

  def incorrect_answer
    incorrect+1
  end

  def print_report
    print "Correct #{correct} Incorrect #{incorrect}, Score: #{correct+ incorrect / 2}"
  end
end
