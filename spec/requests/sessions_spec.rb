require 'rails_helper'

RSpec.describe "/sessions", type: :request do
  before :all do
    @user = create(:user)
    @user.reload
    @header = {'CONTENT_TYPE' => 'application/json'}
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "login a User" do
        params = {email: @user.email, password: @user.password}.to_json
        post '/api/v1/sessions', params: params, headers: @header
        expect(response).to be_ok
      end

      it 'returns the user email and api key' do
        params = {email: @user.email, password: @user.password}.to_json
        post '/api/v1/sessions', params: params, headers: @header
        data = JSON.parse(response.body)['data']
        expect(data.keys).to include('id', 'type', 'attributes')
        expect(data.keys.size).to eq 3
        expect(data['attributes'].keys).to include('email', 'api_key')
        expect(data['attributes'].keys.size).to eq 2
        expect(data['id']).to eq @user.id.to_s
        expect(data['type']).to eq 'users'
        expect(data['attributes']['email']).to eq @user.email
        expect(data['attributes']['api_key']).to eq @user.api_key
      end
    end

    context "with invalid parameters" do
      it "renders a unauthorized response to not having a user" do
        post '/api/v1/sessions', params: {email: 'a', password: 'b'}.to_json, headers: @header
        expect(response).to be_unauthorized
      end
      it "renders a unauthorized response to bad email" do
        post '/api/v1/sessions', params: {email: 'bye@what.com', password: @user.password}.to_json, headers: @header
        expect(response).to be_unauthorized
      end
      it "renders a unauthorized response to bad password" do
        post '/api/v1/sessions', params: {email: @user.email, password: "bar"}.to_json, headers: @header
        expect(response).to be_unauthorized
      end
    end

    # context 'only accept JSON' do
    #   it 'returns parse error if body cant be parsed' do
    #     post '/api/v1/users?email=test&password=test&password_confirmation=test', headers: @headers
    #     expect(response).to be_unprocessable
    #     body = JSON.parse(response.body)
    #     expect(body['error']).to eq('problem parsing request body')
    #   end

    #   it 'returns error if json header is not sent' do
    #     post '/api/v1/users?email=test&password=test&password_confirmation=test'
    #     expect(response).to be_unprocessable
    #     body = JSON.parse(response.body)
    #     expect(body['error']).to eq('this route only takes json data')
    #   end
    # end
  end
end
