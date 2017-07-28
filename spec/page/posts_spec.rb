require 'spec_helper'

RSpec.describe 'Fb::Page#posts' do
  context 'given valid options and an existing page with over 100 posts' do
    let(:posts) { Fb::Page.new(id: '221406534569729').posts }

    it 'returns an array of posts' do
      expect(posts).to be_a(Array)
      expect(posts).to all (be_a Fb::Post)
      expect(posts.map &:id).to all(be_a String)
      expect(posts.map &:url).to all(be_a String)
      expect(posts.map &:type).to all(be_a String)
      expect(posts.map &:created_time).to all(be_a String)
      expect(posts.map &:title).to all(be_a String)
    end
  end
end
