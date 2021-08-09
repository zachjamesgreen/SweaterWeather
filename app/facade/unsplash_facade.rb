class UnsplashFacade
  def self.backgrounds(city)
    res = UnsplashService.search(city)
    json = JSON.parse(res.body)
    Background.new(json['results'][0])
  end
end