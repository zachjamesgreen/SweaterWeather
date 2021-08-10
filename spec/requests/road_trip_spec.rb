require 'rails_helper'

RSpec.describe "/road_trip", type: :request do
  before :all do
    @user = create(:user)
    @good_params = {
      origin: 'denver',
      destination: 'chicago',
      api_key: @user.reload.api_key
    }
  end

  describe 'errors'do
    it 'returns error if api key is not present' do
      post '/api/v1/road_trip'
      expect(response).to be_unauthorized
    end

    it 'returns error if api key is not associated with a user' do
      post '/api/v1/road_trip', params: {api_key: 'not_a_user_api_key'}
      expect(response).to be_unauthorized
    end

    it 'returns error if route can not be found' do
      VCR.use_cassette('road_trip_error') do
        post '/api/v1/road_trip', params: {origin: 'denver', destination: 'london', api_key: @user.api_key}
      end
      expect(response).to be_unprocessable
    end
  end

  describe 'road_trip response', :vcr do
    it 'response is ok' do
      post '/api/v1/road_trip', params: @good_params
      expect(response).to be_ok
    end

    it 'has necessary keys in JSON' do
      post '/api/v1/road_trip', params: @good_params
      data = JSON.parse(response.body)['data']
      expect(data.keys).to include('id', 'type', 'attributes')
      expect(data.keys.count).to eq 3
      expect(data['attributes'].keys).to include('origin', 'destination', 'travel_time', 'weather_at_eta')
      expect(data['attributes'].keys.count).to eq 4
      expect(data['attributes']['weather_at_eta'].keys).to include('temperature', 'conditions')
      expect(data['attributes']['weather_at_eta'].keys.count).to eq 2
    end

    xit 'weather data within 48 hours' do
      post '/api/v1/road_trip', params: {origin: 'denver,co', destination: 'englewood,co', api_key: @user.api_key}
      data = JSON.parse(response.body)['data']
      weather = data['attributes']['weather_at_eta']
      expect(weather.time).be < (Time.now + 48.hours)
    end

    xit 'weather data outside of 48 hours' do
      post '/api/v1/road_trip', params: {origin: 'denver,co', destination: 'anchorage,ak', api_key: @user.api_key}
      data = JSON.parse(response.body)['data']
      weather = data['attributes']['weather_at_eta']
      expect(weather.date).be < (Time.now + 48.hours)
      expect(weather.date).be > (Time.now + 7.days)
    end
  end
end
