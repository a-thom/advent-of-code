require 'pry'

class Marble
  attr_accessor :value, :ccw_neighbour, :cw_neighbour

  def initialize(value, ccw = nil, cw = nil)
    @cw_neighbour = cw || self
    @ccw_neighbour = ccw || self
    @value = value
  end

  def remove
    ccw = self.ccw_neighbour
    cw = self.cw_neighbour

    ccw.cw_neighbour = cw_neighbour
    cw.ccw_neighbour = ccw_neighbour
  end

  def insert(value)
    cw = self.cw_neighbour

    marble = Marble.new(value, self, cw)

    self.cw_neighbour = marble
    cw.ccw_neighbour = marble
  end
end

def play(pls, val)
  players = pls
  last_value = val
  marble_value = 0
  points = Hash.new(0)

  marble = Marble.new(marble_value)
  while marble_value < last_value
    active_player = marble_value % players
    marble_value += 1
    unless marble_value % 23 == 0
      marble.cw_neighbour.insert(marble_value)
      marble = marble.cw_neighbour.cw_neighbour
    else
      7.times { marble = marble.ccw_neighbour }
      points[active_player] += marble.value + marble_value
      marble.remove
      marble = marble.cw_neighbour
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
  puts play(468, 71843 * 100)
end

main if $0 == __FILE__
