# frozen_string_literal: true
require 'set'

def get_positions(input)
  positions = []
  input.each_with_index do |line, index|
    evaluate = line.scan(/(\d+)\,\s(\d+)/).first
    position = { index: index, x: evaluate[0].to_i, y: evaluate[1].to_i, count: 0 }
    positions << position
  end
  p positions
  positions
end

def largest_area(pos)
  x_max = pos.map { |p| p[:x] }.max
  y_max = pos.map { |p| p[:y] }.max
  edge_cases = Set.new

  (0..x_max).each do |i|
    (0..y_max).each do |j|
      neighbours = pos.group_by { |p| (p[:x] - i).abs + (p[:y] - j).abs }.min.last
      if neighbours.length == 1
        neighbours.first[:count] += 1
        if i == 0 || i == x_max || j == 0 || j == y_max
          edge_cases.add(neighbours.first[:index])
        end
      end
    end
  end

  clean_pos = pos.reject{ |pos| edge_cases.include? pos[:index] }
  max = clean_pos.max_by{ |pos| pos[:count] }
end

def safe_area(pos)
  x_max = pos.map { |p| p[:x] }.max
  y_max = pos.map { |p| p[:y] }.max

  safe_size = 0

  (0..x_max).each do |i|
    (0..y_max).each do |j|
      total_dist = pos.reduce(0) { |sum, p| sum + (p[:x] - i).abs + (p[:y] - j).abs }
      if total_dist < 10000
        safe_size += 1
      end
    end
  end
  safe_size
end


def main
  input = File.read(File.join(File.dirname(__FILE__), './input.txt')).split("\n")
  positions = get_positions(input)
  puts 'Largest Area'
  puts largest_area(positions)
  puts 'Size of safe area'
  puts safe_area(positions)
end

main if $0 == __FILE__
