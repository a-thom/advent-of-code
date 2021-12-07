# frozen_string_literal: true

input = File.read('day02_input.txt').lines.map(&:split)

depth = 0
position = 0

input.each do |instruction, extent|
  case instruction
  when "down"
    depth += extent.to_i
  when "forward"
    position += extent.to_i
  when "up"
    depth -= extent.to_i
  end
end

p depth * position
