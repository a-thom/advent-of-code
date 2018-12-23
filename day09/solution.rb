require 'pry'

def main
  player_count = 13
  active_player = 0
  last_marble = 7999
  active_marble = 0
  points = Hash.new(0)
  circle = [0]
  pointer = 0

  while active_marble < last_marble
    active_player = active_marble % player_count + 1
    active_marble += 1
    puts active_player
    unless active_marble % 23 == 0
      pointer = (pointer + 2) % circle.length
      circle.insert(pointer, active_marble)
    else
      # binding.pry
      points[active_player] += active_marble
      pointer -= 7
      points[active_player] += circle.slice!(pointer)
    end
  end
  highscore = points.max_by { |_, val| val }
  p highscore
end

main if $0 == __FILE__
