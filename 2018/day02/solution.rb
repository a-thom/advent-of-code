# frozen_string_literal: true

def calculate_checksum(input)
  doubles = 0
  triples = 0

  input.each do |string|
    counter = string.split('').each_with_object(Hash.new(0)) { |char, occur| occur[char] += 1 }
    doubles += 1 if counter.value?(2)
    triples += 1 if counter.value?(3)
  end
  doubles * triples
end

def matching_chars(string1, string2)
  chars_a = string1.split('')
  chars_b = string2.split('')
  composite = chars_a.zip(chars_b)
  composite
    .select { |a, b| a == b }
    .map { |a| a[0] }
    .join
end

def find_winner(input)
  input.each_with_index do |string, index|
    comparisons = input.slice(index + 1..input.length - 1)
    comparisons.each do |comp|
      matching = matching_chars(string, comp)
      return matching if matching.length == string.length - 1
    end
  end
end

def main
  input = File.read(File.join(File.dirname(__FILE__), './input.txt'))
  box_ids = input.split("\n")
  puts 'Checksum:'
  puts calculate_checksum(box_ids)
  puts 'Matching Characters:'
  puts find_winner(box_ids)
end

main if $0 == __FILE__
