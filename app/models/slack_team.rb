class SlackTeam < ActiveRecord::Base
  has_many :users
  has_many :mustache_requests

  def self.configure(code)
    response = response(code)
    slack_team = find_or_create_by(team_id: response[:team_id])

    slack_team.update(team_name: response[:team_name],
                      access_token: response[:access_token],
                      bot_user_id: response[:bot][:bot_user_id],
                      bot_access_token: response[:bot][:bot_access_token])


    SlackService.save_users(slack_team)
  end

  private

  def self.response(code)
    parse(SlackService.oauth_response(code).options[:response_body])
  end

  def self.parse(response)
    JSON.parse(response, symbolize_names: true)
  end
end
