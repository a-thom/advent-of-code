# frozen_string_literal: true

def inputs_to_array(source)
  File.read(source).strip
end

def remove_pattern(string_input)
  string = string_input
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

def create_variants(string_input)
  min_result = string_input.length
  ('a'..'z').each do |letter|
    new_string = string_input.gsub(/([#{Regexp.escape(letter)}])/i, '')
    new_result = remove_pattern(new_string)
    min_result = [new_result.length, min_result].min
  end
  min_result
end

input1 = inputs_to_array('./input.txt')
result1 = remove_pattern(input1)
puts 'Part1'
puts result1.length
input2 = inputs_to_array('./input.txt')
result2 = create_variants(input2)
puts 'Part2'
puts result2
