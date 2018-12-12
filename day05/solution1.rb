# frozen_string_literal: true

def inputs_to_array(source)
  input = File.read(source)
  array = input.split('').chop
  p array
end

def remove_pattern(string)
  loop do
    prev_length = string.length

    string.gsub!(/([A-z])\1+/i) do |pair|
      char = pair[0].downcase
      option1 = char + char.upcase
      option2 = char.upcase + char

      pair.gsub(option1, '').gsub(option2, '')
    end

    break if string.length == prev_length
  end
  string
end

string = inputs_to_array('./input.txt')
puts string.length
result1 = remove_pattern(string)
puts 'Part1'
puts result1.length
puts string.length
result2 = create_variants(string)
