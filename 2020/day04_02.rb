# frozen_string_literal: true

documents = File.read('day04_input.txt').split("\n\n")

$required_fields = %w[byr iyr eyr hgt hcl ecl pid]
$optional_fields = %w[cid]

valid_documents = 0

def is_valid?(document)
  return false unless $required_fields.all? { |f| document.has_key?(f) }
  return false unless document['byr'].to_i >= 1920 && document['byr'].to_i <= 2002
  return false unless document['iyr'].to_i >= 2010 && document['iyr'].to_i <= 2020
  return false unless document['eyr'].to_i >= 2020 && document['eyr'].to_i <= 2030

  if document['hgt'].end_with?('cm')
    return false unless document['hgt'].to_i >= 150 && document['hgt'].to_i <= 193
  elsif document['hgt'].end_with?('in')
    return false unless document['hgt'].to_i >= 59 && document['hgt'].to_i <= 76
  else
    return false
  end

  return false unless document['hcl'] =~ /\A#[a-f0-9]{6}\Z/
  return false unless %w[amb blu brn gry grn hzl oth].include?(document['ecl'])
  return false unless document['pid'] =~ /\A[0-9]{9}\Z/

  true
end

documents.each do |doc|
  passport = doc.split(/\s+/)
                .map { |d| d.split(':')  }
                .to_h
  valid_documents += 1 if is_valid?(passport)
end

puts valid_documents

