# frozen_string_literal: true

def chemical_reaction(polymer)
  loop do
    prev_length = polymer.length

    polymer.gsub!(/([A-z])\1+/i) do |pair|
      char = pair[0].downcase
      option1 = char + char.upcase
      option2 = char.upcase + char

      pair.gsub(option1, '').gsub(option2, '')
    end

    break if polymer.length == prev_length
  end
  polymer
end

def get_optimal(polymer)
  min_reacted = polymer.length
  ('a'..'z').each do |letter|
    new_poly = polymer.gsub(/([#{Regexp.escape(letter)}])/i, '')
    reacted = chemical_reaction(new_poly)
    min_reacted = [reacted.length, min_reacted].min
  end
  min_reacted
end

def main
  polymer = File.read(File.join(File.dirname(__FILE__), './input.txt')).strip
  reacted_polymer = chemical_reaction(polymer)
  puts 'Part1'
  puts reacted_polymer.length
  new_polymer = File.read(File.join(File.dirname(__FILE__), './input.txt')).strip
  new_reacted = get_optimal(new_polymer)
  puts 'Part2'
  puts new_reacted
end

main if $0 == __FILE__
