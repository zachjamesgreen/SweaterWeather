class WeatherService
  def self.all_weather(lat,lng)
    Faraday.get("https://api.openweathermap.org/data/2.5/onecall?units=imperial&exclude=minutely,alerts&lat=#{lat}&lon=#{lng}&appid=#{ENV['OPENWEATHER_API_KEY']}")
  end
end