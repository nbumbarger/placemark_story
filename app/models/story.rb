class Story < ActiveRecord::Base
  belongs_to :user
  has_many :placemarks, :dependent => :destroy
  validates_presence_of :name, :message => "You must enter a name for this story" 

  # as your app grows, you may want to look into tools to help build JSON more
  # declaratively, such as ActiveModel::Serializer (my preference) or jbuilder.
  def generate_GeoJSON
    @geojson = Array.new
    placemarks.all.each do |placemark|
      @geojson << {
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [placemark.lng, placemark.lat]
        },
        properties: {
          name: placemark.name,
          description: placemark.description,
          image: placemark.image_data,
          image_alt: placemark.image_alt,
          link: placemark.link,
          :'marker-color' => '#f00'
        }
      }
    end
    return @geojson
  end

end