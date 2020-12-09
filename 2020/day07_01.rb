rules = []

inputs = File.read('day07_input.txt').lines.map do |input|
  parent, children = input.match(/(\w+ \w+) bags contain (.*)\./)[1, 2]
  children = children.split(',').map { |c| c.match(/(\d|no) (\w+ \w+|other) bag/)[2] }

  rule = {
    parent: parent,
    children: children
  }
  rules << rule
end

current_bags = ['shiny gold']
all_bags = []

while current_bags.any? do
  current_bags.each do |bag|
    current_bags += rules.select { |r| r[:children].include?(bag) }.collect { |i| i[:parent] }

    current_bags.delete(bag)
    all_bags << bag
  end
end

puts all_bags.uniq.length - 1
