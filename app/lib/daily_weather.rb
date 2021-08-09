class DailyWeather < Weather
  attr_reader :date, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon
  def initialize(info)
    @date   = Time.at(info['dt']).to_s(:db)
    @sunrise    = Time.at(info['sunrise']).to_s(:db)
    @sunset     = Time.at(info['sunset']).to_s(:db)
    @max_temp   = info['temp']['min']
    @min_temp   = info['temp']['max']
    @conditions = info['weather'][0]['description']
    @icon       = info['weather'][0]['icon']
  end
end