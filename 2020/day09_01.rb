numbers = File.read('day09_input.txt').lines.map(&:to_i)

preamble = 25

invalid_number = 0

(preamble).upto(numbers.length-1) do |counter|
  number = numbers[counter]
  predecessors = numbers.slice(counter-preamble, preamble)

  if predecessors.combination(2).any? { |combo| combo.sum == number }
    next
  else
    invalid_number = number
    break
  end
end

2.upto(numbers.length) do |len|
  0.upto(numbers.length-len) do |start|
    range = numbers.slice(start, len)
    if range.sum == invalid_number
      puts range.min + range.max
      exit
    end
  end
end
