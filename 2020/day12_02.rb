require 'byebug'

instructions = []

File.read('day12_input.txt').lines.map do |line|
  action, value = line.match(/(\w)(\d+)/).captures

  instruction = [action, value.to_i]
  instructions << instruction
end

def rotate(waypoint, value)
  case value
  when 180, -180
    waypoint.north *= -1
    waypoint.east *= -1
  when 90, -270
    waypoint.east, waypoint.north = waypoint.north, waypoint.east * -1
  when 270, -90
    waypoint.east, waypoint.north = waypoint.north  * -1, waypoint.east
  end
  waypoint
end

def move_ship(position, direction, distance)
  position[0] = position[0] + direction[0] * distance
  position[1] = position[1] +direction[1] * distance
  position
end

Location = Struct.new(:east, :north)
ship = Location.new(0, 0)
waypoint = Location.new(10, 1)

instructions.each do |action, value|
  case action
  when 'N'
    waypoint.north += value
  when 'S'
    waypoint.north -= value
  when 'E'
    waypoint.east += value
  when 'W'
    waypoint.east -= value
  when 'R'
    waypoint = rotate(waypoint, value)
  when 'L'
    waypoint = rotate(waypoint, -value)
  when 'F'
    ship.east += waypoint.east * value
    ship.north += waypoint.north * value
  end
end

puts ship.inspect
puts ship.map(&:abs).sum
