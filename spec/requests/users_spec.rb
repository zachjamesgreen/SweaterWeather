 require 'rails_helper'

RSpec.describe "/users", type: :request do
  let(:valid_attributes) {
    {
      email: Faker::Internet.email,
      password: "foobar",
      password_confirmation: "foobar"
    }
  }

  let(:invalid_attributes) {
    {
      email: Faker::Internet.email,
      password: "foobar",
      password_confirmation: "bar"
    }
  }

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new User" do
        expect {
          post '/api/v1/users', params: valid_attributes
        }.to change(User, :count).by(1)
      end

      it "response to be 201" do
        post '/api/v1/users', params: valid_attributes
        expect(response).to be_created
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        expect {
          post '/api/v1/users', params: invalid_attributes
        }.to change(User, :count).by(0)
      end

      it "renders a unprocessable response" do
        post '/api/v1/users', params: invalid_attributes
        expect(response).to be_unprocessable
      end
    end
  end
end
