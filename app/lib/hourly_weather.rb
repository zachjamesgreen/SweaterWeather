class HourlyWeather < Weather
  attr_reader :time, :temp, :conditions, :icon
  def initialize(info)
    @time       = Time.at(info['dt']).to_s(:time)
    @temp       = info['temp']
    @conditions = info['weather'][0]['description']
    @icon       = info['weather'][0]['icon']
  end
end