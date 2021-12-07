initial_state = File.read('day17_example.txt').lines.map { |l| l.strip.split('') }

dimension = [initial_state]

puts dimension.inspect

def new_row(size)
  Array.new(size, '.')
end

def new_slice(size)
  Array.new(size) { new_row(size) }
end

def expand(state)
  size = state[0].length + 2
  state.each do |slice|
    slice.each do |row|
      row.unshift('.')
      row << '.'
    end

    slice.unshift(new_row(size))
    slice << new_row(size)
  end
  state.unshift(new_slice(size))
  state << new_slice(size)
end

def neighbors(x, y, z, dimension)

end

dimension = expand(dimension)
