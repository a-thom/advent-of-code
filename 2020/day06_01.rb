# frozen_string_literal: true

answers = File.read('day06_input.txt').split("\n\n")
                                        .sum { |s| s.delete("\n")
                                                    .split('')
                                                    .uniq
                                                    .count }


puts answers.inspect
