# frozen_string_literal: true

require_relative 'solution.rb'

describe 'build_claim' do
  it 'returns a claim hash for a given string' do
    result = build_claim('#34 @ 518,637: 26x25')

    expect(result).to eq(
      index: 34,
      xpos: 518,
      ypos: 637,
      xext: 26,
      yext: 25
    )
  end
end

describe 'fill_canvas' do
  it 'returns hash with claimed areas' do
    result = fill_canvas([
      {index: 1, xpos: 1, ypos: 1, xext: 2, yext: 2},
      {index: 2, xpos: 2, ypos: 2, xext: 2, yext: 2},
      {index: 3, xpos: 3, ypos: 3, xext: 1, yext: 1}
    ])
    expect(result).to eq({  [1, 1] => 1, [1, 2] => 1,
                            [2, 1] => 1, [2, 2] => 2, [2, 3] => 1,
                            [3, 2] => 1, [3, 3] => 2 })
  end
end

describe 'overlap_count' do
  it 'counts canvas parts with several claims' do
    result = overlap_count([1, 1] => 1, [1, 2] => 1,
                           [2, 1] => 1, [2, 2] => 2, [2, 3] => 1,
                           [3, 2] => 1, [3, 3] => 2)

    expect(result).to eq(2)
  end
end

describe 'find_intact' do
  it 'returns the index of a claim that does not overlap' do
    result = find_intact([{index: 1, xpos: 1, ypos: 1, xext: 2, yext: 1},
                          {index: 2, xpos: 2, ypos: 2, xext: 2, yext: 2},
                          {index: 3, xpos: 3, ypos: 3, xext: 1, yext: 1}],
                          {[1, 1] => 1, [1, 2] => 1,
                           [2, 1] => 1, [2, 2] => 2, [2, 3] => 1,
                           [3, 2] => 1, [3, 3] => 2 })

    expect(result).to eq(1)
  end
end

