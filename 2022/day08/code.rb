# frozen_string_literal: true

input = File.read('input.txt')

class Forest
  def initialize(input)
    @input = input
  end

  def visibility(position)
    directions = []
    row, col = position
    directions << :top_edge if row == 0
    directions << :left_edge if col == 0
    directions << :bottom_edge if row == rows.size - 1
    directions << :right_edge if col == cols.size - 1
    height = tree_height(position)
    directions << :from_left if heights_to_the_left_of_position(position).all? { |h| h < height }
    directions << :from_right if heights_to_the_right_of_position(position).all? { |h| h < height }
    directions << :from_top if heights_to_the_top_of_position(position).all? { |h| h < height }
    directions << :from_bottom if heights_to_the_bottom_of_position(position).all? { |h| h < height }
    directions
  end

  def heights_to_the_left_of_position(position)
    row, col = position
    col.times.map { |c| tree_height([row, c]) }.reverse
  end

  def heights_to_the_right_of_position(position)
    row, col = position
    (cols.size - col - 1).times.map { |c| tree_height([row, cols.size - 1 - c]) }.reverse
  end

  def heights_to_the_top_of_position(position)
    row, col = position
    row.times.map { |r| tree_height([r, col]) }.reverse
  end

  def heights_to_the_bottom_of_position(position)
    row, col = position
    (rows.size - row - 1).times.map { |r| tree_height([rows.size - 1 - r, col]) }.reverse
  end

  def tree_height(position)
    row, col = position
    rows[row][col].to_i
  end

  def trees
    @trees ||= begin
      positions = []
      rows.each_with_index do |_, row|
        cols.each_with_index do |_, col|
          positions << [row, col]
        end
      end
      positions
    end
  end

  private

  def rows
    @rows ||= @input.split("\n")
  end

  def cols
    @cols ||= rows[0].length.times.map do |i|
      rows.map do |r|
        r[i]
      end.join
    end
  end
end

def trees_to_height(heights, max)
  return [] if heights.empty?

  visible = []
  heights.each do |height|
    visible << height

    return visible if height >= max
  end
  visible
end

forest = Forest.new(input)
visible = 0
forest.trees.each do |position|
  directions = forest.visibility(position)
  next if directions.empty?

  visible += 1
end

puts 'Part 1: ' + visible.to_s

scenic_scores = forest.trees.map do |position|
  height = forest.tree_height(position)

  to_left = forest.heights_to_the_left_of_position(position)
  to_left = trees_to_height(to_left, height)

  to_right = forest.heights_to_the_right_of_position(position)
  to_right = trees_to_height(to_right, height)

  to_top = forest.heights_to_the_top_of_position(position)
  to_top = trees_to_height(to_top, height)

  to_bottom = forest.heights_to_the_bottom_of_position(position)
  to_bottom = trees_to_height(to_bottom, height)

  to_left.size * to_right.size * to_top.size * to_bottom.size
end

puts "Part 2: #{scenic_scores.max}"
