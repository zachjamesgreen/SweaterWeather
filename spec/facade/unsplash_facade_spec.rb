require 'rails_helper'

RSpec.describe UnsplashFacade, :vcr do
  it 'self.weather' do
    output = UnsplashFacade.backgrounds('denver')
    expect(output).to be_instance_of(Background)
  end
end