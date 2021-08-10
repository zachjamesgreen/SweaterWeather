class Background
  attr_reader :id, :width, :height, :description, :urls, :user
  Struct.new('UnsplashUser', :name, :link)

  def initialize(info)
    @id = info['id']
    @width = info['width']
    @height = info['height']
    @description = info['description']
    @urls = info['urls']
    @user = parse_user(info['user'])
  end

  def parse_user(user)
    Struct::UnsplashUser.new(user['name'], user['links']['html'])
  end
end