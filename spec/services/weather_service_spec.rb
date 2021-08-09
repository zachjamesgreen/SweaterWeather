require 'rails_helper'

RSpec.describe WeatherService, :vcr do
  it 'returns a faraday response' do
    output = WeatherService.all_weather(39, -104)
    expect(output).to be_a(Faraday::Response)
  end
end