require 'rails_helper'

RSpec.describe Brewery do
  before :all do
    @info = {
      'id' => 1234,
      'name' => 'Test',
      'brewery_type' => 'micro'
    }
  end

  it 'has correct attributes' do
    brw = Brewery.new(@info)
    expect(brw).to have_attributes(
      class: Brewery,
      id: 1234,
      name: 'Test',
      brewery_type: 'micro'
    )
  end
end