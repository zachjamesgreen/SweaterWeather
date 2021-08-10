class RoadTripFacade
  def self.route(origin, dest)
    res = Geocode.route(origin, dest)
    json = JSON.parse(res.body)
    raise RoadTripError, json['info']['messages'] if json['info']['statuscode'] != 0

    road_trip = RoadTrip.new(origin, dest, json)
  end
end