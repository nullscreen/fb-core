require 'spec_helper'

RSpec.describe 'Fb::Video#to_s' do
  let(:video) { Fb::Video.new id: 123, length: 45.678, created_time: '2017-12-07T23:59:07+0000' }

  it 'returns a pretty string representation' do
    expect(video.to_s).to eq '#<Fb::Video 123 "45.678">'
  end
end
