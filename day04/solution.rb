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
    start_minutes = start_time.min
    end_minutes = end_time.min
    @sleep += (end_minutes - start_minutes)
    for sleep_minute in start_minutes..end_minutes-1
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
  guards = []
  for n in 0..shifts.length-1
    if shifts[n][:type] == 'guard'
      new_guard = Guard.new(shifts[n][:guard_id])
      increase = 1
      while n + increase < shifts.length && shifts[n + increase][:type] == 'sleeps' && shifts[n + increase + 1][:type] == 'wakes'
        new_guard.add_sleep(shifts[n + increase][:time], shifts[n + increase + 1][:time])
        increase +=2
      end
      guards << new_guard
      n += increase
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
puts winner.inspect
minute = winner.find_max_minute
puts minute
puts winner.id * minute

