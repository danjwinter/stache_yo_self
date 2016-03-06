class AddHeadlessToUsers < ActiveRecord::Migration
  def change
    add_column :users, :headless, :boolean
  end
end
