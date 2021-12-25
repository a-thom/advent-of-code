# frozen_string_literal: true

require 'matrix'

def board_sum(board)
  sum = 0
  board.each do |line|
    line.each do |number|
      sum += number unless number == 100
    end
  end
  sum
end

def winner?(board)
  return true if board.map(&:sum).include?(500)
  return true if board.transpose.map(&:sum).include?(500)

  false
end

input = File.read('2021/day04_input.txt').split(/\n{2,}/)

random_numbers = input.shift
                      .split(',')
                      .map(&:to_i)

boards = input.map do |board|
  board.split(/\n/)
       .map do |l|
    l.split(' ')
     .map(&:to_i)
  end
end

random_numbers.each do |number_drawn|
  boards.each do |board|
    position = Matrix[*board].index(number_drawn)

    board[position.first][position.last] = 100 if position.is_a?(Array)
    if winner?(board)
      p board_sum(board) * number_drawn
      exit
    end
  end
end
