class BreweryFacade
  def self.get_breweries(location, quantity)
    brew_res = BreweryService.get_breweries(location, quantity)
    lat, lng = Geocoder.geocode(location)
    weather_res = WeatherFacade.weather(lat, lng)
    breweries = Breweries.new(weather_res[0], location)
    json = JSON.parse(brew_res.body)
    json.each do |brewery|
      breweries.breweries << Brewery.new(brewery)
    end
    breweries
  end
end