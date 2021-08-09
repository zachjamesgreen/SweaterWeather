class DailyWeather < Weather
  attr_reader :date, :sunrise, :sunset, :temp, :feels_like, :humidity, :uvi, :visibility, :conditions, :icon
  def initialize(info)
    @date   = Time.at(info['dt'])
    @sunrise    = Time.at(info['sunrise'])
    @sunset     = Time.at(info['sunset'])
    @max_temp   = info['temp']['min']
    @min_temp   = info['temp']['max']
    @conditions = info['weather'][0]['description']
    @icon       = info['weather'][0]['icon']
  end
end