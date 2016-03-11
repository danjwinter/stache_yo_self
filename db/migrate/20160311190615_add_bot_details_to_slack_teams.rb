class AddBotDetailsToSlackTeams < ActiveRecord::Migration
  def change
    add_column :slack_teams, :bot_user_id, :string
    add_column :slack_teams, :bot_access_token, :string
  end
end
