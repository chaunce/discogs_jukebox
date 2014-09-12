class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.string :artist
      t.string :image_url
      t.string :added_by
      t.datetime :started_at
      t.datetime :completed_at

      t.timestamps
    end
  end
end
