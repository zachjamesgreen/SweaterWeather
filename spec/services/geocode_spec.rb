require 'rails_helper'

RSpec.describe Geocode, :vcr do
  it 'returns a faraday response' do
    output = Geocode.geocode('denver,co')
    expect(output).to be_a(Faraday::Response)
  end
end