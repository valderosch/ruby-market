require_relative 'quiz'

Quiz.config do |config|
  config.yaml_dir = "yml/indata"
  config.answers_dir = "answers"
  config.in_ext = "yml"
end