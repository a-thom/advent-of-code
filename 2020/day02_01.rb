# frozen_string_literal: true

input = File.read('day02_01.txt').lines

regex = /([0-9]+)-([0-9]+) ([a-zA-Z]): (.*)/

valid_passwords = 0

input.each do |line|
  regex.match(line) do |exp|
    min = exp[1].to_i
    max = exp[2].to_i
    letter = exp[3]
    password = exp[4]

    count = password.scan(/#{letter}/).count
    valid_passwords += 1 if min <= count && count <= max
  end
end

puts valid_passwords
