

class QuestionData
  attr_accessor :collection

  def initialize(collection)
    collection = collection
    load_data()
  end

  def transform_to_yaml
    #magic
  end

  def transform_to_json
    #magic
  end

  def prepare_filename(filename)
    # magic
  end

  def each_file(&block)
    # Each
  end

  def in_thread(&block)
    # thread
  end

  def load_data
    # each thread loadFrom
  end

  def load_from(filename)
    # yaml reading + Question obj collection
  end

  def save_file(data, filetype, path)
    # saving file
  end
end
