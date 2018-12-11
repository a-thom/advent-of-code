def inputs_to_string(source)
  File.read(source)
end

def remove_pattern(string)
  loop do
    prev_length = string.length

    string.gsub!(/([A-z])\1+/i) do |pair|
      char = pair[0].downcase
      option1 = char + char.upcase
      option2 = char.upcase + char

      pair.gsub(option1, "").gsub(option2, "")
    end

    break if string.length == prev_length
  end
  return string
end

string = inputs_to_string('./input.txt')
result = remove_pattern(string)
puts result.length
