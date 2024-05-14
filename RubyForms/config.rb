module QuizName
  module Config
    extend self

    attr_accessor :yaml_dir, :answers_dir, :in_ext

    def config
      yield self
    end

    self.yaml_dir = "config/yml/outdata"
    self.answers_dir = "config/answers"
    self.in_ext = "config/yml/indata"
  end
end
