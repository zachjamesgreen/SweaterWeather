class ForecastSerializer
  def self.serialize(current, daily, hourly)
    {
      data: {
        id: nil,
        type: 'forecast',
        attributes: {
          current_weather: current.serialize,
          daily_weather: daily.map(&:serialize),
          hourly_weather: hourly.map(&:serialize)
        }
      }
    }
  end

end