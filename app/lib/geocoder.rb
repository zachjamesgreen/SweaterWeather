class Geocoder
  # Param : address String
  # Return : Array Floats
  def self.coords(address)
    res = Geocode.geocode(address)
    json = JSON.parse(res.body)
    lat = json['results'][0]['locations'][0]['latLng']['lat']
    lng = json['results'][0]['locations'][0]['latLng']['lng']
    return lat, lng
  end
end