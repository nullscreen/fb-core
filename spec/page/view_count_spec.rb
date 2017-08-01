require 'spec_helper'

RSpec.describe 'Fb::Page#view_count' do

  context 'given a page with insights data' do
    let(:user) { Fb::User.new access_token: ENV['FB_TEST_ACCESS_TOKEN'] }
    let(:page) { user.pages.first  }

    it 'returns the number of views for the page' do
      expect(page.view_count).to be_a(Integer)
    end

    it 'returns less likes if given an until date' do
      most_recent = page.view_count
      with_until = page.view_count until: Date.today - 7
      expect(with_until).to be_an(Integer)
      expect(with_until).to be <= most_recent
    end
  end
end

