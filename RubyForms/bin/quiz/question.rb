module QuizRosh
  class Question
    attr_accessor :question_body, :question_answers, :question_correct_answer

    def initialize(question_body, question_answers, question_correct_answer)
      @question_body = question_body
      @question_answers = question_answers
      @question_correct_answer = question_correct_answer
    end

    def display_answers
      @question_answers.each_with_index.map { |answer, index| "#{index + 1}. #{answer}" }
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

    def to_json(*_args)
      to_h.to_json
    end

    def to_yaml
      to_h.to_yaml
    end

    private

    def load_answers(raw_answers)
      shuffled = raw_answers.shuffle
      Hash[('A'..'Z').zip(shuffled.map { |a| a['answer'] })]
    end

    def find_answer_by_char(char)
      @question_answers[char]
    end
  end
end