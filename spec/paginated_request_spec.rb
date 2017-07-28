require 'spec_helper'

RSpec.describe 'Fb::PaginatedRequest#run' do
  let(:params) { {access_token: ENV['FB_TEST_ACCESS_TOKEN']} }
  let(:request) { Fb::PaginatedRequest.new path: path, params: params }

  context 'given a request which more than one page of results' do
    let(:path) { '/v2.9/20531316728/posts' } # Posts by Facebook

    it 'returns all the results, not just the first page' do
      response = request.run
      expect(response).to be_a Net::HTTPOK
      expect(response.body['data'].size).to be > 100
    end
  end
end
