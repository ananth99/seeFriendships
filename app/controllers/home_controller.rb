  class HomeController < ApplicationController
    def index    
      if current_user && current_user.oauth_expires_at > Time.now
        @friends = current_user.friends.all.map{|friend| [friend.name, friend.name]}
      end
    end

    def search
      @search_params = params['friends']
      @photos = current_user.get_photos
      @friends = current_user.friends.all.map{|friend| [friend.name, friend.name]}
      @results = current_user.search_photos(@photos, @search_params)
      render :index
    end
  end
