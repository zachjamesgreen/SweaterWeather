class UnsplashService
  def self.search(city)
    Faraday.get("https://api.unsplash.com/search/photos", {
      page: 1,
      per_page: 1,
      query: city,
      client_id: ENV['UNSPLASH_API_KEY']
    })
  end
end