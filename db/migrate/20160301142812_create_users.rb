class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :location
      t.string :image_url
      t.string :url

      t.timestamps null: false
    end
  end
end
