require 'rails_helper'

RSpec.describe UnsplashService, :vcr do
  it 'returns a faraday response' do
    output = UnsplashService.search('denver')
    expect(output).to be_a(Faraday::Response)
  end
end