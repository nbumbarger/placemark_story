class Story < ActiveRecord::Base
  has_many :placemarks
  validates :name, presence: true
  
end