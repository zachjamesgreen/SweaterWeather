require 'rails_helper'

RSpec.describe DailyWeather do
  before :all do
    file = File.read("#{Rails.root}/spec/one_call.json")
    @data = JSON.parse(file)
  end

  it 'has correct attributes' do
    dw = DailyWeather.new(@data['daily'][0])
    expect(dw).to have_attributes(
      class: DailyWeather,
      date: be_a(Time),
      sunrise: be_a(Time),
      sunset: be_a(Time),
      max_temp: be_a(Numeric),
      min_temp: be_a(Numeric),
      conditions: be_a(String),
      icon: be_a(String)
    )
  end
end