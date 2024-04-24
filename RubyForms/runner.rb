require_relative 'config'
require_relative 'engine'

total_questions = 10
yaml_dir = "yml/indata"
in_ext = "yml/indata"


engine = Engine.new(total_questions, yaml_dir, in_ext)
engine.run