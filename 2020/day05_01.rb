# frozen_string_literal: true

passes = File.read('day05_input.txt').lines.map { |l| l.strip.split('') }

max_id = 0

passes.each do |pass|
  row_instruction = pass.first(7)
  col_instruction = pass.last(3)

  rows = Array(0..127)
  row_instruction.each do |i|
    if i == 'F'
      rows = rows.take(rows.length/2)
    else
      rows = rows.drop(rows.length/2)
    end
  end

  cols = Array(0..7)
  col_instruction.each do |i|
    if i == 'L'
      cols = cols.take(cols.length/2)
    else
      cols = cols.drop(cols.length/2)
    end
  end
  id = rows.first * 8 + cols.first
  max_id = [max_id, id].max
end

puts max_id



