# frozen_string_literal: true

input = File.read('day03_input.txt').lines.to_a

length = input[0].length-1

slopes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]

product = 1

slopes.each do |slope|
  trees = 0
  input.each_with_index do |row, index|
    if index%slope[1] == 0
      trees += 1 if row[(index*slope[0]/slope[1])%length] == '#'
    end
  end
  puts trees
  product *= trees
end

puts product


