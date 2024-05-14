module QuizName
  class FileWriter
    def initialize(mode, *args)
      @mode = mode
      @answers_dir = args[0]
      @filename = args[1]
    end

    def write(message)
      File.open(prepare_filename(@answers_dir, @filename), @mode) do |file|
        file.puts message
      end
    end

    def prepare_filename(dir, filename)
      File.expand_path("#{filename}.txt", dir)
    end
  end
end