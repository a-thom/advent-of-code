# frozen_string_literal: true

require_relative 'part_two.rb'

describe 'fuel_requirement' do
  let(:input) { [12, 100756] }

  it 'returns the total fuel requirement' do
    expect(fuel_requirement(input)).to eq(50348)
  end
end
