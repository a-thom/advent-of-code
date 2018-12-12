# frozen_string_literal: true

def inputs_to_array(source)
  inputs_array = []
  File.open(source).each do |line|
    evaluate = line.scan(/^#(\d+)\s+@\s+(\d+),(\d+):\s+(\d+)x(\d+)$/).first
    new_hash = {
      index: evaluate[0].to_i,
      xpos: evaluate[1].to_i,
      ypos: evaluate[2].to_i,
      xext: evaluate[3].to_i,
      yext: evaluate[4].to_i
    }
    inputs_array << new_hash
  end
  inputs_array
end

def fill_canvas(inputs)
  canvas = Hash.new(0)
  inputs.each do |input|
    (input[:xpos]..input[:xpos] + input[:xext] - 1).each do |x|
      (input[:ypos]..input[:ypos] + input[:yext] - 1).each do |y|
        canvas[[x, y]] += 1
      end
    end
  end
  canvas
end

def evaluate_canvas(canvas)
  counter = 0
  canvas.each do |_key, value|
    counter += 1 if value > 1
  end
  counter
end

def evaluate_inputs(inputs, canvas)
  inputs.each do |input|
    counter = 0
    (input[:xpos]..input[:xpos] + input[:xext] - 1).each do |x|
      (input[:ypos]..input[:ypos] + input[:yext] - 1).each do |y|
        counter += 1 if canvas[[x, y]] == 1
      end
    end
    return input[:index] if counter == input[:xext] * input[:yext]
  end
end

def overlap_count(inputs)
  canvas = fill_canvas(inputs)
  evaluate_canvas(canvas)
end

def find_intact(inputs)
  canvas = fill_canvas(inputs)
  evaluate_inputs(inputs, canvas)
end

inputs_array = inputs_to_array('./input.txt')
puts 'Overlap Count:'
puts overlap_count(inputs_array)
puts 'Intact Input:'
puts find_intact(inputs_array)
