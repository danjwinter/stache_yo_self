class DropSlackPics < ActiveRecord::Migration
  def change
    drop_table :slack_pics
  end
end
