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
    # this works for Typhoeus, need to adjust other services to match this one.
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

  def post_image(text="test", title="test-title")
    parse(connection.post("chat.postMessage",
                          channel: user.channel,
                          text: text,
                          token: ENV['SLACK_BOT_TOKEN'],
                          attachments: '[{"title":"'+ title + '","image_url": "' + user.stached_user_image.url + '"}]'))
  end

  def self.post_stached_image(mustache_request)
    Typhoeus.post("https://slack.com/api/chat.postMessage",
                                          # method: :post,
                                     params: {channel: mustache_request.channel,
                                              token: ENV['SLACK_BOT_TOKEN'],
                                              text: "With A Great Stache Comes Great Responsibility.",
                                              attachments: '[{"title":"' + mustache_request.user_info.user_full_name + ' just got stached!","image_url": "' + mustache_request.stached_user_image.url + '"}]'})
  end

  def self.post_headless_response(mustache_request)
    Typhoeus.post("https://slack.com/api/chat.postMessage",
                                          # method: :post,
                                     params: {channel: mustache_request.channel,
                                              token: ENV['SLACK_BOT_TOKEN'],
                                              text: "Life's rough being headless."})
    # request.on_complete do |response|
    #   mustache_request.user_info.create(image_url: response['user']['profile']['image_512'],
    #                                     user_full_name: response['user']['real_name'])
    #   MustacheRequestProcessor.process(mustache_request)
    # end
    #
    # parse(connection.post("chat.postMessage",
    #                       channel: user.channel,
    #                       text: "Life's rough being headless. Enjoy this cat giffy to take your mind off it",
    #                       token: ENV['SLACK_BOT_TOKEN']))
    #
    #                       parse(connection.post("chat.postMessage",
    #                                             channel: user.channel,
    #                                             text: "/giphy kitten",
    #                                             token: ENV['SLACK_BOT_TOKEN'],
    #                       attachments: '[{"title":"'+ title + '","image_url": "' + image_url + '"}]'))
  end

  def user_info
    parse(connection.get('users.info', user: user.uid, token: ENV['SLACK_BOT_TOKEN']))
  end

  private

  def self.parse(response)
    JSON.parse(response, symbolize_name: true)
  end

  def parse(response)
    JSON.parse(response.body, symbolize_name: true)
  end
end
