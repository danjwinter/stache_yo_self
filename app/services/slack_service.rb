class SlackService

  def self.add_user_info(mustache_request)
    request = Typhoeus::Request.new("https://slack.com/api/users.info",
                                     params: {user: mustache_request.uid,
                                              token: mustache_request.slack_team.access_token})
    request.on_complete do |response|
      json_response = parse(response.options[:response_body])
      mustache_request.user_info = UserInfo.create(image_url: "#{json_response[:user][:profile][:image_512] || json_response[:user][:profile][:image_192] || json_response[:user][:profile][:image_original]}" ,
                                                   user_full_name: json_response[:user][:real_name])
      MustacheRequestProcessor.process(mustache_request)
    end
    request.run
  end


  def self.post_stached_image(mustache_request)
    Typhoeus.post("https://slack.com/api/chat.postMessage",
                                     params: {channel: mustache_request.channel,
                                              token: mustache_request.slack_team.access_token,
                                              text: "With A Great Stache Comes Great Responsibility.",
                                              attachments: '[{"title":"' + mustache_request.user_info.user_full_name + ' just got stached!","image_url": "' + mustache_request.stached_user_image.url + '"}]'})
  end

  def self.post_headless_response(mustache_request)
    Typhoeus.post("https://slack.com/api/chat.postMessage",
                                     params: {channel: mustache_request.channel,
                                              token: mustache_request.slack_team.access_token,
                                              text: "Life's rough being headless, #{mustache_request.user_info.user_full_name.split[0]}.",
                                              attachments: '[{"title":"But, with time, even the headless can know the joys of a Stache.","image_url": "http://i.imgur.com/9GhYZ9J.png"}]'})

  end

  def self.oauth_response(code)
    Typhoeus.post("https://slack.com/api/oauth.access",
                  params: {client_id: ENV['SLACK_KEY'],
                           client_secret: ENV['SLACK_SECRET'],
                           code: code})
  end

  def self.save_users(slack_team)
    response = parse(Typhoeus.post("https://slack.com/api/users.list",
                            params: {token: slack_team.access_token}).options[:response_body])

    response[:members].each do |member_data|
      user = User.find_or_create_by(uid: member_data[:id])
        user.update(screen_name: member_data[:name],
                    first_name: member_data[:profile][:first_name])
      slack_team.users << user
                                    end
  end

  private

  def self.parse(response)
    JSON.parse(response, symbolize_names: true)
  end
end
