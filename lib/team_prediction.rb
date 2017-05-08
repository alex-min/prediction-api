class TeamPrediction
  def initialize
    config = Rails.application.config_for(:prediction)
    @prediction_sentence = config['sentence']
    @max_cycle = config['max_cycle']
  end

  def winning_probability_of(team1, team2)
    teams = "#{team1}#{team2}".downcase.chars
    probability = compute_initial_probability(teams)
    cycle_count = 0
    while probability.join.to_i > 100
      if cycle_count > @max_cycle
        return 100
      end
      probability = compute_next_probability(probability)
      cycle_count = cycle_count + 1
    end
    probability.join.to_i
  end

  private

  def compute_initial_probability(teams)
    sentence = @prediction_sentence.downcase.chars
    initial = teams.inject(Array.new(sentence.length, 0)) do |letter_count, letter|
      sentence.each_with_index do |sentence_letter, index|
        letter_count[index] += 1 if letter === sentence_letter
      end
      letter_count
    end
  end

  def compute_next_probability(probability)
    result = []
    probability = probability.reverse
    probability.each.with_index do |digit, index|
        next_digit = probability[index + 1]
        next if next_digit == nil
        result.push(digit.to_i + next_digit.to_i)
    end
    result.reverse.join.chars
  end
end