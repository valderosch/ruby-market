module QuizRosh
  class Quiz
    include Singleton

    attr_accessor :yaml_dir, :in_ext, :answers_dir

    def configure
      yield self if block_given?
      self
    end
  end
end