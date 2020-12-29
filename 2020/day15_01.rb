numbers = [0,1,5,10,3,12,19]

8.upto(2020) do
  number = numbers.last
  occurrences = numbers.map.with_index { |n, i| i+1 if n == number }.compact

  if occurrences.length == 1
    numbers << 0
  else
    numbers << occurrences.reverse[0].to_i - occurrences.reverse[1].to_i
  end
end

puts numbers.last

