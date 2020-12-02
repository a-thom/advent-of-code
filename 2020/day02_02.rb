# frozen_string_literal: true

input = File.read('day02_01.txt').lines

regex = /([0-9]+)-([0-9]+) ([a-zA-Z]): (.*)/

valid_passwords = 0

input.each do |line|
  regex.match(line) do |exp|
    pos1 = exp[1].to_i - 1
    pos2 = exp[2].to_i - 1
    letter = exp[3]
    password = exp[4].split(//)

    check = 0

    check += 1 if password[pos1] == letter
    check += 1 if password[pos2] == letter

    valid_passwords += 1 if check == 1
  end
end

puts valid_passwords
