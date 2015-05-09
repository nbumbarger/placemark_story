class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.belongs_to :placemark
      t.binary :data, :null=> false
      t.string :alt, :null=> false
      t.datetime :deleted_at
    end
  end
end
