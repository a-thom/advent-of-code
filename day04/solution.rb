# frozen_string_literal: true

class Guard
  def initialize(id)
    @id = id
    @sleep = 0
    @minutes = Hash.new(0)
  end

  attr_accessor :id
  attr_accessor :sleep
  attr_accessor :minutes

  def add_sleep(start_time, end_time)
    @sleep += (end_time - start_time)
    (start_time..end_time - 1).each do |sleep_minute|
      increase_minute(sleep_minute)
    end
  end

  def increase_minute(input)
    @minutes[input] += 1
  end

  def find_max_minute
    @minutes.max_by { |_key, value| value } || [0, 0]
  end
end

def make_shifts_array(input)
  shifts = []
  input.each do |line|
    parts = line.scan(/^\[(\d+)-(\d+)-(\d+)\s(\d+):(\d+)\]\s(\w+)\s*#*(\d*)\s(\w*)/).first
    shift = {
      time: Time.new(parts[0], parts[1], parts[2], parts[3], parts[4]),
      type: parts[5].downcase,
      guard_id: parts[6].to_i
    }
    shifts << shift
  end
  shifts.sort_by! { |hash| hash[:time] }
end

def build_guards(shifts)
  guard = Guard.new(0)
  guards = []
  start_minutes = 0
  end_minutes = 0
  shifts.each do |shift|
    if shift[:type] == 'guard'
      existing = guards.select { |guard| guard.id == shift[:guard_id] }
      if existing.empty?
        guard = Guard.new(shift[:guard_id])
        guards << guard
      else
        guard = existing.first
      end
    elsif shift[:type] == 'falls'
      start_minutes = shift[:time].min
    elsif shift[:type] == 'wakes'
      end_minutes = shift[:time].min
      guard.add_sleep(start_minutes, end_minutes)
    else
      puts 'shift type error'
    end
  end
  guards
end

def get_sleepiest_guard(guards)
  guards.max_by { |g| g.sleep }
end

def get_minutesleeper_guard(guards)
  guards.max_by { |g| g.find_max_minute }
end

def main
  input = File.read(File.join(File.dirname(__FILE__), './input.txt')).split("\n")
  shifts = make_shifts_array(input)
  guards = build_guards(shifts)
  winner = get_sleepiest_guard(guards)
  winner2 = get_minutesleeper_guard(guards)
  minute = winner.find_max_minute.first
  puts 'Sleepiest guard (id)'
  puts winner.id
  puts 'His worst minute'
  puts minute
  puts 'Result part 1'
  puts winner.id * minute
  puts 'Result part 2'
  puts winner2.id * winner2.find_max_minute.first
end

main if $0 == __FILE__
