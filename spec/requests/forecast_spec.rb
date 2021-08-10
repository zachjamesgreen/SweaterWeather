require 'rails_helper'

RSpec.describe "/forecast", type: :request do
  describe 'errors'do
    it 'returns error if city,state is not present' do
      get '/api/v1/forecast'
      expect(response).to be_a_bad_request
    end
  end

  describe 'forecast response', :vcr do
    it 'response is ok' do
      get '/api/v1/forecast?location=denver,co'
      expect(response).to be_ok
    end

    it 'has necessary keys in JSON' do
      get '/api/v1/forecast?location=denver,co'
      data = JSON.parse(response.body)['data']
      expect(data.keys).to include('id', 'type', 'attributes')
      expect(data['attributes'].keys).to include('current_weather', 'daily_weather', 'hourly_weather')
      expect(data['attributes']['current_weather']).to be_a(Hash)
      expect(data['attributes']['daily_weather']).to be_a(Array)
      expect(data['attributes']['hourly_weather']).to be_a(Array)
    end

    it 'has correct number of weather data' do
      get '/api/v1/forecast?location=denver,co'
      attrs = JSON.parse(response.body)['data']['attributes']
      expect(attrs['daily_weather'].size).to eq 5
      expect(attrs['hourly_weather'].size).to eq 8
    end

    it 'has correct time formats on current_weather, daily_weather, hourly_weather' do
      get '/api/v1/forecast?location=denver,co'
      attrs = JSON.parse(response.body)['data']['attributes']
      expect(attrs['current_weather']['datetime']).to match(/\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}/)
      expect(attrs['daily_weather'][0]['date']).to match(/\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}/)
      expect(attrs['hourly_weather'][0]['time']).to match(/\d{2}:\d{2}/)
    end
  end
end
