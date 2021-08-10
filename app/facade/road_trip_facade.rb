class RoadTripFacade
  def self.route(origin, dest)
    RoadTrip.new(origin, dest)
  end
end
