# frozen_string_literal: true

def get_duplicate(input)
  frequency = 0
  frequencies = Hash.new(0)

  while true
    input.each do |i|
      frequency += i
      frequencies[frequency] += 1
      if frequencies[frequency] == 2
        return frequency
      end
    end
  end
end

def main
  input = File.open(File.join(File.dirname(__FILE__), './input.txt'))
  puts input.inspect
  changes = input.map{ |n| n.to_i }
  puts 'Sum of Frequency Changes:'
  puts changes.sum
  puts 'First Duplicate:'
  puts get_duplicate(changes)
end

if __FILE__ == $0
  main
end
