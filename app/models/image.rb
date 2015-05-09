class Image < ActiveRecord::Base
  belongs_to :placemark
  validates :data, :alt, presence: true

end