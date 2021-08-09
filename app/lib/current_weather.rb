class CurrentWeather < Weather
  attr_reader :datetime, :sunrise, :sunset, :temp, :feels_like, :humidity, :uvi, :visibility, :conditions, :icon
  def initialize(info)
    @datetime   = Time.at(info['current']['dt']).to_s(:db)
    @sunrise    = Time.at(info['current']['sunrise']).to_s(:db)
    @sunset     = Time.at(info['current']['sunset']).to_s(:db)
    @temp       = info['current']['temp']
    @feels_like = info['current']['feels_like']
    @humidity   = info['current']['humidity']
    @uvi        = info['current']['uvi']
    @visibility = info['current']['visibility']
    @conditions = info['current']['weather'][0]['description']
    @icon       = info['current']['weather'][0]['icon']
  end
end