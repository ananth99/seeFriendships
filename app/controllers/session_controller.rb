class SessionController < ApplicationController

  def create
    auth = request.env['omniauth.auth']
    user = User.find_by_uid(auth['uid'])  
    if user.blank?
      user = User.create_user(auth)
      @friends = user.get_friends
      user.save_friends(@friends)
    end
    session['user_id'] = user.uid
    session['oauth_token'] = auth['credentials']['token']
    redirect_to root_url
  end

  def destroy
    session['user_id'] = nil
    session['oauth_token'] = nil
    redirect_to root_url
  end
end