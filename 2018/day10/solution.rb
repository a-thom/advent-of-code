def make_points(lines)
  points = []
  lines.each_with_index do |line, index|
    regex = line.scan(/\w+=<\s*(-*\d+),\s*(-*\d+)>/)
    point = {
      x: regex[0][0].to_i,
      y: regex[0][1].to_i,
      mx: regex[1][0].to_i,
      my: regex[1][1].to_i
    }
    points << point
  end
  points
end

def move_points(points)
  points.each do |point|
    point[:x] += point[:mx]
    point[:y] += point[:my]
  end
  points
end

def eval_states(points)
  seconds = 0
  40000.times do
    points = move_points(points)
    max_count_x = points.each_with_object(Hash.new(0)) { |h1, h2| h2[h1[:x]] += 1 }
    max_count_y = points.each_with_object(Hash.new(0)) { |h1, h2| h2[h1[:y]] += 1 }

    min_x = points.min_by{ |p| p[:x]}[:x]
    max_x = points.max_by{ |p| p[:x]}[:x]
    min_y = points.min_by{ |p| p[:y]}[:y]
    max_y = points.max_by{ |p| p[:y]}[:y]

    seconds += 1
    if max_x - min_x < 100 && max_y - min_y < 100
      draw_canvas(points)
      puts seconds
    end
  end

end

def draw_canvas(points)
  min_x = points.min_by{ |p| p[:x]}[:x]
  max_x = points.max_by{ |p| p[:x]}[:x]
  min_y = points.min_by{ |p| p[:y]}[:y]
  max_y = points.max_by{ |p| p[:y]}[:y]

  (min_y..max_y).each do |y|
    (min_x..max_x).each do |x|
      if points.any? {|p| p[:x] == x && p[:y] == y }
        print '#'
      else
        print '.'
      end
    end
    puts
  end
end

def main
  input = File.read(File.join(File.dirname(__FILE__), './input.txt')).split("\n")
  points = make_points(input)
  eval_states(points)
end

main if $0 == __FILE__
