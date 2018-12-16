# frozen_string_literal: true

def get_positions(input)
  positions = []
  input.each_with_index do |line, index|
    evaluate = line.scan(/(\d+)\,\s(\d+)/).first
    position = { index: index, x: evaluate[0].to_i, y: evaluate[1].to_i }
    positions << position
  end
  positions
end

def make_map(pos)
  map = Hash.new(0)

  pos.each do |p|
    map[[p[:x], p[:y]]] = 'x'
  end
  map
end

def mark_neighbours(map, pos)
  x_max = pos.map { |p| p[:x] }.max
  y_max = pos.map { |p| p[:y] }.max

  (0..x_max).each do |i|
    (0..y_max ).each do |j|
      neighbours = pos.group_by { |p| (p[:x] - i).abs + (p[:y] - j).abs }.min.last
      if neighbours.length == 1
        map[[i, j]] = neighbours.first[:index]
      else
        map[[i, j]] = '-'
      end
    end
  end
  map
end

def largest_area(map)
  edge_cases = map.select { |key, _| key[0].zero? || key[1].zero? }.map { |_, value| value }.uniq
  clean_map = map.reject { |_, value| edge_cases.include? value }
  area = clean_map.map.group_by { |_, value| value }.max_by { |_, value| value.length }
  p area
  area[1].length + 1
end

def main
  input = File.read(File.join(File.dirname(__FILE__), './input2.txt')).split("\n")
  positions = get_positions(input)
  basic_map = make_map(positions)
  map = mark_neighbours(basic_map, positions)
  size = largest_area(map)
  puts size
end

main if $0 == __FILE__
