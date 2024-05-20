module QuizRosh
  class Statistics
    attr_reader :correct_answers, :incorrect_answers

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

    def print_report(username, start_time, end_time)
      total_questions = @correct_answers + @incorrect_answers
      result = (correct_answers.to_f / total_questions * 100).round(2)
      report = <<~REPORT
        Name: #{username}
        Correct answers: #{@correct_answers}
        Wrong answers: #{@incorrect_answers}
        Result: #{result}%
        Start time: #{start_time}
        End time: #{end_time}
      REPORT

      @writer.write(report)
      puts report
    end
  end
end