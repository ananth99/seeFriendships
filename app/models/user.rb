class User < ActiveRecord::Base
  has_many :friends, :foreign_key =>'friend_id'
  def self.create_user(auth)
    create! do |user|
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    end
  end

  def facebook_graph
    @graph = Koala::Facebook::API.new(self.oauth_token, ENV['facebook_app_secret'])
  end

  def get_friends 
    @friends = facebook_graph.get_connections("me","taggable_friends")
  end

  def save_friends(friends)
    friends.each do |frnd|
      f = Friend.new
      f.uid= frnd['id']
      f.friend_id = self.id
      f.name = frnd['name']
      f.save!
    end
  end

  # Get Photos
  def get_photos
    photos = facebook_graph.get_connections("me","photos")
    all_photos = []
    while photos
      photos.each do |photo|
        all_photos << photo 
      end
      photos = photos.next_page
    end
    all_photos
  end

  # Search Photos
  def search_photos(all_photos, friends)
    result = all_photos.select do |photo|
      tags = []
      photo['tags']['data'].each do |tagData|
        tags << tagData['name']
      end
      (tags.to_set >= friends.to_set)
    end
    result
  end
end
