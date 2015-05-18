class CreatePlacemarks < ActiveRecord::Migration
  def change
    create_table :placemarks do |t|
      t.belongs_to :story
      t.string :name, :null=> false
      t.text :description
      t.text :link
      t.decimal :lat, :null=> false
      t.decimal :lng
      t.binary :image_data
      t.string :image_alt
      t.integer :story_order
      t.datetime :deleted_at
    end
  end
end
