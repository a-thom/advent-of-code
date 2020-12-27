require 'byebug'

bitmask = []
mem = {}

File.read('day14_input.txt').lines.map do |line|
  identify, rest = line.strip.match(/(\w+)(.*)/).captures
  case identify
  when 'mask'
    bitmask = rest.match(/ . (\w+)/).captures.first.split('')
  when 'mem'
    address, value = rest.match(/\[(\d+)\] = (\d+)/).captures.map(&:to_i)
    address = address.to_s(2).rjust(36, '0').split('')

    result = bitmask.zip(address).map do |mask, addr|
      if mask == '0'
        addr
      else
        mask
      end
    end
    options = ['0', '1'].repeated_permutation(result.count('X'))
    options.each do |floats|
      addr = result.map(&:dup)
                   .map { |a| a == 'X' ? floats.shift : a }
      mem[addr.sum('').to_i(2)] = value
    end
  end
end
puts mem.values.sum

