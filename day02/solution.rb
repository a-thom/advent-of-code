def inputs_to_array(source)
  inputs_array = []
  File.open(source).each do |line|
    inputs_array.push(line.to_str.chomp)
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

inputs_array = inputs_to_array('./input.txt')
puts calculate_checksum(inputs_array)
