# frozen_string_literal: true

require_relative 'solution.rb'

describe 'calculate_checksum' do
  it 'returns product of double and triple string counts' do
    result = calculate_checksum(%w[ababa aaabbb cdcdx asdjx])

    expect(result).to eq(4)
  end
end

describe 'find_winner' do
  it 'returns the matching part of the string that differs in 1 char' do
    result = find_winner(%w[asdfa axdfa arxfa bnxfa])

    expect(result).to eq('adfa')
  end
end

describe 'matching_chars' do
  it 'returns first duplicate frequency' do
    result = matching_chars('asdfa', 'axdfa')

    expect(result).to eq('adfa')
  end
end
