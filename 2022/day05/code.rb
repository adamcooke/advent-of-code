# frozen_string_literal: true

input = File.read('input.txt')
positions_string, steps_string = input.split("\n\n", 2)

# Parse a string of initial positions from a string into a hash of stacks
# with the current positions for all crates.
def parse_initial_positions(positions_string)
  positions = positions_string.split("\n")
  stack_numbers = positions.pop.split(' ').map(&:to_i)
  total_stacks = stack_numbers.size
  stacks = {}
  total_stacks.times do |i|
    index = (i * 4) + 1
    stack = []
    positions.each do |pos|
      item = pos[index, 1]
      next if item.nil? || item.strip.size == 0

      stack << item
    end
    stacks[i + 1] = stack
  end
  stacks
end

# Iterates through the given steps and moves items around on the
# stacks. The crane model defines how the crane moves and picks up
# the creates (either individually (model 9000) or in groups
# (model 9001).
def move_items(steps, stacks, crane_model)
  steps.each do |step|
    _, quantity, _, source, _, destiation = step.split(' ', 6).map(&:to_i)
    removed_items = stacks[source].shift(quantity)
    removed_items = removed_items.reverse if crane_model == 9000
    stacks[destiation].prepend(*removed_items)
  end
end

# Get the steps into an array
steps = steps_string.split("\n")

# Part 1
part1_stack = parse_initial_positions(positions_string)
move_items(steps, part1_stack, 9000)
puts 'Part 1: ' + part1_stack.values.map(&:first).join

# Part 2
part2_stack = parse_initial_positions(positions_string)
move_items(steps, part2_stack, 9001)
puts 'Part 2: ' + part2_stack.values.map(&:first).join
