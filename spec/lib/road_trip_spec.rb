require 'rails_helper'

RSpec.describe RoadTrip do
  before :all do
    @time = Time.new(2021, 8, 9, 20, 33, 45, '-06:00')
    VCR.use_cassette('road_trip_class') do
      @short_road_trip = RoadTrip.new('denver,co', 'englewood,co')
      @long_road_trip = RoadTrip.new('denver,co', 'anchorage,ak')
    end
  end

  describe '#initialize' do
    it 'creates a new road trip' do
      expect(@short_road_trip.class).to eq(RoadTrip)
    end
  end

  describe '#get_travel_time', :vcr do
    it 'returns a hash with 3 keys' do
      time_data = @short_road_trip.get_travel_time
      expect(time_data.keys).to include(:real_time, :time, :formatted_time)
      expect(time_data.keys.size).to eq(3)
      expect(time_data[:real_time]).to be_a(Time)
      expect(time_data[:time]).to be_a(Time)
      expect(time_data[:formatted_time]).to be_a(String)
    end
  end

  describe '#get_weather' do
    it 'returns an hourly weather object', :vcr do
      weather = @short_road_trip.get_weather
      expect(weather.class).to eq(HourlyWeather)
    end

    it 'returns a daily weather object', :vcr do
      weather = @long_road_trip.get_weather
      expect(weather.class).to eq(DailyWeather)
    end

    it 'weather data within 48 hours' do
      expect(@short_road_trip.weather_at_eta.time).to be < (@time + 48.hours)
    end

    it 'weather data outside of 48 hours' do
      date = @long_road_trip.weather_at_eta.date
      expect(date).to be > (@time + 48.hours)
      expect(date).to be < (@time + 7.days)
    end
  end
end