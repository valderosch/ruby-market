require_relative 'quiz'

QuizRosh::Quiz.instance.configure do |config|
  config.yaml_dir = './yml'
  config.in_ext = 'yml'
  config.answers_dir = './answers'
end