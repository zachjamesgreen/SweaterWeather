 require 'rails_helper'

RSpec.describe "/users", type: :request do
  before :all do
    @headers = { "CONTENT_TYPE" => "application/json" }
  end
  let(:valid_attributes) {
    {
      email: Faker::Internet.email,
      password: "foobar",
      password_confirmation: "foobar"
    }.to_json
  }

  let(:invalid_attributes) {
    {
      email: Faker::Internet.email,
      password: "foobar",
      password_confirmation: "bar"
    }.to_json
  }

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new User" do
        expect {
          post '/api/v1/users', params: valid_attributes, headers: @headers
        }.to change(User, :count).by(1)
      end

      it "response to be 201" do
          post '/api/v1/users', params: valid_attributes, headers: @headers
        expect(response).to be_created
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        expect {
          post '/api/v1/users', params: invalid_attributes, headers: @headers
        }.to change(User, :count).by(0)
      end

      it "renders a unprocessable response" do
        post '/api/v1/users', params: invalid_attributes, headers: @headers
        expect(response).to be_unprocessable
      end
    end

    context 'only accept JSON' do
      it 'returns parse error if body cant be parsed' do
        post '/api/v1/users?email=test&password=test&password_confirmation=test', headers: @headers
        expect(response).to be_unprocessable
        body = JSON.parse(response.body)
        expect(body['error']).to eq('problem parsing request body')
      end

      it 'returns error if json header is not sent' do
        post '/api/v1/users?email=test&password=test&password_confirmation=test'
        expect(response).to be_unprocessable
        body = JSON.parse(response.body)
        expect(body['error']).to eq('this route only takes json data')
      end
    end
  end
end
