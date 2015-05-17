class Placemark < ActiveRecord::Base
  belongs_to :story
  validates :name, :lat, :lng, presence: true

  def next
    story.placemarks.where("id > ?", id).first
  end

  def prev
    story.placemarks.where("id < ?", id).last
  end

end