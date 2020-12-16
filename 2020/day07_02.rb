require 'pry'

rules = []

File.read('day07_input.txt').lines.map do |input|
  children = []
  parent, child_infos = input.match(/(\w+ \w+) bags contain (.*)\./)[1, 2]
  child_infos.split(',').map do |child|
    color = child.match(/(\d|no) (\w+ \w+|other) bag/)[2]
    count = child.match(/(\d|no) (\w+ \w+|other) bag/)[1].to_i

    children << {
      color: color,
      count: count
    }

  end

  rule = {
    parent: parent,
    children: children
  }
  rules << rule
end

 current_bags = [{ color: 'shiny gold', count: 1 }]
 bags_count = 0

while current_bags.any?
  bag = current_bags.shift
  color = bag[:color]
  count = bag[:count]

  bags_count += count

  children = rules.select { |r| r[:parent] == color }.map { |i| i[:children] }.flatten

  children.each do |child|
    current_bags << { color: child[:color], count: count * child[:count] }
  end
end

puts bags_count-1

