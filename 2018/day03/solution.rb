# frozen_string_literal: true

def build_claim(string)
  evaluate = string.scan(/^#(\d+)\s+@\s+(\d+),(\d+):\s+(\d+)x(\d+)$/).first
  {
    index: evaluate[0].to_i,
    xpos: evaluate[1].to_i,
    ypos: evaluate[2].to_i,
    xext: evaluate[3].to_i,
    yext: evaluate[4].to_i
  }
end

def fill_canvas(claims)
  canvas = Hash.new(0)
  claims.each do |claim|
    (claim[:xpos]..claim[:xpos] + claim[:xext] - 1).each do |x|
      (claim[:ypos]..claim[:ypos] + claim[:yext] - 1).each do |y|
        canvas[[x, y]] += 1
      end
    end
  end
  canvas
end

def find_intact(claims, canvas)
  claims.each do |claim|
    counter = 0
    (claim[:xpos]..claim[:xpos] + claim[:xext] - 1).each do |x|
      (claim[:ypos]..claim[:ypos] + claim[:yext] - 1).each do |y|
        counter += 1 if canvas[[x, y]] == 1
      end
    end
    return claim[:index] if counter == claim[:xext] * claim[:yext]
  end
end

def overlap_count(canvas)
  canvas.values.select { |i| i > 1 }.count
end

def main
  input = File.read(File.join(File.dirname(__FILE__), './input.txt')).split("\n")
  claims = input.map { |str| build_claim(str) }
  canvas = fill_canvas(claims)
  puts 'Overlap Count:'
  puts overlap_count(canvas)
  puts 'Intact Input:'
  puts find_intact(claims, canvas)
end

main if $0 == __FILE__
