# frozen_string_literal: true

input = File.read('input.txt')
rucksacks = input.split("\n")

priorities = {}
(('a'..'z').to_a + ('A'..'Z').to_a).each_with_index { |letter, i| priorities[letter] = 1 + i }

# Part 1
total = 0
rucksacks.each do |contents|
  items = contents.chars
  halves = items.each_slice(items.size / 2).to_a

  items_in_both_halves = halves[0] & halves[1]
  items_in_both_halves.each do |item|
    total += priorities[item]
  end
end
puts "Part 1: #{total}"

# Part 2
total = 0
rucksacks.each_slice(3).each do |group_rucksacks|
  items_in_all_rucksacks = group_rucksacks[0].chars & group_rucksacks[1].chars & group_rucksacks[2].chars
  badge = items_in_all_rucksacks.first
  total += priorities[badge]
end
puts "Part 2: #{total}"
