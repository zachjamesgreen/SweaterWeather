class HourlyWeather < Weather
  attr_reader :time, :temp, :conditions, :icon
  def initialize(info)
    @time       = Time.at(info['dt'])
    @temp       = info['temp']
    @conditions = info['weather'][0]['description']
    @icon       = info['weather'][0]['icon']
  end

  def serialize
    {
      time: @time.to_s(:time),
      temp: @temp,
      conditions: @conditions,
      icon: @icon
    }
  end
end