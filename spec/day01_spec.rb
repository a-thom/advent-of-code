# frozen_string_literal: true

require '/Users/anneschneider/dev/advent-of-code/day01/solution.rb'

describe 'inputs_to_array' do
  let(:input) { [1, 2, 3] }
  it 'returns an array' do
    expect(inputs_to_array(input)).to eq([1, 2, 3])
  end

end

