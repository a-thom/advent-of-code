# frozen_string_literal: true

def inputs_to_array(source)
  inputs_array = []
  # i = 0
  File.open(source).each do |line|
    # while i < 3
    inputs_array.push(line.to_str.chomp)
    # i += 1
    # end
  end
  inputs_array
end

def calculate_checksum(input)
  doubles = 0
  triples = 0

  input.each do |string|
    char_array = string.split('').uniq
    double_counter = 0
    triple_counter = 0
    char_array.each do |char|
      counter = string.scan(/(?=#{char})/).count
      double_counter += 1 if counter == 2
      triple_counter += 1 if counter == 3
    end
    doubles += 1 if double_counter >= 1
    triples += 1 if triple_counter >= 1
  end
  doubles * triples
end

def evaluate(string1, string2)
  matching = []
  pointer = 0
  one_array = string1.split('')
  comp_array = string2.split('')
  one_array.each do |char|
    matching << char if char == comp_array[pointer]
    pointer += 1
  end
  if matching.length == one_array.length - 1
    return matching.join
  else
    return false
  end
end

def find_matching(input)
  counter = 0
  matching = false
  input.each do |string|
    comparisons = input.slice(counter + 1..input.length - 1)
    comparisons.each do |comp|
      matching = evaluate(string, comp)
      return matching unless matching == false
    end
    counter += 1
  end
end

inputs_array = inputs_to_array('./input.txt')
puts 'Checksum:'
puts calculate_checksum(inputs_array)
puts 'Matching Characters:'
puts find_matching(inputs_array)
