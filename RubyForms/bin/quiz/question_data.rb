require 'yaml'
require_relative 'quiz'
require_relative 'question'

module QuizRosh
  class QuestionData
    attr_accessor :collection

    def initialize
      @collection = []
      config = QuizRosh::Quiz.instance
      @yaml_dir = File.expand_path(config.yaml_dir, __dir__)
      @in_ext = config.in_ext
      @threads = []
      load_data
    end

    def to_yaml
      @collection.to_yaml
    end

    def save_to_yaml(filename)
      File.write(prepare_filename(filename), to_yaml)
    end

    def to_json
      @collection.to_json
    end

    def save_to_json(filename)
      File.write(prepare_filename(filename), to_json)
    end

    private

    def prepare_filename(filename)
      File.expand_path(filename, __dir__)
    end

    def each_file
      Dir.glob(File.join(@yaml_dir, "*.#{@in_ext}")).each do |file|
        yield file
      end
    end

    def in_thread(&block)
      @threads << Thread.new do
        block.call
      end
    end

    def load_data
      each_file do |filename|
        in_thread { load_from(filename) }
      end
      @threads.each(&:join)
    end

    def load_from(filename)
      questions = YAML.load_file(filename)
      puts "Number of questions loaded: #{questions.size}"
      questions.each do |question_data|
        question = Question.new(question_data['question'], question_data['answers'], question_data['correct_answer'])
        @collection << question
      end
    end
  end
end