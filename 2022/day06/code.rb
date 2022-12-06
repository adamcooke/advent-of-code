# frozen_string_literal: true

input = File.read('input.txt')

def find_unique_sequence(input, sequence_length)
  input.size.times do |i|
    chars = input[i, sequence_length].split('')
    next unless chars.uniq.size == sequence_length

    return i + sequence_length
  end
end

puts 'Part 1: ' + find_unique_sequence(input, 4).to_s
puts 'Part 2: ' + find_unique_sequence(input, 14).to_s
