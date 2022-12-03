# frozen_string_literal: true

input = File.read('input.txt')
lines = input.split("\n")

totals = []
lines.each do |content|
  bits = content.split('').map(&:to_i)
  bits.each_with_index do |bit, i|
    totals[i] ||= { 0 => 0, 1 => 0 }
    totals[i][bit] += 1
  end
end

gamma_rate = totals.map do |total|
  total.max_by { |_, v| v }.first
end.join.to_i(2)

epsilon_rate = totals.map do |total|
  total.min_by { |_, v| v }.first
end.join.to_i(2)

puts gamma_rate * epsilon_rate
