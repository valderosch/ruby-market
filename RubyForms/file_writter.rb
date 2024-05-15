module QuizName
  class FileWriter
    def initialize(mode, *args)
      @mode = mode
      @answers_dir = args[0]
      @filename = args[1]
      if @filename
        @filename.gsub!(/\\.txt$/, '')
      end
      puts "Answers directory: #{@answers_dir}"
    end

    def write(message)
      File.open(prepare_filename(@answers_dir, @filename), @mode) do |file|
        file.puts message
      end
    end

    def prepare_filename(dir, filename)
      sanitized_filename = filename.gsub(/[^0-9A-Za-z.\-]/, '_')
      filename_with_extension = sanitized_filename.end_with?(".txt") ? sanitized_filename : sanitized_filename + ".txt"
      File.expand_path(filename_with_extension, dir)
    end
  end
end