class StachePicResponder

  def self.send_that_user_a_stache(params)
    request = mustache_request(params)

    start_mustacheing(request)

    stache_for_user_response
  end

  def self.send_that_website_a_stache(params)
    request = mustache_request(params)
    request.update(website_request: true)
    request.user_info = UserInfo.create(image_url: params[:text],
                                        user_full_name: "Somebody")

    start_mustacheing(request)

    stache_for_website_response
  end



  def self.send_their_friend_a_stache(params)
    screen_name = params[:text][1..-1]
    user = User.find_by(screen_name: screen_name)
    if user
      request = mustache_request(params, user.uid)
      response = stache_for_friend_response(user)
    else
      request = mustache_request(params)
      response = friend_not_found_response
    end

    start_mustacheing(request)

    response
  end

  private

  def self.mustache_request(params, uid=nil)
    uid ||= params[:user_id]
    request = MustacheRequest.create(uid: uid,
                           channel: params[:channel_id])
    SlackTeam.find_by(team_id: params[:team_id]).mustache_requests << request
    request
  end

  def self.start_mustacheing(mustache_request)
    Thread.new {
      MustacheRequestProcessor.process(mustache_request)
  }
  end

  def self.stache_for_website_response
    {
  "response_type": "in_channel",
  "text": "So you want to mustache that website, eh?"
    }
  end

  def self.stache_for_user_response
    {
  "response_type": "in_channel",
  "text": "So you want a mustache, eh?"
    }
  end

  def self.stache_for_friend_response(user)
    {
      "response_type": "in_channel",
      "text": "So you want to stache #{user.first_name}, eh?"
    }
  end

  def self.friend_not_found_response
    {
      "response_type": "in_channel",
      "text": "That's not a person! Why don't you just go Stache Yo Self!"
    }
  end
end
