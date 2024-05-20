require_relative 'libraries'
require_relative 'quiz'

puts "Creating quiz engine..."
quiz_config = QuizRosh::Quiz.instance
engine = QuizRosh::Engine.new(quiz_config)
engine.run
puts "Quiz engine finished."