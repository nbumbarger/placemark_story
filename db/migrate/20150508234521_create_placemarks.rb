class CreatePlacemarks < ActiveRecord::Migration
  def change
    create_table :placemarks do |t|
      t.belongs_to :story
      t.string :name, :null=> false
      t.text :synopsis
      t.text :full_text
      t.decimal :lat, :null=> false
      t.decimal :lon, :null=> false
      t.binary :image_data, :null=> false
      t.string :image_alt, :null=> false
      t.datetime :deleted_at
    end
  end
end
