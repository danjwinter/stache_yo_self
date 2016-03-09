class StachePicsController < ApplicationController

  def create
    mustache_request = MustacheRequest.create(uid: params[:user_id],
                                              channel: params[:channel_id])
        response = {
      "response_type": "in_channel",
      "text": "So you want a mustache, eh?"
    }
    render json: response

    Thread.new {
      binding.pry
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
