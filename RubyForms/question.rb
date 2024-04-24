class Question
  attr_accessor :question_body, :question_correct_answer, :question_answers

  def initialize(raw_text, raw_answers)
    @question_body = raw_text
    load_answers(raw_answers)
  end

  def display_answers
    answers_str = ""
    @question_answers.each_with_index do |answer, index|
      answers_str += "#{('A'..'Z').to_a[index]}. #{answer}\n"
    end
    answers_str
  end

  def to_s
    @question_body
  end

  def to_h
    {
      question_body: @question_body,
      question_correct_answer: @question_correct_answer,
      question_answers: @question_answers
    }
  end

  def to_json
    to_h.to_json
  end

  def to_yaml
    to_h.to_yaml
  end

  def load_answers(raw_answers)
    @question_answers = raw_answers.shuffle
    @question_correct_answer = @question_answers.first
  end

  def find_answer_by_char(char)
    index = char.upcase.ord - 'A'.ord
    @question_answers[index]
  end
end
