RSpec.describe 'Fb::Page#insights_with_date_range' do
  let(:user) { Fb::User.new access_token: ENV['FB_TEST_ACCESS_TOKEN'] }
  let(:page) { user.pages.first  }

  context 'given a page and valid metrics' do
    let(:metrics) { %i(page_impressions page_impressions_paid) }

    it 'returns a hash of given metrics mapped to their values' do
      days_of_insights = page.insights_with_date_range metrics, since: Date.today - 21, until: Date.today
      expect(days_of_insights).to be_a(Hash)
      expect(days_of_insights.keys).to match_array metrics
      expect(days_of_insights.values).to all (be_an Integer)
    end
  end

  context 'given a page and invalid metrics' do
    let(:metrics) { %i(invalid_metric) }

    it 'raises an HTTPError' do
      expect do
        page.insights_with_date_range metrics, since: Date.today - 12, until: Date.today
      end.to raise_error Fb::HTTPError
    end
  end
end
