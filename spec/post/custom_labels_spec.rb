require 'spec_helper'

RSpec.describe 'Fb::Post#custom_labels=' do
  context 'given a video post' do
    let(:post) { Fb::Post.new type: 'video', created_time: '2008-08-08T08:00:00+0000' }

    it 'sets and gets custom_labels value' do
      post.custom_labels = ["Kids Play"]
      expect(post.custom_labels).to eq ["Kids Play"]
    end
  end
end
