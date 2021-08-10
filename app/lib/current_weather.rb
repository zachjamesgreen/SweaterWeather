class CurrentWeather < Weather
  attr_reader :datetime, :sunrise, :sunset, :temp, :feels_like, :humidity, :uvi, :visibility, :conditions, :icon
  def initialize(info)
    @datetime   = Time.at(info['current']['dt'])
    @sunrise    = Time.at(info['current']['sunrise'])
    @sunset     = Time.at(info['current']['sunset'])
    @temp       = info['current']['temp']
    @feels_like = info['current']['feels_like']
    @humidity   = info['current']['humidity']
    @uvi        = info['current']['uvi']
    @visibility = info['current']['visibility']
    @conditions = info['current']['weather'][0]['description']
    @icon       = info['current']['weather'][0]['icon']
  end

  def serialize
    {
      datetime: @datetime.to_s(:db),
      sunrise: @sunrise.to_s(:db),
      sunset: @sunset.to_s(:db),
      temperature: @temp,
      feels_like: @feels_like,
      humidity: @humidity,
      uvi: @uvi,
      visibility: @visibility,
      conditions: @conditions,
      icon: @icon
    }
  end
end