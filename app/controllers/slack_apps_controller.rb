class SlackAppsController < ApplicationController

  def create
    code = params[:code]
    binding.pry
    response = JSON.parse(SlackService.oauth_response(code).options[:response_body])
    SlackTeam.create(team_id: response[:team_id],
                     team_name: response[:team_name],
                     access_token: response[:access_token],
                     bot_token: response[:bot][:bot_access_token],
                     bot_user_id: response[:bot][:bot_user_id])

    redirect_to # Github page with readme on app

  # Slack teams have many mustache requests
  # Mustache Requests have one slack team

  # configure slack chat messages to use mustache_request.slack_team.bot_token
  end
end
