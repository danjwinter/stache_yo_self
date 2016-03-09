class SlackAppsController < ApplicationController

  def create
    code = params[:code]
    response = JSON.parse(SlackService.oauth_response(code).options[:response_body], symbolize_names: true)
    # binding.pry
    slack_team = SlackTeam.create(team_id: response[:team_id],
                     team_name: response[:team_name],
                     access_token: response[:access_token],
                     bot_token: response[:bot][:bot_access_token],
                     bot_user_id: response[:bot][:bot_user_id])

    SlackService.save_users(slack_team)

    redirect_to "http://github.com/danjwinter/stache_yo_self"

  # Slack teams have many mustache requests
  # Mustache Requests have one slack team

  # configure slack chat messages to use mustache_request.slack_team.bot_token
  end
end
