class StachePicsController < ApplicationController

  def create
    if params[:text].empty? || params[:text].downcase == "me"
      send_that_user_a_stache(params)
    else
      send_their_friend_a_stache(params)
    end
  end

  private

  def send_that_user_a_stache(params)
    mustache_request = MustacheRequest.create(uid: params[:user_id],
                                              channel: params[:channel_id])

    render json: stache_for_user_response

    Thread.new {
      SlackTeam.find_by(team_id: params[:team_id]).mustache_requests << mustache_request
      MustacheRequestProcessor.process(mustache_request)
  }
  end

  def stache_for_user_response
    {
  "response_type": "in_channel",
  "text": "So you want a mustache, eh?"
    }
  end

  def send_their_friend_a_stache(params)
    screen_name = params[:text][1..-1]
    user = User.find_by(screen_name: screen_name)
    if user
      mustache_request = MustacheRequest.create(uid: user.uid,
                                                channel: params[:channel_id])
      response = stache_for_friend_response(user)
    else
      mustache_request = MustacheRequest.create(uid: params[:user_id],
                                                channel: params[:channel_id])
      response = friend_not_found_response
    end

  render json: response

      Thread.new {
        SlackTeam.find_by(team_id: params[:team_id]).mustache_requests << mustache_request
        MustacheRequestProcessor.process(mustache_request)
    }

  end

  def stache_for_friend_response(user)
    {
      "response_type": "in_channel",
      "text": "So you want to stache #{user.first_name}, eh?"
    }
  end

  def friend_not_found_response
    {
      "response_type": "in_channel",
      "text": "That's not a person! Why don't you just go Stache Yo Self!"
    }
  end
end
