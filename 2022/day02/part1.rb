# frozen_string_literal: true

input = File.read('input.txt')
games = input.split("\n")

types = {
  paper: [2, :rock],
  scissors: [3, :paper],
  rock: [1, :scissors]
}

def letter_to_type(letter)
  case letter
  when 'A', 'X'
    :rock
  when 'B', 'Y'
    :paper
  when 'C', 'Z'
    :scissors
  end
end

score = 0
games.each do |game|
  other, ours = game.split(' ').map { |x| letter_to_type(x) }
  initial_score, hand_required_to_win = types[ours]
  score += initial_score

  if other == ours
    score += 3
    next
  end

  if other == hand_required_to_win
    score += 6
    next
  end
end

puts score
