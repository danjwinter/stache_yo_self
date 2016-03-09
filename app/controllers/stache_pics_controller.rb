class StachePicsController < ApplicationController

  def create
    if params[:text].empty? || params[:text].downcase == "me"
    mustache_request = MustacheRequest.create(uid: params[:user_id],
                                              channel: params[:channel_id])
        response = {
      "response_type": "in_channel",
      "text": "So you want a mustache, eh?"
    }
    render json: response

    Thread.new {
      SlackTeam.find_by(team_id: params[:team_id]).mustache_requests << mustache_request
      MustacheRequestProcessor.process(mustache_request)
  }
else
  create_for_other(params)
end
  end

  def create_for_other(params)
    user_name = params[:text][1..-1]
    user = User.find_by(name: user_name)
    if user
      mustache_request = MustacheRequest.create(uid: user.uid,
                                                channel: params[:channel_id])
      response = {
        "response_type": "in_channel",
        "text": "So you want to stache #{user.name}, eh?"
      }
    else
      # What if a new user signs up AFTER app has been integrated??
      # Need to query user infos and again re-add new people to DB
      # OR Background worker to check for and add new users each day
      # Heroku scheduler
      mustache_request = MustacheRequest.create(uid: params[:user_id],
                                                channel: params[:channel_id])
      response = {
        "response_type": "in_channel",
        "text": "That's not a person! Why don't you just go Stache Yo Self!"
      }
    end

  render json: response

  Thread.new {
    SlackTeam.find_by(team_id: params[:team_id]).mustache_requests << mustache_request
    MustacheRequestProcessor.process(mustache_request)
}

  end

  private

  def gather_and_send_stached_photo_response
    user = User.from_slack(params)
    if user.headless?
      SlackService.new(user).post_headless_response
    else
      StacheThatPic.add_stache_to(user)
      SlackService.new(user).post_image("With A Great Stache Comes Great Responsibility", "#{user.name} just got stached!")
    end
  end
end
