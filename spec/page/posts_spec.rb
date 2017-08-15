require 'spec_helper'

RSpec.describe 'Fb::Page#posts' do
  let(:user) { Fb::User.new access_token: ENV['FB_TEST_ACCESS_TOKEN'] }
  let(:page) { user.pages.first }

  context 'given a valid access token' do
    it 'returns array of Post for any given page' do
      expect(page.posts).to be_a(Array)
      expect(page.posts).to all (be_a Fb::Post)
      expect(page.posts.map &:id).to all(be_a String)
      expect(page.posts.map &:type).to all(be_a String)
      expect(page.posts.map &:url).to all(be_a String)
      expect(page.posts.map &:type).to all(be_a String)
      expect(page.posts.map &:created_at).to all(be_a Time)
      expect(page.posts.map &:length).to all(be_a String)
    end
  end

  context 'given time options' do
    let(:options) {{
      since: Time.parse((Date.today - 7).to_s),
      until: Time.parse((Date.today + 1).to_s)
    }}

    it 'returns posts on and between the time options' do
      expect(page.posts(options).map &:created_at).to all (be >= options[:since])
      expect(page.posts(options).map &:created_at).to all (be <= options[:until])
    end
  end

  context 'given with_metrics' do
    it 'returns an array of posts with metrics' do
      expect(page.posts(with_metrics: true).map &:engaged_users).to all (be_an Integer)
      video_posts = page.posts(with_metrics: true).select{|post| post.type == 'video'}
      expect(video_posts.map &:video_views).to all (be_an Integer)
      expect(video_posts.map &:video_views_organic).to all (be_an Integer)
      expect(video_posts.map &:video_views_paid).to all (be_an Integer)
      expect(video_posts.map &:video_view_time).to all (be_an Integer)
    end
  end
end
