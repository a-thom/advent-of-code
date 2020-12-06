# frozen_string_literal: true

groups = File.read('day06_input.txt').split("\n\n")
                                       .map { |s| s.split("\n")
                                                   .map { |l| l.split('') } }
sum = 0
groups.each do |group|
  letters = group.first
  group.each do |person|
    letters = letters.intersection(person)
  end
  sum += letters.count
end

puts sum
