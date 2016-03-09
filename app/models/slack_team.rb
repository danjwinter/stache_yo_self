class SlackTeam < ActiveRecord::Base
  has_many :users
  has_many :mustache_requests

  def self.configure(code)
    response = JSON.parse(SlackService.oauth_response(code).options[:response_body], symbolize_names: true)

    slack_team = create(team_id: response[:team_id],
                        team_name: response[:team_name],
                        access_token: response[:access_token],
                        bot_token: response[:bot][:bot_access_token],
                        bot_user_id: response[:bot][:bot_user_id])

    SlackService.save_users(slack_team)
  end
end
