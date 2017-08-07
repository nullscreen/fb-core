require 'spec_helper'

RSpec.describe 'Fb::Page#weekly_metrics' do
  let(:user) { Fb::User.new access_token: ENV['FB_TEST_ACCESS_TOKEN'] }
  let(:page) { user.pages.first  }

  context 'given a page and valid metrics' do
    let(:metrics) { %i(page_impressions page_impressions_paid) }

    it 'returns a hash of given metrics mapped to their values' do
      weekly_metrics = page.weekly_metrics metrics
      expect(weekly_metrics).to be_a(Hash)
      expect(weekly_metrics.keys).to match_array metrics
      expect(weekly_metrics.values).to all (be_an Integer)
    end

    it 'returns metrics mapped to their values if given an until date' do
      weekly_metrics = page.weekly_metrics metrics, until: Date.today - 7
      expect(weekly_metrics.keys).to match_array metrics
    end
  end

  context 'given a page and invalid metrics' do
    let(:metrics) { %i(invalid_metric) }

    it 'raises an HTTPError' do
      expect{page.weekly_metrics metrics}.to raise_error Fb::HTTPError
    end
  end
end
