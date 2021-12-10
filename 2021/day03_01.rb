# frozen_string_literal: true

columns = File.read('day03_input.txt').lines.map { |l| l.strip.split("") }.transpose

gamma = columns.map{ |c| c.max_by { |i| c.count(i) } }.join.to_i(2)
epsilon = columns.map{ |c| c.min_by { |i| c.count(i) } }.join.to_i(2)

p gamma * epsilon
