require 'spec_helper'

RSpec.describe 'Fb::Page#insights' do
  context 'given a valid Facebook page with insights data' do
    let(:user) { Fb::User.new access_token: ENV['FB_TEST_ACCESS_TOKEN'] }
    let(:page) { user.pages.first }
    it 'returns a hash of metric names mapped to Fb::Metric objects' do
      insights = page.insights
      metrics = insights.values
      expect(insights.keys).to all(be_a Symbol)
      expect(metrics).to all(be_a Fb::Metric)
      expect(metrics.map &:name).to all(be_a String)
      expect(metrics.map &:period).to all(be_a String)
      expect(metrics.map &:title).to all(be_a String)
      expect(metrics.map &:description).to all(be_a String)
      expect(metrics.map &:id).to all(be_a String)
      metrics.each do |metric|
        expect(metric.values.map &:value).to all(be_a Integer)
        expect(metric.values.map &:end_time).to all(be_a Time)
      end
    end
  end
end
