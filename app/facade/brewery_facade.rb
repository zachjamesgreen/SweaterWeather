class BreweryFacade
  def self.get_breweries(location, quantity)
    brew_res = BreweryService.get_breweries(location, quantity)
    create_breweries(location)
    add_breweries(brew_res)
    @breweries
  end

  def self.create_breweries(location)
    lat, lng = Geocoder.geocode(location)
    weather_res = WeatherFacade.weather(lat, lng)
    @breweries = Breweries.new(weather_res[0], location)
  end

  def self.add_breweries(brew_res)
    json = JSON.parse(brew_res.body)
    json.each do |brewery|
      @breweries.breweries << Brewery.new(brewery)
    end
  end
end