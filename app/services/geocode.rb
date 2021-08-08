class Geocode
  def self.geocode(address)
    Faraday.post(
      "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAPQUEST_API_KEY']}",
      {location: address}
    )
  end
end