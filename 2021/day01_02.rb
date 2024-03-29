# frozen_string_literal: true

input = File.read('day01_input.txt').lines.map(&:to_i)

p input.each_cons(3).map(&:sum).each_cons(2).count { |a, b| a < b }

