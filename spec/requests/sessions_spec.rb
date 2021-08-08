require 'rails_helper'

RSpec.describe "/sessions", type: :request do
  before :all do
    @user = create(:user)
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "login a User" do
        post '/api/v1/sessions', params: {email: @user.email, password: @user.password}
        expect(response).to be_ok
      end
    end

    context "with invalid parameters" do
      it "renders a unauthorized response to not having a user" do
        post '/api/v1/sessions', params: {email: 'a', password: 'b'}
        expect(response).to be_unauthorized
      end
      it "renders a unauthorized response to bad email" do
        post '/api/v1/sessions', params: {email: 'bye@what.com', password: @user.password}
        expect(response).to be_unauthorized
      end
      it "renders a unauthorized response to bad password" do
        post '/api/v1/sessions', params: {email: @user.email, password: "bar"}
        expect(response).to be_unauthorized
      end
    end
  end
end
