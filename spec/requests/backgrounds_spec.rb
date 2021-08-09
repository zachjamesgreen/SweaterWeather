require 'rails_helper'

RSpec.describe "/backgrounds", type: :request do
  describe 'errors'do
    it 'returns error if city,state is not present' do
      get '/api/v1/backgrounds'
      expect(response).to be_a_bad_request
    end
  end

  describe 'backgrounds response', :vcr do
    it 'response is ok' do
      get '/api/v1/backgrounds?location=denver'
      expect(response).to be_ok
    end

    it 'has necessary keys in JSON' do
      get '/api/v1/backgrounds?location=denver'
      data = JSON.parse(response.body)['data']
      expect(data.keys).to include('id', 'type', 'attributes')
      expect(data['attributes'].keys).to include('urls', 'width', 'height', 'description', 'user')
      expect(data['attributes']['user'].keys).to include('name', 'link')
    end
  end
end
