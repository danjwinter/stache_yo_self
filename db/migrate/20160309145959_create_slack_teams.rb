class CreateSlackTeams < ActiveRecord::Migration
  def change
    create_table :slack_teams do |t|
      t.string :team_id
      t.string :team_name
      t.string :access_token
      t.string :bot_token
      t.string :bot_user_id
    end
  end
end
