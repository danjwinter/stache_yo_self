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

  def post_image(text="test", title="test-title")
    parse(connection.post("chat.postMessage",
                          channel: user.channel,
                          text: text,
                          token: ENV['SLACK_BOT_TOKEN'],
                          attachments: '[{"title":"'+ title + '","image_url": "' + user.stached_user_image.url + '"}]'))
  end

  def post_headless_response(text="test", title="test-title")
    parse(connection.post("chat.postMessage",
                          channel: user.channel,
                          text: "Life's rough being headless. Enjoy this cat giffy to take your mind off it",
                          token: ENV['SLACK_BOT_TOKEN']))

                          parse(connection.post("chat.postMessage",
                                                channel: user.channel,
                                                text: "/giphy kitten",
                                                token: ENV['SLACK_BOT_TOKEN'],
                          attachments: '[{"title":"'+ title + '","image_url": "' + image_url + '"}]'))
  end

  def user_info
    parse(connection.get('users.info', user: user.uid, token: ENV['SLACK_BOT_TOKEN']))
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_name: true)
  end
end
