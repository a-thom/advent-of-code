
def make_grid(serial)
  grid = []
  for x in 1..298
    for y in 1..298
      sum = 0
      for i in x..x+2
        for j in y..y+2
          sum += calculate_total_power(i, j, serial)
        end
      end
      grid << { pos: [x, y], power: sum }
    end
  end
  return grid
end

def calculate_total_power(x, y, serial)
  power = ((x + 10) * y + serial) * (x + 10)
  power = power.digits[2] || 0
  return power - 5
end

def main
  grid = make_grid(1955)
  puts grid.max_by { |p| p[:power] }
end

main if $0 == __FILE__
