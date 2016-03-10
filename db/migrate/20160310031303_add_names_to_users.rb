class AddNamesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :screen_name, :string
    add_column :users, :first_name, :string
  end
end
