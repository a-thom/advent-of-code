# frozen_string_literal: true

def get_positions(input)
  positions = []
  input.each do |line|
    evaluate = line.scan(/(\d+)\,\s(\d+)/).first
    position = { x: evaluate[0].to_i, y: evaluate[1].to_i }
    positions << position
  end
  positions
end

def make_map(pos)
  x = pos.map { |p| p[:x] }.max
  y = pos.map { |p| p[:y] }.max

  map = Array.new(x)
  puts map

end

def main
  input = File.read(File.join(File.dirname(__FILE__), './input.txt')).split("\n")
  positions = get_positions(input)
  map = make_map(positions)
end

main if $0 == __FILE__
