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
    end
  end
end
