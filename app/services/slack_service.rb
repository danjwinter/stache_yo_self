class SlackService
  attr_reader :connection, :user

  def initialize(user)
    @connection ||= Faraday.new(url: "https://slack.com/api/") do |faraday|
      faraday.request :url_encoded
      faraday.request :multipart
      faraday.adapter Faraday.default_adapter
    end
    @user = user
  end

  def self.add_user_info(mustache_request)
    # binding.pry
    request = Typhoeus::Request.new("https://slack.com/api/users.info",
                                     params: {user: mustache_request.uid,
                                              token: mustache_request.slack_team.access_token})
    request.on_complete do |response|
      json_response = parse(response.options[:response_body])
      # binding.pry
      mustache_request.user_info = UserInfo.create(image_url: "#{json_response[:user][:profile][:image_512] || json_response[:user][:profile][:image_original]}" ,
                                        user_full_name: json_response[:user][:real_name])
      MustacheRequestProcessor.process(mustache_request)
    end
    request.run
  end


  def self.post_stached_image(mustache_request)
    Typhoeus.post("https://slack.com/api/chat.postMessage",
                                     params: {channel: mustache_request.channel,
                                              token: ENV['SLACK_BOT_TOKEN'],
                                              text: "With A Great Stache Comes Great Responsibility.",
                                              attachments: '[{"title":"' + mustache_request.user_info.user_full_name + ' just got stached!","image_url": "' + mustache_request.stached_user_image.url + '"}]'})
  end

  def self.post_headless_response(mustache_request)
    Typhoeus.post("https://slack.com/api/chat.postMessage",
                                     params: {channel: mustache_request.channel,
                                              token: ENV['SLACK_BOT_TOKEN'],
                                              text: "Life's rough being headless.",
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
      slack_team.users << User.find_or_create_by(name: member_data[:name],
                                                uid: member_data[:id])
                                    end
  end

  private

  def self.parse(response)
    JSON.parse(response, symbolize_names: true)
  end
end
