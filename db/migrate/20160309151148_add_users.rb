class AddUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :slack_team, index: true, foreign_key: true
      t.string :name
      t.string :uid
    end
  end
end
