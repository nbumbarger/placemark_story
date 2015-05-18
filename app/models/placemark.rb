class Placemark < ActiveRecord::Base
  belongs_to :story
  validates :name, :lat, :lng, presence: true
  default_scope {order('story_order ASC')}

  def index
    story.placemarks.order('id ASC').index(self) + 1
  end

  def all_next
    story.placemarks.where('id > ?', id)
  end

  def all_prev
    story.placemarks.where('id < ?', id)
  end

  def next
    all_next.first
  end

  def prev
    all_prev.last
  end

end