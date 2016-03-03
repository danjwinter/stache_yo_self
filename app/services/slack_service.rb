class SlackService
  attr_reader :connection, :user, :user_id

  def initialize(user, user_id=nil)
    @connection ||= Faraday.new(url: "https://slack.com/api/") do |faraday|
      faraday.request :url_encoded
      faraday.headers['Content-Type'] = 'application/json'
      faraday.adapter Faraday.default_adapter
    end
    @user = user
    @user_id = user_id

    add_token_to_headers
  end

  def list_channels
    channel_response['channels'].map do |channel|
      Channel.new(channel)
    end
  end

  def post_image(channel, text="test", title="test-title")
    parse(connection.post("chat.postMessage",
                          channel: channel,
                          text: text,
                          token: user.token,
                          attachments: '[{"title":"ATitle","image_url": "http://static6.businessinsider.com/image/55918b77ecad04a3465a0a63/nbc-fires-donald-trump-after-he-calls-mexicans-rapists-and-drug-runners.jpg"}]'))
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
