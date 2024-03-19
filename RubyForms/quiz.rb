require 'singleton'

class Quiz
  include Singleton
  attr_accessor :yaml_dir, :answers_dir, :in_ext

  def self.config(&block)
    instance.instance_eval(&block)
  end
end