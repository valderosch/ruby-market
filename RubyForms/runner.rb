require_relative 'quiz'
require_relative 'input_reader'
require_relative 'file_writter'
require_relative 'stats'
require_relative 'engine'

module QuizName
  class Runner
    def initialize
      @quiz = Quiz.instance
      @file_writer = FileWriter.new('w')
      @statistics = Statistics.new(@file_writer)
    end

    def run
      puts "App run"
      @quiz.config

      username = InputReader.read(welcome_message: 'Enter your username:', validator: ->(input) { !input.empty? }, error_message: 'Username cannot be empty').gsub(/[^\w]/, '_')
      start_time = Time.now
      puts "USERNAME: #{username}"
      puts "TIME: #{start_time}"

      engine = Engine.new(username)
      puts "Engine created"
      engine.run
      puts "Engine started"

      result = engine.result
      end_time = Time.now
      @statistics.add_result(username, start_time, end_time, result)

      answers_dir = Quiz.instance.answers_dir
      FileUtils.mkdir_p(answers_dir) unless File.directory?(answers_dir)

      @file_writer.write_result(username, result)

      @file_writer.display_result(username, result)
    end
  end
end
