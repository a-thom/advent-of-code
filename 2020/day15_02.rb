numbers = [0,1,5,10,3,12,19]
occurrences = Hash.new { |h, k| h[k] = [] }

numbers.each_with_index { |number, index| occurrences[number].unshift(index + 1) }
last_number = numbers.last

8.upto(30000000) do |round|
  occ = occurrences[last_number]
  if occ.length == 1
    new_number = 0
  else
    new_number = occurrences[last_number][0]-occurrences[last_number][1]
  end
  occurrences[new_number].unshift(round)
  last_number = new_number
end

puts last_number

