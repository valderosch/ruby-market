require_relative 'question_data'
require_relative 'input_reader'
require_relative 'file_writer'
require_relative 'statistics'
require_relative 'quiz'

module QuizRosh
  class Engine
    def initialize(quiz_config)
      @question_collection = QuestionData.new
      @input_reader = InputReader.new
      @username = @input_reader.read(
        welcome_message: "Enter your name:",
        error_message: "Name cannot be empty.",
        validator: ->(input) { !input.empty? }
      )
      @current_time = Time.now.strftime('%Y-%m-%d_%H-%M')
      @writer = FileWriter.new('w', "quiz_#{@username}_#{@current_time}.txt")
      @statistics = Statistics.new(@writer)
      @quiz_config = quiz_config
    end


    def run
      start_time = Time.now

      puts "Question collection \n#{@question_collection.to_json}"
      @question_collection.collection.each do |question|
        puts "Question: #{question}"
        question.display_answers.each { |answer| puts answer }
        user_answer_index = get_answer_by_char(question)
        user_answer = question.question_answers[user_answer_index - 1]
        check(user_answer, question.question_correct_answer)
      end

      end_time = Time.now
      @statistics.print_report(@username, start_time, end_time)
    end

    private

    def check(user_answer, correct_answer)
      if user_answer == correct_answer
        @statistics.correct_answer
        @writer.write("Correct answer.")
        puts "Correct answer."
      else
        @statistics.incorrect_answer
        @writer.write("Incorrect answer.")
        puts "Incorrect answer."
      end
    end

    def get_answer_by_char(question)
    @input_reader.read(
      error_message: "Invalid answer, try again.",
      validator: ->(input) { input.to_i.between?(1, question.question_answers.size) },
      process: ->(input) { input.to_i }
      )
    end
  end
end