require 'spec_helper'

RSpec.describe 'Fb::User#email' do
  context 'given an invalid access token' do
    it 'raises Fb::HTTPError' do
      user = Fb::User.new access_token: 'invalid_token'
      expect{user.email}.to raise_error Fb::HTTPError
    end
  end

  context 'given a valid access_token' do
    user = Fb::User.new access_token: ENV['FB_TEST_ACCESS_TOKEN']

    it 'returns the email of the user' do
      expect(user.email).to be_a(String)
    end
  end
end
