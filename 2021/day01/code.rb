# frozen_string_literal: true

input = File.read('input.txt')
depths = input.split("\n").map(&:to_i)

def increases(array)
  array.each_with_index.select do |int, index|
    index.positive? && int > array[index - 1]
  end.size
end

puts "Increases: #{increases(depths)}"
puts "Windowed Increases: #{increases(depths.each_cons(3).to_a.map(&:sum))}"
