class HourlyWeather < Weather
  attr_reader :time, :temperature, :conditions, :icon
  def initialize(info)
    @time       = Time.at(info['dt'])
    @temperature       = info['temp']
    @conditions = info['weather'][0]['description']
    @icon       = info['weather'][0]['icon']
  end

  def serialize
    {
      time: @time.to_s(:time),
      temperature: @temperature,
      conditions: @conditions,
      icon: @icon
    }
  end
end