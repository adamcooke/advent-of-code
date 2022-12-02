# frozen_string_literal: true

input = File.read('input.txt')
commands = input.split("\n")

# Part 1
depth = 0
position = 0
commands.each do |cmd|
  command, quantity = cmd.split(' ')
  quantity = quantity.to_i
  case command
  when 'forward'
    position += quantity
  when 'up'
    depth -= quantity
  when 'down'
    depth += quantity
  end
end

puts "Part 1: #{position * depth}"

# Part 2
depth = 0
aim = 0
position = 0
commands.each do |cmd|
  command, quantity = cmd.split(' ')
  quantity = quantity.to_i
  case command
  when 'forward'
    position += quantity
    depth += aim * quantity
  when 'up'
    aim -= quantity
  when 'down'
    aim += quantity
  end
end

puts "Part 2: #{depth * position}"
