class DailyWeather
  attr_reader :date, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon

  def initialize(info)
    @date       = Time.at(info['dt'])
    @sunrise    = Time.at(info['sunrise'])
    @sunset     = Time.at(info['sunset'])
    @max_temp   = info['temp']['min']
    @min_temp   = info['temp']['max']
    @conditions = info['weather'][0]['description']
    @icon       = info['weather'][0]['icon']
  end

  def serialize
    {
      date: @date.to_s(:db),
      sunrise: @sunrise.to_s(:db),
      sunset: @sunset.to_s(:db),
      max_temp: @max_temp,
      min_temp: @min_temp,
      conditions: @conditions,
      icon: @icon
    }
  end
end
