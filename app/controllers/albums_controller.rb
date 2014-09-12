class AlbumsController < ApplicationController
  before_action :set_album, only: [:play, :stop]

  def create
    release = @discogs.get_release(params[:release_id].to_s)
    unless release
      flash[:notice] = "error"
      render :new
    end

    @album = Album.new
    @album.name = release.title
    @album.artist = release.artists.first.name
    @album.image_url = release.images.detect{ |image| image[:type] == 'primary' }.try(:resource_url).to_s.gsub('api.discogs.com', 's.pixogs.com').gsub('images', 'image')

    if @album.save
      redirect_to root_path, notice: "#{release.title} was added to the playlist"
    else
      render :add
    end
  end

  def play
    album = Album.find(params[:id])
    album.started_at = Time.now
    if album.save!
      redirect_to root_path, notice: 'Now Playing'
    else
      redirect_to root_path
    end
  end

  def stop
    album = Album.find(params[:id])
    album.completed_at = Time.now
    if album.save!
      redirect_to root_path, notice: 'Completed Playing'
    else
      redirect_to root_path
    end
  end

end