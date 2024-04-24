require 'fileutils'

class FileWriter
  def initialize(mode, *args)
    @answers_dir = args.first
    @mode = mode
  end

  def write(answers, username)
    current_time = Time.now.strftime("%Y_%m_%d_%H-%M")

    user_dir = File.join(@answers_dir, username)
    FileUtils.mkdir_p(user_dir) unless Dir.exist?(user_dir)

    filename = "user_#{username}_#{current_time}.txt"

    File.open(File.join(user_dir, filename), @mode) { |file| file.puts(answers) }
  end
end