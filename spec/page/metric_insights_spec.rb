require 'spec_helper'

RSpec.describe 'Fb::Page#metric_insights' do
  let(:user) { Fb::User.new access_token: ENV['FB_TEST_ACCESS_TOKEN'] }
  let(:page) { user.pages.first }
  let(:metric) { 'page_views_total' }

  context 'given a valid metric and period' do
    it 'returns a hash of Dates mapped to their values' do
      metric_insights = page.metric_insights metric, :day
      expect(metric_insights).to be_a(Hash)
      expect(metric_insights.keys).to all (be_an Date)
      expect(metric_insights.values).to all (be_an Integer)
    end
  end

  context 'given a since date' do
    let(:since_date) { Date.today - 7 }
    it 'returns a hash that starts one day ahead of since date (lower bound)' do
      metric_insights = page.metric_insights metric, :day, since: since_date
      expect(metric_insights.keys.first).to eq (since_date + 1)
    end
  end

  context 'given a since date and until date' do
    let(:options) { {since: Date.today - 9, until: Date.today} }
    it 'returns a hash that contains the dates in between' do
      metric_insights = page.metric_insights metric, :day, options
      expect(metric_insights.keys.first).to eq (options[:since] + 1)
      expect(metric_insights.keys.last).to eq (options[:until] - 1)
    end
  end

  context 'given invalid metrics' do
    it 'raises an HTTPError' do
      expect{page.metric_insights 'invalid_metric', :day}.to raise_error Fb::HTTPError
    end
  end
end

