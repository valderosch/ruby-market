require 'yaml'

class QuestionData
  attr_reader :collection

  def initialize(yaml_dir, in_ext)
    @collection = []
    @yaml_dir = yaml_dir
    @in_ext = in_ext
  end

  def load_data
    each_file do |file|
      load_from(file)
    end
  end

  def to_yaml
    @collection.map(&:to_h).to_yaml
  end

  def save_to_yaml(filename)
    File.open(filename, 'w') { |file| file.write(to_yaml) }
  end

  def to_json
    @collection.map(&:to_h).to_json
  end

  def save_to_json(filename)
    File.open(filename, 'w') { |file| file.write(to_json) }
  end

  private

  def prepare_filename(filename)
    File.expand_path(filename, @yaml_dir)
  end

  def each_file
    Dir.glob(File.join(@yaml_dir, "*#{@in_ext}")).each do |file|
      yield(file)
    end
  end

  def load_from(filename)
    data = YAML.load_file(filename)
    data.each do |item|
      question = Question.new(item['question'], item['answers'])
      @collection << question
    end
  end
end
