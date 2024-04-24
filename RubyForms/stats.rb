class Statistics
  def initialize(writer)
    @correct_answers = 0
    @incorrect_answers = 0
    @writer = writer
  end

  def correct_answer
    @correct_answers += 1
  end

  def incorrect_answer
    @incorrect_answers += 1
  end

  def print_report(total_questions)
    percentage = (@correct_answers.to_f / total_questions * 100).round(2)
    report = "Total questions: #{total_questions}\n"
    report += "Correct answers: #{@correct_answers}\n"
    report += "Incorrect answers: #{@incorrect_answers}\n"
    report += "Percentage: #{percentage}%\n"
    @writer.write(report)
    puts report
  end
end