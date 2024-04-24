class Engine
  def initialize(total_questions, yaml_dir, in_ext)
    @question_collection = load_questions(total_questions, yaml_dir, in_ext)
    @input_reader = InputReader.new
    @user_name = @input_reader.read(welcome_message: "Enter your name:")
    @current_time = Time.now.strftime("%Y_%m_%d_%H-%M")
    @writer = FileWriter.new("w", Quiz.answers_dir, "user_#{@user_name}_#{@current_time}.txt")
    @statistics = Statistics.new(@writer)
  end

  def run
    @question_collection.each do |question|
      puts question.to_s
      puts question.display_answers
      user_answer = get_answer_by_char(question)
      check(user_answer, question.question_correct_answer)
    end
    @statistics.print_report
  end

  private

  def check(user_answer, correct_answer)
    if user_answer.downcase == correct_answer.downcase
      @statistics.correct_answer
      puts "Your answer is correct!"
    else
      @statistics.incorrect_answer
      puts "Your answer is incorrect! The correct answer is: #{correct_answer}"
    end
  end

  def get_answer_by_char(question)
    loop do
      char = @input_reader.read(welcome_message: "Enter your answer (A, B, C, etc.):")
      return question.find_answer_by_char(char) unless char.empty?
    end
  end

  def load_questions(total_questions, yaml_dir, in_ext)
    QuestionData.new(total_questions, yaml_dir, in_ext).load_data
  end
end