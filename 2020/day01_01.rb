# frozen_string_literal: true

input = File.read('day01_01.txt').lines.map(&:to_i)

input.combination(2).each do |c|
  if c.sum == 2020
    puts c.inject(:*)
    break
  end
end
