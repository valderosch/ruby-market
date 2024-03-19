class InputReader
  def read(welcome_message: nil, validator: nil, error_message: nil, process: nil)
    puts welcome_message if welcome_message
    input = gets.chomp
    input = process.call(input) if process
    return input if validator.nil? || validator.call(input)

    puts error_message
    read(welcome_message: welcome_message, validator: validator, error_message: error_message, process: process)
  end
end