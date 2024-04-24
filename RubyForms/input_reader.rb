class InputReader
  def read(welcome_message: nil, validator: nil, error_message: nil, process: nil)
    puts welcome_message ? welcome_message : 'Put your answer.'

    loop do
      input = gets.chomp
      input = process.call(input) if process
      return input if validator.nil? || validator.call(input)

      puts error_message if error_message
    end
  end
end