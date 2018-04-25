require 'spec_helper'

RSpec.describe 'Fb::Page#videos' do
  let(:user) { Fb::User.new access_token: ENV['FB_TEST_ACCESS_TOKEN'] }
  let(:page) { user.pages.first }

  context 'given a valid access token' do
    it 'returns array of Video for any given page' do
      expect(page.videos).to be_a(Array)
      expect(page.videos).to all (be_a Fb::Video)
      expect(page.videos.map &:id).to all(be_a String)
      expect(page.videos.map &:url).to all(be_a String)
      expect(page.videos.map &:created_at).to all(be_a Time)
      expect(page.videos.map &:length).to all(be_a Float)

      expect(page.videos.map &:comment_count).to all(be_a Integer)
      expect(page.videos.map &:like_count).to all(be_a Integer)
      expect(page.videos.map &:reaction_count).to all(be_a Integer)

      # TODO: Some videos do not return lifetime metrics. We need figure this out.
      # expect(page.videos.map &:total_views).to all (be_an Integer)
      # expect(page.videos.map &:total_views_unique).to all (be_an Integer)
      # expect(page.videos.map &:total_views_autoplayed).to all (be_an Integer)
      # expect(page.videos.map &:total_views_clicked_to_play).to all (be_an Integer)
      # expect(page.videos.map &:total_views_sound_on).to all (be_an Integer)
    end
  end

  context 'given without_lifetime_metrics' do
    it 'returns an array of videos without metrics' do
      expect(page.videos(without_lifetime_metrics: true).map &:id).to all (be_an String)
      expect(page.videos).to be_a(Array)
    end
  end
end
