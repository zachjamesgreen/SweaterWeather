require 'rails_helper'

RSpec.describe BreweryFacade, :vcr do
  it 'self.get_breweries' do
    output = BreweryFacade.get_breweries('denver', 5)
    expect(output).to be_instance_of(Breweries)
  end
end