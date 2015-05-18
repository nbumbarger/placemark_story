class Story < ActiveRecord::Base
  has_many :placemarks
  validates :name, presence: true

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