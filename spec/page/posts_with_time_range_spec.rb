RSpec.describe 'Fb::Page#posts_with_time_range' do
  let(:user) { Fb::User.new access_token: ENV['FB_TEST_ACCESS_TOKEN'] }
  let(:page) { user.pages.first }
  let(:options) {{
    since: Time.parse((Date.today - 7).to_s),
    until: Time.parse((Date.today + 1).to_s)
  }}

  context 'given a valid access token' do
    it 'returns array of Post for any given page' do
      days_of_posts = page.posts_with_time_range(options)
      expect(days_of_posts).to be_a(Array)
      expect(days_of_posts).to all (be_a Fb::Post)
      expect(days_of_posts.map &:id).to all(be_a String)
      expect(days_of_posts.map &:type).to all(be_a String)
      expect(days_of_posts.map &:url).to all(be_a String)
      expect(days_of_posts.map &:type).to all(be_a String)
      expect(days_of_posts.map &:created_at).to all(be_a Time)
      expect(days_of_posts.map &:length).to all(be_a String)

      expect(days_of_posts.map &:share_count).to all(be_a Integer)
      expect(days_of_posts.map &:comment_count).to all(be_a Integer)
      expect(days_of_posts.map &:like_count).to all(be_a Integer)
      expect(days_of_posts.map &:reaction_count).to all(be_a Integer)

      expect(days_of_posts.map &:created_at).to all (be >= options[:since])
      expect(days_of_posts.map &:created_at).to all (be <= options[:until])
    end
  end

  context 'given with_metrics' do
    it 'returns an array of posts with metrics' do
      days_of_video_posts = page.posts_with_time_range(options.merge with_metrics: true).select{|post| post.type == 'video'}
      expect(days_of_video_posts.map &:video_views).to all (be_an Integer)
      expect(days_of_video_posts.map &:video_views_organic).to all (be_an Integer)
      expect(days_of_video_posts.map &:video_views_paid).to all (be_an Integer)
      expect(days_of_video_posts.map &:video_view_time).to all (be_an Integer)
    end
  end
end
