class SlackService
  attr_reader :connection, :user, :user_id

  def initialize(user, user_id=nil)
    @connection ||= Faraday.new(url: "https://slack.com/api/") do |faraday|
      faraday.request :url_encoded
      faraday.request :multipart
      # faraday.headers['Content-Type'] = 'application/json'
      faraday.adapter Faraday.default_adapter
    end
    @user = user
    @user_id = user_id

  end

  def list_channels
    channel_response['channels'].map do |channel|
      Channel.new(channel)
    end
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
                                                token: ENV['SLACK_BOT_TOKEN']))
                          # attachments: '[{"title":"'+ title + '","image_url": "' + image_url + '"}]'))
  end

  def user_info
    parse(connection.get('users.info', user: user_id, token: ENV['SLACK_BOT_TOKEN']))
  end

  private

  def channel_response
    parse(connection.get("channels.list", token: user.token, exclude_archived: 1))
  end

  def parse(response)
    JSON.parse(response.body, symbolize_name: true)
  end

  def add_token_to_headers
    connection.headers = {token: user.token}
  end
end
