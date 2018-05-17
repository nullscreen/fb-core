require 'spec_helper'

RSpec.describe 'Fb::Post#lifetime_insights' do
  let(:user) { Fb::User.new access_token: ENV['FB_TEST_ACCESS_TOKEN'] }
  let(:page) { user.pages.first }
  let(:post) { page.posts.first }

  context 'given a post and valid metrics' do
    let(:metrics) { %i(post_video_views post_video_view_time) }

    it 'returns a hash of given metrics mapped to their values' do
      lifetime_insights = post.lifetime_insights metrics, page.access_token
      expect(lifetime_insights).to be_a(Hash)
      expect(lifetime_insights.keys).to match_array metrics
      expect(lifetime_insights.values).to all (be_an Integer)
    end
  end

  context 'given a page and invalid metrics' do
    let(:metrics) { %i(invalid_metric) }

    it 'raises an HTTPError' do
      expect{post.lifetime_insights metrics, page.access_token}.to raise_error Fb::HTTPError
    end
  end
end
