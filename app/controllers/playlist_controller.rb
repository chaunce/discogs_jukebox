class PlaylistController < ApplicationController
  def index
    update_now_playing
    update_playlist
  end

  def history
    @albums = Album.played
  end

  def add
  end

  def update_now_playing
    @now_playing = Album.playing.last
  end

  def update_playlist
    @albums = Album.queued
  end

  def load_releases
    @albums = @discogs.get_user_folder_releases('chaunce', 0, { page: (params[:page].to_i || 1), per_page: 50, sort: (params[:sort] || 'title'), sort_order: (params[:order] || 'asc'), search: 'test' })
    @releases = @albums[:releases]
    pagination = @albums[:pagination]
    @pagination = WillPaginate::Collection.create(pagination[:page], pagination[:per_page], pagination[:pages]) { |pager| pager.total_entries = pagination[:items] }
  end
end