adapters = File.read('day10_input.txt').lines.map(&:to_i)

built_in = adapters.max + 3
outlet = 0

all = adapters + [built_in] + [outlet]
all = all.sort

puts 'All adapters:'
puts all.inspect

consequtives = Hash.new(0)
cons = 1
ix = 0

while ix < all.length - 1 do
  while all[ix + 1] - all[ix] == 1
    cons += 1
    ix += 1
  end

  if cons > 1
    consequtives[cons] += 1
  end
  cons = 1
  ix += 1
end

puts 'count consequitive streaks:'
puts consequtives
puts 'combinations:'
puts 2 ** consequtives[3] * 4 ** consequtives[4] * 7 ** consequtives[5]
