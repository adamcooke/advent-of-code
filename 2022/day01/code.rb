# frozen_string_literal: true

data = File.read('input.txt')
elfs = data.split("\n\n").map { |s| s.split("\n").map(&:to_i).sum }.sort
puts "Top elf: #{elfs.last}"
puts "Top 3 elfs: #{elfs.last(3).sum}"
