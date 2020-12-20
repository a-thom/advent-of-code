original_instructions = []

File.read('day08_input.txt').lines.map do |line|
  operation, argument = line.match(/(\w{3}) (.\d+)/)[1, 2]

  instruction = {
    operation: operation,
    argument: argument.to_i,
    used: 'no'
  }
  original_instructions << instruction
end

def run_code(instructions)
  line = 0
  accumulator = 0
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
  if line >= instructions.length - 1
    puts "accumulator: #{accumulator}"
  end
end

original_instructions.length.times do |counter|
  new_instructions = original_instructions.map(&:dup)
  case new_instructions[counter][:operation]
  when 'acc'
    next
  when 'nop'
    new_instructions[counter][:operation] = 'jmp'
  when 'jmp'
    new_instructions[counter][:operation] = 'nop'
  end

  run_code(new_instructions)
end

