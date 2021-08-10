require 'rails_helper'

RSpec.describe "/road_trip", type: :request do
  before :all do
    @user = create(:user)
    @headers = { "CONTENT_TYPE" => "application/json" }
    @good_params = {
      origin: 'denver',
      destination: 'chicago',
      api_key: @user.reload.api_key
    }.to_json
  end

  describe 'errors'do
    it 'returns error if api key is not present' do
      post '/api/v1/road_trip', params: {api_key: ''}.to_json, headers: @headers
      expect(response).to be_unauthorized
    end

    it 'returns error if api key is not associated with a user' do
      post '/api/v1/road_trip', params: {api_key: 'not_a_user_api_key'}.to_json, headers: @headers
      expect(response).to be_unauthorized
    end
  end

  describe 'road_trip response', :vcr do
    it 'response is ok' do
      post '/api/v1/road_trip', params: @good_params, headers: @headers
      expect(response).to be_ok
    end

    it 'has necessary keys in JSON' do
      post '/api/v1/road_trip', params: @good_params, headers: @headers
      data = JSON.parse(response.body)['data']
      expect(data.keys).to include('id', 'type', 'attributes')
      expect(data.keys.count).to eq 3
      expect(data['attributes'].keys).to include('start_city', 'end_city', 'travel_time', 'weather_at_eta')
      expect(data['attributes'].keys.count).to eq 4
      expect(data['attributes']['weather_at_eta'].keys).to include('temperature', 'conditions')
      expect(data['attributes']['weather_at_eta'].keys.count).to eq 2
    end

    it 'has returns impossible travel time and empty weather' do
      post '/api/v1/road_trip', params: {origin: 'denver', destination: 'london', api_key: @user.api_key}.to_json, headers: @headers
      data = JSON.parse(response.body)['data']
      expect(data.keys).to include('id', 'type', 'attributes')
      expect(data.keys.count).to eq 3
      expect(data['attributes'].keys).to include('start_city', 'end_city', 'travel_time', 'weather_at_eta')
      expect(data['attributes'].keys.count).to eq 4
      expect(data['attributes']['weather_at_eta']).to eq({})
      expect(data['attributes']['travel_time']).to eq 'impossible'
    end
  end

  context 'only accept JSON' do
    it 'returns parse error if body cant be parsed' do
      post '/api/v1/road_trip?origin=denver&password=chicago', headers: @headers
      expect(response).to be_unprocessable
      body = JSON.parse(response.body)
      expect(body['error']).to eq('problem parsing request body')
    end

    it 'returns error if json header is not sent' do
      post '/api/v1/road_trip?origin=denver&password=chicago'
      expect(response).to be_unprocessable
      body = JSON.parse(response.body)
      expect(body['error']).to eq('this route only takes json data')
    end
  end
end
