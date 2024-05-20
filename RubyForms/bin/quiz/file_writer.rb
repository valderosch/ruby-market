require_relative 'quiz'
require 'fileutils'

module QuizRosh
  class FileWriter
    def initialize(mode, filename)
      @filename = filename
      config = QuizRosh::Quiz.instance.configure
      @answers_dir = File.expand_path(config.answers_dir, __dir__)
      FileUtils.mkdir_p(@answers_dir) unless Dir.exist?(@answers_dir)
      @file = File.open(File.join(@answers_dir, filename), mode)
    end

    def write(message)
      @file.puts(message)
    end

    def close
      @file.close
    end
  end
end