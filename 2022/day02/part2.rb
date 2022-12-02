# frozen_string_literal: true

input = File.read('input.txt')
games = input.split("\n")

outcomes = %i[rock paper scissors]
outcomes_data = outcomes.each_with_index.each_with_object({}) do |(outcome, index), memo|
  memo[outcome] = {
    points: index + 1,
    winner: outcomes.rotate(index + 1)[0],
    loser: outcomes.rotate(index + 2)[0]
  }
end

score = 0
games.each do |game|
  their_play, desired_outcome = game.split(' ')
  their_play = outcomes[their_play.bytes[0] - 65] # Map A, B, C to integer

  case desired_outcome
  when 'X' # Loss
    our_play = outcomes_data[their_play][:loser]
  when 'Y' # Draw
    our_play = their_play
    score += 3
  when 'Z' # Win
    our_play = outcomes_data[their_play][:winner]
    score += 6
  end

  score += outcomes_data[our_play][:points]
end

puts score
