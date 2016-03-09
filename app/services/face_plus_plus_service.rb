class FacePlusPlusService
  # attr_reader :connection, :user
  #
  # def initialize(user)
  #   @connection ||= Faraday.new(url: "http://apius.faceplusplus.com/") do |faraday|
  #     faraday.request :url_encoded
  #     faraday.headers['Content-Type'] = 'application/json'
  #     faraday.adapter Faraday.default_adapter
  #   end
  #   @user = user
  # end

  def self.add_face_location(mustache_request)
    request = Typhoeus::Request.new("http://apius.faceplusplus.com/detection/detect",
                                     params: {mode: "oneface",
                                              api_key: ENV['FACE_KEY'],
                                              api_secret: ENV['FACE_SECRET'],
                                              url: mustache_request.user_info.image_url})
    request.on_complete do |response|
      json_response = parse(response.options[:response_body])
      if json_response['face'].empty?
        mustache_request.update(headless: true)
        mustache_request.face_location = FaceLocation.create
      else
        mustache_request.update(headless: false)
        mustache_request.face_location = FaceLocation.create(mouth_left_x: json_response['face'][0]['position']['mouth_left']['x'],
                                            mouth_left_y: json_response['face'][0]['position']['mouth_left']['y'],
                                            mouth_right_x: json_response['face'][0]['position']['mouth_right']['x'],
                                            mouth_right_y: json_response['face'][0]['position']['mouth_right']['y'],
                                            nose_y: json_response['face'][0]['position']['nose']['y'])
      end
      MustacheRequestProcessor.process(mustache_request)
    end
    request.run
  end

  # def detect_face
  #   parse(connection.get("detection/detect", mode: "oneface", api_key: ENV['FACE_KEY'], api_secret: ENV['FACE_SECRET'], url: user.image_url))
  # end
  #
  # def more_details
  #   parse(connection.get("detection/landmark", face_id: user.slack_pics.last.face_id, api_key: ENV['FACE_KEY'], api_secret: ENV['FACE_SECRET']))
  # end


  private

  def self.parse(response)
    JSON.parse(response, symbolize_name: true)
  end

  # def parse(response)
  #   JSON.parse(response.body, symbolize_name: true)
  # end
  #
  # def include_tokens
  #   {api_key: ENV['FACE_KEY'], api_secret: ENV['FACE_SECRET']}
  # end
end
