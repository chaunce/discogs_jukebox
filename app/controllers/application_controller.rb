class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :initialize_discogs
  # before_filter :authenticate_discogs
  
  def initialize_discogs
    @discogs = Discogs::Wrapper.new("Discogs Jukebox")
  end
  
  def authenticate_discogs
    unless @discogs.authenticated?
      request_data = @discogs.get_request_token("nunpPpeROPzWSdgwtotr", "hPtIJfRaLICviDNKGYIFCzygGgVpAmdJ", "lp-jukebox.herokuapp.com/callback")
      session[:request_token] = request_data[:request_token]
      redirect_to request_data[:authorize_url]
    end
  end
end
