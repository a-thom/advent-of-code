require 'pry'

def build_nodes(numbers)
  node = { meta: [], children: []}
  children_count = numbers.shift
  meta_count = numbers.shift

  children_count.times do
    node[:children] << build_nodes(numbers)
  end

  node[:meta] = numbers.shift(meta_count)
  node
end

def sum_meta(tree)
  meta = tree[:meta] + tree[:children].map { |child| sum_meta(child) }.flatten
  meta.sum
end

def build_valued_nodes(numbers)
  node = { meta: [], children: [], value: 0 }
  children_count = numbers.shift
  meta_count = numbers.shift
  children_count.times do
    node[:children] << build_valued_nodes(numbers)
  end

  node[:meta] = numbers.shift(meta_count)
  if children_count == 0
    node[:value] = node[:meta].sum
  else
    node[:value] = node[:meta].reduce(0) do |sum, meta_num|
      sum + if node[:children][meta_num - 1]
                            node[:children][meta_num - 1][:value]
                          else
                            0
                          end
    end
  end

  node
end

def main
  input = File.read(File.join(File.dirname(__FILE__), './input.txt')).split(' ').map(&:to_i)
  tree = build_nodes(input)
  p sum_meta(tree)
  input = File.read(File.join(File.dirname(__FILE__), './input.txt')).split(' ').map(&:to_i)
  value_tree = build_valued_nodes(input)
  p value_tree
end

main if $0 == __FILE__
