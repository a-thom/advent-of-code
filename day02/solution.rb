def inputs_to_array(source)
  inputs_array = []
  #i = 0
  File.open(source).each do |line|
    #while i < 3
      inputs_array.push(line.to_str.chomp)
      #i += 1
    #end
  end
  return inputs_array
end

def calculate_checksum(input)
  doubles = 0
  triples = 0

  for string in input do
    char_array = string.split("").uniq
    double_counter = 0
    triple_counter = 0
    for char in char_array do
      counter = string.scan(/(?=#{char})/).count
      double_counter += 1 if counter == 2
      triple_counter += 1 if counter == 3
    end
    doubles += 1 if double_counter >= 1
    triples += 1 if triple_counter >= 1
  end
  return doubles * triples
end

def evaluate(string1, string2)
  matching = []
  pointer = 0
  one_array = string1.split("")
  comp_array = string2.split("")
  for char in one_array do
    if char == comp_array[pointer]
      matching << char
    end
    pointer += 1
  end
  if matching.length == one_array.length-1
    return matching.join
  else
    return false
  end
end

def find_matching(input)
  counter = 0
  matching = false
  for string in input do
    comparisons = input.slice(counter+1..input.length-1)
    for comp in comparisons do
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
