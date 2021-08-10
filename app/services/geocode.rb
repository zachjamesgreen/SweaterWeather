class Geocode
  def self.geocode(address)
    Faraday.post(
      "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAPQUEST_API_KEY']}",
      { location: address }
    )
  end

  def self.route(origin, destination)
    Faraday.post("http://www.mapquestapi.com/directions/v2/route?key=#{ENV['MAPQUEST_API_KEY']}") do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = { locations: [origin, destination] }.to_json
    end
  end
end