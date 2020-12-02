# frozen_string_literal: true

def fuel_requirement(input)
  total_fuel = 0

  input.each do |i|
    fuel = i/3.floor() - 2
    total_fuel = total_fuel + fuel
  end
  total_fuel
end

def main
  input = File.open(File.join(File.dirname(__FILE__), './input.txt'))
  puts input.inspect
  module_masses = input.map{ |n| n.to_i }
  puts 'Total Fuel Requirement:'
  puts fuel_requirement(module_masses)
end

if __FILE__ == $0
  main
end
