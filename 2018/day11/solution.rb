
def make_grid(serial)
  grid = Array.new(300) { Array.new(300) { 0 } }
  for x in 0..299
    for y in 0..299
       grid[x][y] = calculate_total_power(x, y, serial)
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
  max = 0
  max_coord = { x: 0, y: 0, sz: 0 }
  for i in 1..30
    for n in 0..300-i
      for m in 0..300-i
        power = 0
        for x in n..n+i-1
          for y in m..m+i-1
            power += grid[x][y]
          end
        end
        if power > max
          max = power
          max_coord = { x: n, y: m, sz: i }
        end
      end
    end
    print i
    print ' -> '
    print max
    puts max_coord
  end
end

main if $0 == __FILE__
