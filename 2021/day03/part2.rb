# frozen_string_literal: true

input = File.read('input.txt')
lines = input.split("\n")

all_lines = lines.map { |line| line.split('').map(&:to_i) }

def decode(lines, index, operation)
  all = lines.map { |i| i[index] }
  number_of_ones = all.count(1)
  number_of_zeros = all.count(0)
  if operation == :most_common
    desired_bit = if number_of_ones == number_of_zeros
                    1
                  elsif number_of_ones > number_of_zeros
                    1
                  else
                    0
                  end
  elsif operation == :least_common
    desired_bit = if number_of_ones == number_of_zeros
                    0
                  elsif number_of_ones > number_of_zeros
                    0
                  else
                    1
                  end
  end
  lines.select { |i| i[index] == desired_bit }
end

def calculate(lines, operation)
  i = 0
  loop do
    lines = decode(lines, i, operation)
    return lines[0].join.to_i(2) if lines.size == 1

    i += 1
  end
end

oxygen_generator = calculate(all_lines, :most_common)
co2_scrubber = calculate(all_lines, :least_common)

puts oxygen_generator * co2_scrubber
