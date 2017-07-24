require 'spec_helper'

RSpec.describe 'Fb::User#pages' do
  context 'given an invalid access token' do
    it 'raises Fb::HTTPError' do
      user = Fb::User.new access_token: 'invalid_token'
      expect{user.pages}.to raise_error Fb::HTTPError
    end
  end

  context 'given a valid access_token' do
    user = Fb::User.new access_token: ENV['FB_TEST_ACCESS_TOKEN']

    it 'returns an array of pages' do
      expect(user.pages).to be_a(Array)
      expect(user.pages).to all(be_a Fb::Page)
      expect(user.pages.map &:id).to all(be_a String)
      expect(user.pages.map &:name).to all(be_a String)
      expect(user.pages.map &:category).to all(be_a String)
    end
  end
end
