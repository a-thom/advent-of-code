require 'byebug'

input = File.read('day13_input.txt').lines

time = input.first.to_i
buses = input.last.strip.split(',')
                  .reject { |i| i == 'x' }
                  .map(&:to_i)

Arrival = Struct.new(:wait_time, :bus)
arrivals = []

buses.each do |interval|
  arrivals << Arrival.new(interval - time % interval, interval)
end

first = arrivals.min { |a, b| a.wait_time <=> b.wait_time }

puts first.wait_time * first.bus
