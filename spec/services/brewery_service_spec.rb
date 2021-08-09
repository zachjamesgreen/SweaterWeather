require 'rails_helper'

RSpec.describe BreweryService, :vcr do
  it 'returns a faraday response' do
    output = BreweryService.get_breweries('denver', 5)
    expect(output).to be_a(Faraday::Response)
  end
end