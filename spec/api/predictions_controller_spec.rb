RSpec.describe 'Api prediction endpoint' do
  before(:each) do
    visit "#{api_prediction_path}?#{query.to_query}"
  end
  let(:subject) { JSON.parse(page.body) }

  context 'without parameters' do
    let(:query) { {} }    
    it 'returns bad request http status' do
      expect(page.status_code).to eq(400)
      is_expected.to eq('Please provide teams as a query parameters')
    end
  end

  context 'with invalid parameters' do
    let(:query) { {teams: %{team1 team2 team3} } }  
    it 'returns bad request http status' do
      expect(page.status_code).to eq(400)
      is_expected.to eq('Please provide two teams to get the winning probability')
    end
  end

  context 'with two teams' do
    let(:query) { {teams: ['Virtus.pro', 'Ninjas in Pyjamas']} }
    it 'should return 24 as per the example' do
      expect(page.status_code).to eq(200)
      is_expected.to eq(24)
    end
  end
end
