class Engine
  def initialize
    @question_collection = QuestionData.new(Quiz.instance.yaml_dir).collection
    @input_reader = InputReader.new
    @writer = FileWriter.new('a', Quiz.instance.answers_dir, "#{Time.now.strftime('%Y-%m-%d_%H-%M-%S')}.txt")
    @statistics = Statistics.new(@writer)
  end

  def run
    @question_collection.each do |question|
      puts question
      puts question.display_answers
      user_answer = get_answer_by_char(question)
      check(user_answer, question.question_correct_answer)
    end
    @statistics.print_report
  end

  private

  def check(user_answer, correct_answer)
    if user_answer == correct_answer
      @statistics.correct_answer
      puts "Correct!"
    else
      @statistics.incorrect_answer
      puts "Incorrect!"
    end
  end

  def get_answer_by_char(question)
    @input_reader.read(process: ->(input) { input.upcase }, validator: ->(input) { input.match?(/^[A-Z]$/) })
  end
end