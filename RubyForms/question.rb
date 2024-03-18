class Question
  attr_accessor :body, :answers, :correct_answers

  def initialize(raw_text, raw_answers)

  end

  def display_answers
    answer = "#{char} some #{answer}"
  end

  def load_answers(raw_answers)
    #some magic
  end

  def find_answer_by_char(char)
    # some magic
  end

  def to_s
    # some string
  end

  def to_h
    # some hash
  end

  def to_json
    #some json obj
  end

  def to_yaml
    # yaml file
  end

end
