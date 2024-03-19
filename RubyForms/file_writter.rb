class FileWriter
  def initialize(mode, *args)
    @answers_dir = args.first
    @filename = args.last
    @mode = mode
  end

  def write(message)
    File.open(prepare_filename(@filename), @mode) { |file| file.puts(message) }
  end

  private

  def prepare_filename(filename)
    File.expand_path(filename, @answers_dir)
  end
end