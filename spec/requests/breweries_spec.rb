require 'rails_helper'

RSpec.describe "/breweries", type: :request do
  describe 'errors'do
    it 'returns error if location is not present' do
      get '/api/v1/breweries'
      expect(response).to be_a_bad_request
    end

    it 'returns error if quantity is not numeric' do
      get '/api/v1/breweries?quantity=hi'
      expect(response).to be_a_bad_request
    end
  end

  describe 'breweries response', :vcr do
    it 'response is ok' do
      get '/api/v1/breweries?location=denver&quantity=1'
      expect(response).to be_ok
    end

    it 'has necessary keys in JSON' do
      get '/api/v1/breweries?location=denver&quantity=1'
      data = JSON.parse(response.body)['data']
      expect(data.keys).to include('id', 'type', 'attributes')
      expect(data['attributes'].keys).to include('destination', 'forecast', 'breweries')
      expect(data['attributes'].keys.size).to eq 3
      expect(data['attributes']['forecast'].keys).to include('summary', 'temperature')
      expect(data['attributes']['forecast'].keys.size).to eq 2
      expect(data['attributes']['breweries'][0].keys).to include('id', 'name', 'brewery_type')
      expect(data['attributes']['breweries'][0].keys.size).to eq 3
    end
  end
end
