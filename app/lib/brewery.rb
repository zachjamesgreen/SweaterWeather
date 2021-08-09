class Brewery
  attr_reader :id, :name, :brewery_type
  def initialize(brewery)
    @id = brewery['id']
    @name = brewery['name']
    @brewery_type = brewery['brewery_type']
  end
end