# frozen_string_literal: true
require 'pry'

def parse(lines)
  steps = Hash.new { |h,k| h[k] = [] }
  lines.each do |line|
    prereq, step = line.scan(/\s(\w)\s/).map(&:first)
    steps[step] << prereq
  end

  listed_steps = steps.map{ |key, value| key }
  prereqs = steps.flat_map{ |key, value| value }.uniq
  first_steps = (prereqs - listed_steps)
  first_steps.each do |step|
    steps[step] = []
  end
  steps
end

def process(steps)
  to_do = steps.map{ |key, value| key }
  done = Array.new
  until to_do.empty?
    open_steps = steps.select { |_, value| value == [] }.map { |k, _| k }.sort - done
    doing = open_steps.shift
    steps.each do |key, value|
      value.delete(doing)
    end
    to_do.delete(doing)
    done << doing
  end
  done.join
end

def main
  input = File.read(File.join(File.dirname(__FILE__), './input.txt')).split("\n")
  steps = parse(input)
  puts process(steps)
end

main if $0 == __FILE__
