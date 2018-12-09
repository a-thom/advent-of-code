
def inputs_to_array(source)
  inputs_array = []
  File.open(source).each do |line|
  	inputs_array.push(line.to_i)
  end
  return inputs_array
end

def get_sum(input)
  sum = 0
  for i in input
    sum += i
  end
  return sum
end

def get_duplicate(input)
  duplicate_found = false
  new_value = 0
  frequencies_array = [new_value]

  until duplicate_found
    for i in input
      new_value += i
      if frequencies_array.include?(new_value)
        duplicate_found = new_value
        break
      end
      frequencies_array.push(new_value)
    end
  end
return duplicate_found
end

inputs_array = inputs_to_array('./input.txt')

puts "Sum of Frequency Changes:"
puts get_sum(inputs_array)
puts "First Duplicate:"
puts get_duplicate(inputs_array)
