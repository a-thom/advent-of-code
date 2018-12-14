require_relative 'solution.rb'

describe 'make_map' do
  it 'returns map matrix from positions' do
    result = make_map([{ :x => 1, :y => 1 },
                       { :x => 1, :y => 6 },
                       { :x => 8, :y => 3 },
                       { :x => 3, :y => 4 },
                       { :x => 5, :y => 5 },
                       { :x => 8, :y => 9 }])

    expect(result).to eq(1)
  end
end
