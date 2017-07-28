require 'spec_helper'

RSpec.describe 'Fb::Post#to_s' do
  let(:post) { Fb::Post.new id: 123, type: 'video' }

  it 'returns a pretty string representation' do
    expect(post.to_s).to eq '#<Fb::Post 123 "video">'
  end
end
