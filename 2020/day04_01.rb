# frozen_string_literal: true

documents = File.read('day04_input.txt').split("\n\n")

required_fields = %w[byr iyr eyr hgt hcl ecl pid]
optional_fields = %w[cid]

valid_documents = 0

documents.each do |doc|
  fields = doc.split(/\s+/)
              .map { |d| d.split(':')  }
              .to_h
  valid_documents += 1 if required_fields.all? { |f| fields.has_key?(f) }
end

puts valid_documents

