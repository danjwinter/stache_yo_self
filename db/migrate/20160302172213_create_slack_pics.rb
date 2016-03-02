class CreateSlackPics < ActiveRecord::Migration
  def change
    create_table :slack_pics do |t|
      t.references :user, index: true, foreign_key: true
      t.string :face_id
      t.decimal :height
      t.decimal :width
      t.decimal :mouth_left_x
      t.decimal :mouth_left_y
      t.decimal :mouth_right_x
      t.decimal :mouth_right_y
      t.decimal :nose_x
      t.decimal :nose_y

      t.timestamps null: false
    end
  end
end
