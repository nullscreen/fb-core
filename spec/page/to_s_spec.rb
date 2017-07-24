require 'spec_helper'

RSpec.describe 'Fb::Page#to_s' do
  let(:page) { Fb::Page.new id: 123, name: 'R.E.M.' }

  it 'returns a pretty string representation' do
    expect(page.to_s).to eq '#<Fb::Page 123 "R.E.M.">'
  end
end
