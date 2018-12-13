# frozen_string_literal: true

def get_positions(source)
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

def main
  input = File.read(File.join(File.dirname(__FILE__), './input.txt')).split("\n")
  positions = get_positions(input)
  map = make_map(positions)
end


