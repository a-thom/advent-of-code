require 'byebug'

fields_raw, my_ticket_raw, nearby_raw = File.read('day16_input.txt')
                             .split("\n\n")

Field = Struct.new(:name, :allowed, :category)
fields = []

fields_raw = fields_raw.split("\n")
fields_raw.each do |field|
  name, ranges = field.match(/([\w\s]+): (\d.+)/).captures
  ranges = ranges.split(" or ")
                 .map { |s| s.split("-").map(&:to_i) }
  allowed = []
  ranges.each do |range|
    range.first.upto(range.last) { |n| allowed << n }
  end
  fields << Field.new(name, allowed)
end

allowed_numbers = fields.inject([]) {|all, hash| all << hash["allowed"]}.flatten

nearby = nearby_raw.split("\n")
               .drop(1)
               .map { |t| t.split(",").map(&:to_i) }

nearby.delete_if do |ticket|
  ticket.any? { |v| allowed_numbers.index(v) == nil }
end

my_ticket = my_ticket_raw.split("\n")
                         .drop(1).first
                         .split(",").map(&:to_i)

# Find out which ticket categories could fit which fields
categories = nearby.transpose
options_per_category = []

categories.each do |category|
  options = []
  fields.each_with_index do |field, index|
    options << index if category.all? { |v| field.allowed.include?(v) }
  end
  options_per_category << options
end

# Find unique assignment of categories to fields
while options_per_category.flatten.any?
  options_per_category.each_with_index do |options, ix|
    if options.length == 1
      choice = options.pop
      options_per_category.map { |a| a.delete(choice) }
      fields[choice].category = ix
    else
      next
    end
  end
end

departures = fields.select { |f| f.name.start_with? ('departure') }
values = departures.map { |d| my_ticket[d.category] }
puts values.inject(:*)





