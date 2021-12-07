# frozen_string_literal: true

input = File.read('day01_input.txt').lines.map(&:to_i)

count = 0
input.each_cons(2) do |a, b|
  if a < b
    count += 1
  end
end

p count
