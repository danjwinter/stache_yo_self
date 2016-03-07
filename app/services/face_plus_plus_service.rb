class FacePlusPlusService
  attr_reader :connection, :user

  def initialize(user)
    @connection ||= Faraday.new(url: "http://apius.faceplusplus.com/") do |faraday|
      faraday.request :url_encoded
      faraday.headers['Content-Type'] = 'application/json'
      faraday.adapter Faraday.default_adapter
    end
    @user = user
  end

  def self.add_face_location(mustache_request)
    request = parse(Typhoeus::Request.new("http://apius.faceplusplus.com/detection/detect",
                                     params: {mode: "oneface",
                                              api_key: ENV['FACE_KEY'],
                                              api_secret: ENV['FACE_SECRET'],
                                              url: mustache_request.image_url}))
    request.on_complete do |response|
      if response['face'].empty?
        mustache_request.update(headless: true)
      else
        mustache_request.update(headless: false)
        mustache_request.face_location.create(mouth_left_x: response['face'][0]['position']['mouth_left']['x'],
                                            mouth_left_y: response['face'][0]['position']['mouth_left']['y'],
                                            mouth_right_x: response['face'][0]['position']['mouth_right']['x'],
                                            mouth_right_y: response['face'][0]['position']['mouth_right']['y'],
                                            nose_y: response['face'][0]['position']['nose']['y'])
        MustacheRequestProcessor.process(mustache_request)
      end
    end
  end

  def detect_face
    parse(connection.get("detection/detect", mode: "oneface", api_key: ENV['FACE_KEY'], api_secret: ENV['FACE_SECRET'], url: user.image_url))
  end

  def more_details
    parse(connection.get("detection/landmark", face_id: user.slack_pics.last.face_id, api_key: ENV['FACE_KEY'], api_secret: ENV['FACE_SECRET']))
  end


  private

  def self.parse(response)
    JSON.parse(response.body, symbolize_name: true)
  end

  def parse(response)
    JSON.parse(response.body, symbolize_name: true)
  end

  def include_tokens
    {api_key: ENV['FACE_KEY'], api_secret: ENV['FACE_SECRET']}
  end
end
