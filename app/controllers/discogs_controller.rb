class PlaylistController < ApplicationController
  skip_before_filter :authenticate_discogs

  def callback
    request_token = session[:request_token]
    verifier = params[:oauth_verifier]
    access_token = @discogs.authenticate(request_token, verifier)
    session[:request_token] = nil
    session[:access_token] = access_token
    @discogs.access_token = access_token
    redirect_to playlist_url
  end
end