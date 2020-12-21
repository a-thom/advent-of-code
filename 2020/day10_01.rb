adapters = File.read('day10_input.txt').lines.map(&:to_i)

built_in = adapters.max + 3
outlet = 0

all = adapters + [built_in] + [outlet]
all = all.sort

differences = [0, 0, 0]

0.upto(all.length-2) do |index|
  difference = all[index+1] - all[index]
  differences[difference-1] += 1
end

puts differences[0] * differences[2]
