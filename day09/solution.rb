require 'pry'

def play(p, v)
  players = p
  last_marble = v
  active_player = 0
  active_marble = 0
  points = Hash.new(0)
  circle = [0]
  pointer = 0

  while active_marble <= last_marble
    active_player = active_marble % players + 1
    active_marble += 1
    unless active_marble % 23 == 0
      pointer = (pointer + 2) % circle.length
      circle.insert(pointer, active_marble)
    else
      pointer = (pointer - 7) % circle.length
      points[active_player] += active_marble + circle.slice!(pointer)
    end
  end
  points.max_by { |_, val| val }[1]
end

def main
  puts play(9, 25) - 32
  puts play(10, 1618) - 8317
  puts play(13, 7999) - 146373
  puts play(17, 1104) - 2764
  puts play(21, 6111) - 54718
  puts play(30, 5807) - 37305
  puts play(468, 71843)
end

main if $0 == __FILE__
