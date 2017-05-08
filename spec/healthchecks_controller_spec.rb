require 'pry'
RSpec.describe 'Healthcheck' do
  let(:subject) { JSON.parse(page.body) }

  context 'healthcheck is called' do
    before { visit healthcheck_path }

    it 'should return "ok"' do
      is_expected.to eq('ok')
      expect(page.status_code).to eq(200)
    end
  end
end
