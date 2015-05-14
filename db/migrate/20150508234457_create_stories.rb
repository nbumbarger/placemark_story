class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :name, :null=> false
      t.string :synopsis
      t.datetime :deleted_at
    end
  end
end
