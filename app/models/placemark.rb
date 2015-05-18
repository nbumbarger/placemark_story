class Placemark < ActiveRecord::Base
  belongs_to :story
  validates_presence_of :name, :message => "You must enter a name for this placemark" 
  validates_presence_of :lat, :message => "Use the interactive location selector to set latitude" 
  validates_presence_of :lng, :message => "Use the interactive location selector to set longitude" 
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