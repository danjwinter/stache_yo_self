class StacheMeController < ApplicationController

  def show
        response = {
      "response_type": "in_channel",
      "text": "So you want a mustache, eh?"
    }
    render json: response

    Thread.new {
      gather_and_send_stached_photo_response
  }
  end

  private

  def gather_and_send_stached_photo_response
    user = User.from_slack(params)
    # user.send_for_face_detection
    if user.headless?
      SlackService.new(user).post_headless_response
    else
      StacheThatPic.add_stache_to(user)
      SlackService.new(user).post_image("Stached!", "Sweet pic title")
    end
  end
end


# {"token"=>"HuOiI6EwL4DG57ZY0ZqP6UCV",
#  "team_id"=>"T029P2S9M",
#  "team_domain"=>"turingschool",
#  "channel_id"=>"C0PQ0FVJ8",
#  "channel_name"=>"test-mustache",
#  "user_id"=>"U09UB1KCN",
#  "user_name"=>"dan.winter",
#  "command"=>"/stache_me",
#  "text"=>"",
#  "response_url"=>"https://hooks.slack.com/commands/T029P2S9M/24662857762/cxyEwotsjSykD2OLnshQMtNk",
#  "formats"=>{"default"=>:json},
#  "controller"=>"stache_me",
#  "action"=>"show"}
