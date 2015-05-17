class CreatePlacemarks < ActiveRecord::Migration
  def change
    create_table :placemarks do |t|
      t.belongs_to :story
      t.string :name, :null=> false
      t.text :description
      t.decimal :lat, :null=> false
      t.decimal :lng, :null=> false
      t.binary :image_data
      t.string :image_alt
      t.datetime :deleted_at
    end
  end
end
