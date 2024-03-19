require 'yaml'

class QuestionData
  attr_reader :collection

  def initialize(yaml_dir)
    @yaml_dir = yaml_dir
    @collection = []
    load_data
  end

  def to_yaml
    collection.map(&:to_h).to_yaml
  end

  def save_to_yaml(filename)
    File.open(filename, 'w') { |file| file.write(to_yaml) }
  end

  private

  def prepare_filename(filename)
    File.expand_path(filename, @yaml_dir)
  end

  def load_data
    # Implement this method to load data from YAML files
    Dir.glob(prepare_filename('*.yml')).each do |file|
      @collection.concat(load_from(file))
    end
  end

  def load_from(filename)
    YAML.load_file(filename).map do |data|
      Question.new(data['question'], data['answers'])
    end
  end
end
