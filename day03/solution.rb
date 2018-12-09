def inputs_to_array(source)
  inputs_array = []
  File.open(source).each do |line|
    evaluate = line.scan(/^#(\d+)\s+@\s+(\d+),(\d+):\s+(\d+)x(\d+)$/).first
    p evaluate
    new_hash = {
      xpos: evaluate[1].to_i,
      ypos: evaluate[2].to_i,
      xext: evaluate[3].to_i,
      yext: evaluate[4].to_i
    }
    inputs_array << new_hash
  end
  return inputs_array
end

def get_canvas(inputs)
  max_x = 0
  max_y = 0
  for input in inputs
    new_x = input[:xpos] + input[:xext]
    new_y = input[:ypos] + input[:yext]
    max_x = new_x if new_x > max_x
    max_y = new_y if new_y > max_y
  end
  return { x: max_x, y: max_y }
end

def overlap_count(inputs)
  canvas = get_canvas(inputs)
  puts canvas
end


inputs_array = inputs_to_array('./input.txt')
puts "Overlap Count:"
puts overlap_count(inputs_array)
