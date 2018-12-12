# frozen_string_literal: true

def inputs_to_array(source)
  positions = []
  File.open(source).each do |line|
    position = {}
    evaluate = line.scan(/(\d+)\,\s(\d+)/)
    position[:x] = evaluate[0][0]
    position[:y] = evaluate[0][1]
    positions << position
  end
  positions
end

def make_map(_input)
  x_min, x_max = positions.minmax_by { |pos| pos[:x] }
  y_min, y_max = positions.minmax_by { |pos| pos[:y] }
end

input = inputs_to_array('./input.txt')
map = make_map(input)
