class RoadTripSerializer
  def self.serialize
  end

  def self.impossible(road_trip_params)
    {
      data: {
        id: nil,
        type: 'roadtrip',
        attributes: {
          start_city: road_trip_params[:origin],
          end_city: road_trip_params[:destination],
          travel_time: 'impossible',
          weather_at_eta: {}
        }
      }
    }
  end
end