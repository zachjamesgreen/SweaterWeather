class Breweries
  attr_reader :breweries, :forcast, :destination
  Forcast = Struct.new(:summary, :temperature)

  def initialize(current_weather, destination)
    @destination = destination
    @forcast = create_forcast(current_weather)
    @breweries = []
  end

  # def << (brewery)
  #   @breweries << brewery
  # end

  def create_forcast(current_weather)
    Forcast.new(current_weather.conditions, current_weather.temp)
  end

  def serialize
    {
      id: nil,
      type: 'breweries',
      attributes: {
        destination: @destination,
        forcast: @forcast,
        breweries: @breweries, #.map { |brewery| brewery.serialize },
      }
    }
  end

end