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

  def print_report
    total_questions = @correct_answers + @incorrect_answers
    correct_percentage = (@correct_answers.to_f / total_questions * 100).round(2)
    report = "Total questions: #{total_questions}, Correct answers: #{@correct_answers}, Incorrect answers: #{@incorrect_answers}, Correct percentage: #{correct_percentage}%"
    @writer.write(report)
    puts report
  end
end