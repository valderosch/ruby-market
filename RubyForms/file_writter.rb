class FileWritter
  attr_accessor :answers_dir, :filename, :mode
  def initialize(mode, *args)
    answers_dir = answers_dir
    filename = filename
    mode = mode
  end

  def write (message)
    message = "Message"
    print message
  end

  def prepare_filename(filename)
    #path
  end
end
