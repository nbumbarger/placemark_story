class Placemark < ActiveRecord::Base
  belongs_to :story
  has_many :images
  validates :name, :lat, :lon, presence: true

end