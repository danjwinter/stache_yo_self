class StacheMeController < ApplicationController

  def show
        response = {
      "response_type": "in_channel",
      "text": "So you want a mustache, eh?"
    }
    render json: response
    Thread.new {
    user = User.from_slack(params)
    binding.pry
    user.send_for_face_detection
    if user.headless?
      SlackService.new(user).post_headless_response
    else
      @pic = user.slack_pics.last
      slack_pic = Magick::Image.read(user.image.url).first
      sc = StacheCalculations.new(@pic)
      sized_slack_pic = slack_pic.resize_to_fill(400,400)
      stache_pic = Magick::Image.read("#{Rails.root}/app/assets/images/stache_1.png").first
      stache_scale = sc.stache_scale_width_enlarged * 400 * 1.2
      sized_stache = stache_pic.resize_to_fit(stache_scale,stache_scale)
      stached_slack_pic = sized_slack_pic.composite(sized_stache, sc.translate_x, sc.translate_y, Magick::OverCompositeOp)

      processed_image = StringIO.open(stached_slack_pic.to_blob)

      user.stached_user_image = processed_image
      user.save!
      SlackService.new(user).post_image(user.channel, "Stached!", "Sweet pic title", user.stached_user_image.url)
      # binding.pry
    end
    # binding.pry
    # response = {text: "Stached!",
    #             attachments: [{title: "ATitle",
    #                            image_url: user.stached_user_image.url}]}
                             }

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
