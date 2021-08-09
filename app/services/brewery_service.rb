class BreweryService
  def self.get_breweries(location, quantity)
    Faraday.get('https://api.openbrewerydb.org/breweries', {location: location, per_page: quantity})
  end
end