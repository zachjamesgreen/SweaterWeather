class BreweryService
  def self.get_breweries(location, quantity)
    Faraday.get('https://api.openbrewerydb.org/breweries', {by_city: location, per_page: quantity})
  end
end