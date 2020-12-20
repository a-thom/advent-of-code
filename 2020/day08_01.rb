instructions = []
line = 0
accumulator = 0

File.read('day08_input.txt').lines.map do |line|
  operation, argument = line.match(/(\w{3}) (.\d+)/)[1, 2]

  instruction = {
    operation: operation,
    argument: argument.to_i,
    used: 'no'
  }
  instructions << instruction
end

while line < instructions.length
  instruction = instructions[line]

  if instruction[:used] == 'yes'
    break
  else
    instruction[:used] = 'yes'
  end

  argument = instruction[:argument]

  case instruction[:operation]
  when 'acc'
    accumulator += argument
    line += 1
  when 'jmp'
    line += argument
  when 'nop'
    line += 1
  else
    puts 'unexpected operation'
  end
end

puts "accumulator: #{accumulator}"
