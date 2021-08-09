require 'rails_helper'

RSpec.describe Background do
  before :all do
    file = File.read("#{Rails.root}/spec/unsplash-one-result.json")
    @data = JSON.parse(file)
  end

  it 'has correct attributes' do
    bg = Background.new(@data['results'][0])
    expect(bg).to have_attributes(
      class: Background,
      id: be_a(String),
      width: be_a(Integer),
      height: be_a(Integer),
      description: be_a(String),
      urls: be_a(Hash),
      user: have_attributes(
        class: Struct::UnsplashUser,
        name: be_a(String),
        link: be_a(String),
      )
    )
  end
end