class RemoveBotUserIdFromSlackTeams < ActiveRecord::Migration
  def change
    remove_column :slack_teams, :bot_user_id, :string
  end
end
