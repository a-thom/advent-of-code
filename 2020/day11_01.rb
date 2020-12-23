require 'byebug'

floor_plan = File.read('day11_input.txt').lines.map { |l| l.strip.split('') }
puts floor_plan.inspect

while true do
  new_plan = floor_plan.map(&:dup)

  floor_plan.each_with_index do |row, y|
    row.each_with_index do |spot, x|
      next if spot == '.'

      neighbours = [x - 1, x, x + 1].product([y - 1, y, y + 1])
        .reject { |i, j| i == x && j == y }
        .select { |i, j| (0..floor_plan.size-1).cover?(i) && (0..floor_plan[0].size-1).cover?(j) }

      occupied = neighbours.count { |i, j| floor_plan[j][i] == '#' }

      case spot
      when '#'
        new_plan[y][x] = 'L' if occupied >= 4
      when 'L'
        new_plan[y][x] = '#' if occupied == 0
      end
    end
  end

  puts new_plan.inspect

  if new_plan == floor_plan
    break
  else
    floor_plan = new_plan.map(&:dup)
  end
end


puts floor_plan.flatten.count { |seat| seat == '#' }
