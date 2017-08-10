require 'spec_helper'

RSpec.describe 'Fb::Post#to_s' do
  let(:post) { Fb::Post.new id: 123, type: 'video', created_time: '2017-08-16T23:59:07+0000' }

  it 'returns a pretty string representation' do
    expect(post.to_s).to eq '#<Fb::Post 123 "video">'
  end
end
