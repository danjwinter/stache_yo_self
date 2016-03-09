class CreateFaceLocations < ActiveRecord::Migration
  def change
    create_table :face_locations do |t|
      t.references :mustache_request, index: true, foreign_key: true
      t.decimal :mouth_left_x
      t.decimal :mouth_right_x
      t.decimal :mouth_left_y
      t.decimal :mouth_right_y
      t.decimal :nose_y

      t.timestamps null: false
    end
  end
end
