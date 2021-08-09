require 'rails_helper'

RSpec.describe Breweries do
  before :all do
    file = File.read("#{Rails.root}/spec/one_call.json")
    @data = JSON.parse(file)
    @brewery = Brewery.new({
      id: 1234,
      name: 'test brew',
      brewery_type: 'micro'
    })
  end

  it 'has correct attributes' do
    cw = WeatherFacade.current_weather(@data)
    brw = Breweries.new(cw, 'denver')
    brw.breweries << @brewery
    
    expect(brw).to have_attributes(
      class: Breweries,
      destination: 'denver',
      forcast: have_attributes(
        summary: be_a(String),
        temperature: be_a(Numeric)
      ),
      breweries: (be_a(Array).and include(an_instance_of(Brewery)))
    )
  end
end