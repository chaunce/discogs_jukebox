class Album < ActiveRecord::Base
  scope :queued, -> { where(started_at: nil, completed_at: nil).order(:created_at => :asc) }
  scope :playing, -> { where(completed_at: nil).where.not(started_at: nil).order(:created_at => :asc) }
  scope :played, -> { where.not(completed_at: nil, started_at: nil).order(:created_at => :desc) }

  def start
    update_attributes(started_at: Time.now)
  end

  def complete
    update_attributes(completed_at: Time.now)
  end

  def self.cleanup
    Album.where(started_at: nil).where.not(completed_at: nil).each { |album| album.update_attributes(started_at: album.completed_at) }
    Album.where(completed_at: nil).where.not(started_at: nil).each { |album| album.update_attributes(completed_at: album.started_at) }
  end

  def self.next
    complete
    start
  end

  def self.start
    Album.queued.first.start
  end

  def self.complete
    Album.playing.where(completed_at: nil).where.not(started_at: nil).each { |album| album.update_attributes(completed_at: album.started_at) }
  end
end
