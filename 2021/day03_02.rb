# frozen_string_literal: true

lines = File.read('day03_input.txt').lines.map { |l| l.strip.split("") }
bits_count = lines.first.length

# oxygen generator rating
selected_numbers = lines.dup

(0...bits_count).each do |index|
  bit_values = selected_numbers.transpose[index]
  most_common = bit_values.count("1") >= bit_values.count("0") ? "1" : "0"
  selected_numbers = selected_numbers.reject { |n| n[index] != most_common }

  break if selected_numbers.count == 1
end

oxygen_generator_rating = selected_numbers.first.join.to_i(2)

# CO2 scrubber rating

selected_numbers = lines.dup

(0...bits_count).each do |index|
  bit_values = selected_numbers.transpose[index]
  most_common = bit_values.count("1") >= bit_values.count("0") ? "0" : "1"
  selected_numbers = selected_numbers.reject { |n| n[index] != most_common }

  break if selected_numbers.count == 1
end
p selected_numbers

co2_scrubber_rating = selected_numbers.first.join.to_i(2)

life_support_rating = oxygen_generator_rating * co2_scrubber_rating

p life_support_rating
