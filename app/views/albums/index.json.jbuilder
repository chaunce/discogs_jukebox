json.array!(@albums) do |album|
  json.extract! album, :id, :name, :artist, :image_url, :started_at, :completed_at
  json.url album_url(album, format: :json)
end
