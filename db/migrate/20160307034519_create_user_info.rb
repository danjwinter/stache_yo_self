class CreateUserInfo < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.references :mustache_request, index: true, foreign_key: true
      t.string :image_url
      t.string :user_full_name
    end
  end
end
