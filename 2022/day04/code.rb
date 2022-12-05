# frozen_string_literal: true

input = File.read('input.txt')
pairs = input.split("\n").map do |r|
  r.split(',').map do |r|
    Range.new(*r.split('-').map(&:to_i))
  end
end

covering = pairs.select do |pair|
  pair[0].cover?(pair[1]) || pair[1].cover?(pair[0])
end

puts "Part 1: #{covering.size}"

overlaps = pairs.select do |pair|
  !(pair[0].to_a & pair[1].to_a).empty?
end

puts "Part 2: #{overlaps.size}"
