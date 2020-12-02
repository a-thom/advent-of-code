# frozen_string_literal: true

require_relative 'solution.rb'

describe 'make_shifts_array' do
  it 'returns an array of hashes' do
    result = make_shifts_array(['[1518-07-12 00:03] Guard #197 begins shift',
                                '[1518-07-12 00:50] wakes up',
                                '[1518-07-12 00:18] falls asleep',
                                '[1518-07-12 00:45] falls asleep',
                                '[1518-07-12 00:25] wakes up'])
    expect(result).to eq([{ time: Time.new(1518, 7, 12, 0, 3), type: 'guard', guard_id: 197 },
                          { time: Time.new(1518, 7, 12, 0, 18), type: 'falls', guard_id: 0 },
                          { time: Time.new(1518, 7, 12, 0, 25), type: 'wakes', guard_id: 0 },
                          { time: Time.new(1518, 7, 12, 0, 45), type: 'falls', guard_id: 0 },
                          { time: Time.new(1518, 7, 12, 0, 50), type: 'wakes', guard_id: 0 }])
  end
end

describe 'build_guards' do
  it 'returns an array of guards' do
    result = build_guards([{ time: Time.new(1518, 7, 12, 0, 3), type: 'guard', guard_id: 11 },
                           { time: Time.new(1518, 7, 12, 0, 18), type: 'falls', guard_id: 0 },
                           { time: Time.new(1518, 7, 12, 0, 19), type: 'wakes', guard_id: 0 },
                           { time: Time.new(1518, 7, 12, 0, 45), type: 'falls', guard_id: 0 },
                           { time: Time.new(1518, 7, 12, 0, 47), type: 'wakes', guard_id: 0 },
                           { time: Time.new(1518, 7, 22, 0, 1), type: 'guard', guard_id: 12 },
                           { time: Time.new(1518, 7, 22, 0, 10), type: 'falls', guard_id: 0 },
                           { time: Time.new(1518, 7, 22, 0, 12), type: 'wakes', guard_id: 0 },
                           { time: Time.new(1518, 7, 22, 0, 10), type: 'falls', guard_id: 0 },
                           { time: Time.new(1518, 7, 22, 0, 11), type: 'wakes', guard_id: 0 }])

    expect(result[0].id = 11)
    expect(result[0].sleep = 3)
    expect(result[0].minutes = { 18 => 1, 45 => 1, 46 => 1 })
    expect(result[1].id = 12)
    expect(result[1].sleep = 3)
    expect(result[1].minutes = { 10 => 2, 11 => 1 })
  end
end

describe 'get_sleepiest_guard' do
  it 'returns the guard with the highest sleep minute count' do
    guard1 = Guard.new(1)
    guard2 = Guard.new(2)
    guard1.sleep = 2
    guard2.sleep = 3
    result = get_sleepiest_guard([guard1, guard2])

    expect(result).to eq(guard2)
  end
end

describe 'get_minutesleeper_guard' do
  it 'returns the guard with the highest single sleep minute' do
    guard1 = Guard.new(1)
    guard2 = Guard.new(2)
    guard1.minutes = { 18 => 2, 45 => 1, 46 => 6 }
    guard2.minutes = { 20 => 3, 22 => 5, 56 => 10 }
    result = get_minutesleeper_guard([guard1, guard2])

    expect(result).to eq(guard2)
  end
end
