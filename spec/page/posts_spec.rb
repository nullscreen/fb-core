require 'spec_helper'

RSpec.describe 'Fb::Page#posts' do
  context 'given an invalid access token' do
    let(:page) { Fb::Page.new access_token: 'invalid_token' }

    it 'raises Fb::HTTPError' do
      expect{page.posts}.to raise_error Fb::HTTPError
    end
  end

  context 'given a valid access_token' do
    let(:user) { Fb::User.new access_token: ENV['FB_TEST_ACCESS_TOKEN'] }
    let(:page) { user.pages.first }

    it 'returns array of Post for any given page' do
      expect(page.posts).to be_a(Array)
      expect(page.posts).to all (be_a Fb::Post)
      expect(page.posts.map &:id).to all(be_a String)
      expect(page.posts.map &:type).to all(be_a String)
      expect(page.posts.map &:created_at).to all(be_a Time)
    end
  end
end
