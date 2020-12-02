# frozen_string_literal: true

def fuel(input)
  mass = input
  total_fuel = 0

  while mass > 0
    fuel = [0, mass/3.floor() - 2].max
    total_fuel = total_fuel + fuel
    mass = fuel
  end
  total_fuel
end

def fuel_requirement(input)
  total_fuel = 0

  input.each do |i|
    total_fuel = total_fuel + fuel(i)
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
