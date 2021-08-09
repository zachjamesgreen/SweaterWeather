require 'rails_helper'

RSpec.describe HourlyWeather do
  before :all do
    file = File.read("#{Rails.root}/spec/one_call.json")
    @data = JSON.parse(file)
  end

  it 'has correct attributes' do
    dw = HourlyWeather.new(@data['hourly'][0])
    expect(dw).to have_attributes(
      class: HourlyWeather,
      time: match(/\d{2}:\d{2}/),
      temp: be_a(Numeric),
      conditions: be_a(String),
      icon: be_a(String)
    )
  end
end