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
      until: Time.parse(Date.today.to_s)
    }}

    it 'returns posts on and between the time options' do
      expect(page.posts(options).map &:created_at).to all (be >= options[:since])
      expect(page.posts(options).map &:created_at).to all (be <= options[:until])
    end
  end
end
