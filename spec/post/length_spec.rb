require 'spec_helper'

RSpec.describe 'Fb::Post#length' do
  context 'given a video post with a length property' do
    let(:post) {
      Fb::Post.new(
        type: 'video',
        properties: [{"name"=>"Length", "text"=>"01:40"}],
        created_time: '2008-08-08T08:00:00+0000'
      )
    }
    it 'returns post length as n/a for nonvideos' do
      expect(post.length).to eq '01:40'
    end
  end

  context 'given a video post with a length property' do
    let(:post) { Fb::Post.new type: 'video', created_time: '2008-08-08T08:00:00+0000' }
    it 'returns length as n/a' do
      expect(post.length).to eq 'n/a'
    end
  end

  context 'given a nonvideo post' do
    let(:post) { Fb::Post.new type: 'photo', created_time: '2008-08-08T08:00:00+0000' }
    it 'returns length as n/a' do
      expect(post.length).to eq 'n/a'
    end
  end
end
