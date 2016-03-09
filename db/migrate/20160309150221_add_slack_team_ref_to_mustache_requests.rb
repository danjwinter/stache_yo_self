class AddSlackTeamRefToMustacheRequests < ActiveRecord::Migration
  def change
    add_reference :mustache_requests, :slack_team, index: true, foreign_key: true
  end
end
