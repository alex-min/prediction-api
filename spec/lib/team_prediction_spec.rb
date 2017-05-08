require 'team_prediction'

RSpec.describe TeamPrediction, '#winning_probability_of' do
  let(:subject) { described_class.new.winning_probability_of(team1, team2) }

  context 'with example example data' do
    let(:team1) { 'Virtus.pro' }
    let(:team2) { 'Ninjas in Pyjamas' }
    
    it 'should return 24 as per the example' do
      is_expected.to eq(24)
    end
  end

  context 'unsolvable probability' do
    let(:team1) { 'defeats' }
    let(:team2) { 'defeats' }

    it 'should return 100 as the probability is unsolvable' do
      is_expected.to eq(100)
    end
  end

  context 'with empty data' do
    let(:team1) { '' }
    let(:team2) { '' }

    it 'should return 0% winning probability' do
      is_expected.to eq(0)
    end
  end
end