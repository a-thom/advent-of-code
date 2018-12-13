require_relative 'solution.rb'

describe 'chemical_reaction' do
  it 'removes pairs of upper- and lowercase letters from string' do
    result = chemical_reaction('aAbcdefFxadCc')

    expect(result).to eq('bcdexad')
  end
end

describe 'get_optimal' do
  it 'returns the smallest possible string through first removing one char' do
    result = get_optimal('aAbcdefFxadCc')

    expect(result).to eq('bcexa'.length)
  end
end
