# frozen_string_literal: true

input = File.read('day03_input.txt').lines.to_a

length = input[0].length-1

trees, col, row = 0

input.each_with_index do |row, index|
  trees += 1 if row[(index*3)%length] == '#'
end

puts trees


