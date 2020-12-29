fields, my_ticket, nearby = File.read('day16_input.txt')
                             .split("\n\n")

fields = fields.split("\n")
               .map { |t| t.match(/\w+: (\d.+)/).captures.first }
               .map { |t| t.split(" or ") }
               .map { |t| t.map { |s| s.split("-").map(&:to_i) } }

allowed_numbers = []

fields.each do |field|
  field.each do |range|
    range.first.upto(range.last) { |n| allowed_numbers << n }
  end
end

nearby = nearby.split("\n")
               .drop(1)
               .map { |t| t.split(",").map(&:to_i) }

errors = Array.new

nearby.each do |ticket|
  ticket.each do |value|
    next if allowed_numbers.include?(value)
    errors << value
  end
end

puts errors.inspect
puts errors.sum
