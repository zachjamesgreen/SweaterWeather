require 'rails_helper'

RSpec.describe CurrentWeather do
  before :all do
    file = File.read("#{Rails.root}/spec/one_call.json")
    @data = JSON.parse(file)
  end

  it 'has correct attributes' do
    cw = CurrentWeather.new(@data)
    expect(cw).to have_attributes(
      class: CurrentWeather,
      datetime: match(/\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}/),
      sunrise: match(/\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}/),
      sunset: match(/\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}/),
      temp: be_a(Numeric),
      feels_like: be_a(Numeric),
      humidity: be_a(Numeric),
      uvi: be_a(Numeric),
      visibility: be_a(Numeric),
      conditions: be_a(String),
      icon: be_a(String)
    )
  end
end