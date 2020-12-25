require 'byebug'

instructions = []

File.read('day12_input.txt').lines.map do |line|
  action, value = line.match(/(\w)(\d+)/)[1, 2]

  instruction = {
    action: action,
    value: value.to_i
  }
  instructions << instruction
end

puts instructions.inspect


def change_direction(current, instruction)
  directions = %w(N E S W)

  sign = instruction[:action] == 'R' ? 1 : -1

  directions[(directions.index(current) + instruction[:value]/90 * sign)%4]
end

def move(position, direction, distance)
  ix = direction == 'N' || direction == 'S' ? 0 : 1
  sign = direction == 'S' || direction == 'W' ? -1 : 1

  position[ix] = position[ix] + distance * sign
  position
end

orientation = 'E'
position = [0, 0]

instructions.each do |instruction|
  case instruction[:action]
  when 'L', 'R'
    orientation = change_direction(orientation, instruction)
  when 'F'
    position = move(position, orientation, instruction[:value])
  when 'N', 'S', 'E', 'W'
    position = move(position, instruction[:action], instruction[:value])
  end
end

puts orientation
puts position.map(&:abs).sum
