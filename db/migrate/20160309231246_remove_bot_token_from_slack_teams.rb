class RemoveBotTokenFromSlackTeams < ActiveRecord::Migration
  def change
    remove_column :slack_teams, :bot_token, :string
  end
end
