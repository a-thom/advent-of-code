# frozen_string_literal: true

require_relative 'part_one.rb'

describe 'fuel_requirement' do
  let(:input) { [12, 1969] }

  it 'returns the total fuel requirement' do
    expect(fuel_requirement(input)).to eq(656)
  end
end
