class Guard
  def initialize(id)
    @id = id
    @sleep = 0
    @minutes = Hash.new(0)
  end

  def id
    @id
  end

  def sleep
    @sleep
  end

  def minutes
    @minutes
  end

  def add_sleep(start_time, end_time)
    @sleep += (end_time - start_time)
    for sleep_minute in start_time..end_time-1
      increase_minute(sleep_minute)
    end
  end

  def increase_minute(input)
    value = @minutes[input]
    value += 1
    @minutes[input] = value
  end

  def find_max_minute
    @minutes.max_by{|key, value| value}.first
  end
end

def inputs_to_array(source)
  inputs_array = []
  File.open(source).each do |line|
    evaluate = line.scan(/^\[(\d+)-(\d+)-(\d+)\s(\d+):(\d+)\]\s(\w+)\s*#*(\d*)\s(\w*)/).first
    date_time = Time.new(evaluate[0], evaluate[1], evaluate[2], evaluate[3], evaluate[4])
    if evaluate[5] == 'wakes'
      type = 'wakes'
    elsif evaluate[5] == 'falls'
      type = 'sleeps'
    else
      type = 'guard'
    end
    new_hash = {
      time: date_time,
      type: type,
      guard_id: evaluate[6].to_i
    }
    inputs_array << new_hash
  end
  return inputs_array.sort_by!{ |hash| hash[:time] }
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
    elsif shift[:type] == 'sleeps'
      start_minutes = shift[:time].min
    elsif shift[:type] == 'wakes'
      end_minutes = shift[:time].min
      guard.add_sleep(start_minutes, end_minutes)
    else
      puts 'shift type error'
    end
  end
  return guards
end

def get_sleepiest(guards)
  max = 0

  for guard in guards
    if guard.sleep > max
      max = guard.sleep
      winner = guard
    end
  end
  return winner
end

shifts_array = inputs_to_array('./input.txt')
guards = build_guards(shifts_array)
winner = get_sleepiest(guards)
minute = winner.find_max_minute
puts 'Sleepiest guard (id)'
puts winner.id
puts 'His worst minute'
puts minute
puts 'Result part 1'
puts winner.id * minute

