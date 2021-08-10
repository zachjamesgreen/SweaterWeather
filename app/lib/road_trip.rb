class RoadTrip
  attr_reader :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(start_city, end_city)
    @start_city = start_city
    @end_city = end_city
    @travel_time = get_travel_time()
    @weather_at_eta = get_weather()
    # binding.pry
  end

  def get_travel_time
    route = get_route()
    {
      real_time: Time.now + route['route']['realTime'],
      time: Time.now + route['route']['time'],
      formatted_time: route['route']['formattedTime']
    }
  end

  def get_route
    res = Geocode.route(@start_city, @end_city)
    json = JSON.parse(res.body)
    raise RoadTripError, json['info']['messages'] if json['info']['statuscode'] != 0
    json
  end

  def get_weather
    lat, lng = Geocoder.coords(@end_city)
    weather_res = WeatherFacade.weather(lat, lng)
    if @travel_time[:real_time] < 48.hours.from_now
      # weather by the hour for 48 hours
      weather_res[2].find do |weather|
        diff = (weather.time - @travel_time[:real_time]).abs
        0 <= diff && diff <= (30 * 60)
      end
    elsif @travel_time[:real_time] < 1.week.from_now
      # daily weather for 7 days
      weather_res[1].find do |weather|
        diff = (weather.date - @travel_time[:real_time]).abs
        0 <= diff && diff <= (60 * 60 * 12)
      end
    else
      nil
    end
  end
''
  def serialize
    weather = if @weather_at_eta
                {
                 temperature: @weather_at_eta.temp,
                 conditions: @weather_at_eta.conditions
                }
              else
                nil
              end
    {
      id: nil,
      type: 'roadtrip',
      attributes: {
        start_city: @start_city,
        end_city: @end_city,
        travel_time: @travel_time[:formatted_time],
        weather_at_eta: weather
      }
    }
  end
end