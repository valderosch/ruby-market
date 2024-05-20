require 'yaml'
require 'fileutils'

def load_questions(file_path)
  puts "Loading questions from #{file_path}"
  YAML.load_file(file_path)
end

def ask_question(question_data)
  puts question_data['question']
  question_data['answers'].each_with_index do |answer, index|
    puts "#{index + 1}. #{answer}"
  end

  print "Your choice (1-#{question_data['answers'].length}): "
  user_answer_index = gets.to_i - 1
  user_answer = question_data['answers'][user_answer_index]

  if user_answer == question_data['correct_answer']
    puts "Correct, answer."
    return true
  else
    puts "Incorrect answer."
    return false
  end
end

def save_results(username, correct_count, incorrect_count, start_time, end_time)
  result = (correct_count.to_f / (correct_count + incorrect_count) * 100).round(2)
  result_string = "#{username}, Start Time: #{start_time}, End Time: #{end_time}, Result: #{result}%\n"

  filename = "quiz_#{username}_#{Time.now.strftime('%Y_%m_%d_%H-%M')}.txt"
  answers_dir = File.expand_path('answers', __dir__)
  file_path = File.join(answers_dir, filename)

  FileUtils.mkdir_p(answers_dir) unless Dir.exist?(answers_dir)

  File.open(file_path, 'w') do |file|
    file.write("Name: #{username}\n")
    file.write("Correct answers: #{correct_count}\n")
    file.write("Wrong answers: #{incorrect_count}\n")
    file.write("Result: #{result}%\n")
    file.write(result_string)
  end

  puts "Results saved in #{file_path}"
  puts "\nStatistics:"
  puts "Name: #{username}"
  puts "Correct answers: #{correct_count}"
  puts "Wrong answers: #{incorrect_count}"
  puts "Result: #{result}%"
  puts "Start time: #{start_time}"
  puts "End time: #{end_time}"
end

# program starting point
def start_app
  puts "Enter your name:"
  username = gets.chomp

  questions_file = File.expand_path('yml/quiz1.yml', __dir__)
  puts "Searching questions by: #{questions_file}"
  questions = load_questions(questions_file)

  correct_count = 0
  incorrect_count = 0

  start_time = Time.now

  questions.each do |question_data|
    if ask_question(question_data)
      correct_count += 1
    else
      incorrect_count += 1
    end
  end

  end_time = Time.now

  save_results(username, correct_count, incorrect_count, start_time, end_time)

  puts "Thank you for your opinion!"
end

start_app