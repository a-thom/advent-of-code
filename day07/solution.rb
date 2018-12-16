# frozen_string_literal: true
require 'pry'

def parse(lines)
  steps = Hash.new { |h,k| h[k] = [] }
  lines.each do |line|
    prereq, step = line.scan(/\s(\w)\s/).map(&:first)
    steps[step] << prereq
  end

  listed_steps = steps.map{ |key, value| key }
  prereqs = steps.flat_map{ |key, value| value }.uniq
  first_steps = (prereqs - listed_steps)
  first_steps.each do |step|
    steps[step] = []
  end
  steps
end

def process(steps)
  to_do = steps.map{ |key, value| key }
  done = Array.new
  until to_do.empty?
    open_steps = steps.select { |_, value| value == [] }.map { |k, _| k }.sort - done
    doing = open_steps.shift
    steps.each do |key, value|
      value.delete(doing)
    end
    to_do.delete(doing)
    done << doing
  end
  done.join
end

def multi_thread(steps)
  workers = Array.new
  number_of_workers = 5
  (1..number_of_workers).each do |n|
    workers << {
      index: n, job: nil, remaining: 0
    }
  end
  to_do = steps.map{ |key, value| key }
  done = Array.new
  doing = Array.new
  seconds_passed = 0
  until (to_do + doing).empty?
    finished_work = workers.find_all { |w| !w[:job].nil? && w[:remaining].zero? }
    finished_work.each do |work|
      finished_job = work[:job]
      work[:job] = nil
      steps.each do |key, value|
        value.delete(finished_job)
      end
      doing.delete(finished_job)
      done << finished_job
    end

    open_steps = steps.select { |_, value| value == [] }.map { |k, _| k }.sort - done - doing
    free_workers = workers.find_all { |w| w[:job].nil? }

    while open_steps.any? && free_workers.any?
      free_worker = free_workers.shift
      open_step = open_steps.shift
      to_do.delete(open_step)
      doing << open_step
      free_worker[:job] = open_step
      free_worker[:remaining] = open_step.ord - 'A'.ord + 61
    end

    seconds_passed += 1
    workers.each { |w| w[:remaining] -= 1 if !w[:job].nil? }
  end
  seconds_passed - 1
end

def main
  input = File.read(File.join(File.dirname(__FILE__), './input.txt')).split("\n")
  steps = parse(input)
  puts process(steps)
  steps = parse(input)
  puts multi_thread(steps)
end

main if $0 == __FILE__
