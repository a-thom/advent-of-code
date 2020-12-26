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
    value = value.to_s(2).rjust(36, '0').split('')

    result = bitmask.zip(value).map do |mask, val|
      if mask == 'X'
        val
      else
        mask
      end
    end
    mem[address] = result
  end
end
puts mem.values.inject(0) { |sum, val| sum + val.sum('').to_i(2) }

