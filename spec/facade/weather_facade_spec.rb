require 'rails_helper'

RSpec.describe WeatherFacade, :vcr do
  it 'self.weather' do
    output = WeatherFacade.weather(39, -104)
    expect(output).to be_a(Array)
    expect(output[0]).to be_instance_of(CurrentWeather)
    expect(output[1]).to be_a(Array)
    expect(output[1]).to include(an_instance_of(DailyWeather))
    expect(output[2]).to be_a(Array)
    expect(output[2]).to include(an_instance_of(HourlyWeather))
  end
end