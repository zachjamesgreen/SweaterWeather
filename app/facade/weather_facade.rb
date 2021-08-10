class WeatherFacade
  def self.weather(lat, lng)
    res = WeatherService.all_weather(lat, lng)
    response = JSON.parse(res.body)
    return current_weather(response), daily_weather(response), hourly_weather(response)
  end

  def self.current_weather(response)
    CurrentWeather.new(response)
  end

  def self.daily_weather(response)
    response['daily'].map { |day| DailyWeather.new(day) }
  end

  def self.hourly_weather(response)
    response['hourly'].map { |hour| HourlyWeather.new(hour) }
  end
end
