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
    request = Typhoeus::Request.new("https://slack.com/api/users.info",
                                     params: {user: mustache_request.uid,
                                              token: ENV['SLACK_BOT_TOKEN']})
    request.on_complete do |response|
      json_response = parse(response.options[:response_body])
      mustache_request.user_info = UserInfo.create(image_url: json_response['user']['profile']['image_512'],
                                        user_full_name: json_response['user']['real_name'])
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
                                              attachments: '[{"title":"One Day The Headless Army Will Rise Again!","image_url": "http://i.imgur.com/9GhYZ9J.png"}]'})

  end

  private

  def self.parse(response)
    JSON.parse(response, symbolize_name: true)
  end
end
