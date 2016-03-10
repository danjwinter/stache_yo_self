class SlackTeam < ActiveRecord::Base
  has_many :users
  has_many :mustache_requests

  def self.configure(code)
    response = parse(SlackService.oauth_response(code).options[:response_body])
    slack_team = find_or_create_by(team_id: response[:team_id],
                                   team_name: response[:team_name],
                                   access_token: response[:access_token])

    SlackService.save_users(slack_team)
  end

  private

  def self.parse(response)
    JSON.parse(response, symbolize_names: true)
  end
end
