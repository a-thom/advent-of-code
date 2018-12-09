def inputs_to_array(source)
  inputs_array = []
  File.open(source).each do |line|
    evaluate = line.scan(/^#(\d+)\s+@\s+(\d+),(\d+):\s+(\d+)x(\d+)$/).first
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

def fill_canvas(inputs)
  canvas = Hash.new(0)
  for input in inputs do
    for x in (input[:xpos]..input[:xpos] + input[:xext]-1)
      for y in (input[:ypos]..input[:ypos] + input[:yext]-1)
        canvas[[x, y]] += 1
      end
    end
  end
  return canvas
end

def evaluate_canvas(canvas)
  counter = 0
  canvas.each do |key, value|
    if value > 1
      counter += 1
    end
  end
  return counter
end

def overlap_count(inputs)
  canvas = fill_canvas(inputs)
  return evaluate_canvas(canvas)
end


inputs_array = inputs_to_array('./input.txt')
puts "Overlap Count:"
puts overlap_count(inputs_array)
