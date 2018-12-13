# frozen_string_literal: true

require_relative 'solution.rb'

describe 'get_duplicate' do
  let(:input) { [1, 2, +1, -1] }

  it 'returns first duplicate frequency' do
    expect(get_duplicate(input)).to eq(3)
  end
end
