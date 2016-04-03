class FacePlusPlusService

  def self.add_face_location(mustache_request)
    request = Typhoeus::Request.new("http://apius.faceplusplus.com/detection/detect",
                                     params: {mode: "oneface",
                                              api_key: ENV['FACE_KEY'],
                                              api_secret: ENV['FACE_SECRET'],
                                              url: mustache_request.original_user_image.url})
    request.on_complete do |response|
      json_response = parse(response.options[:response_body])
      save_face_location_info(mustache_request, json_response)
      MustacheRequestProcessor.process(mustache_request)
    end
    request.run
  end

  private

  def self.save_face_location_info(mustache_request, json_response)
    if json_response[:error] || json_response[:face].empty?
      mustache_request.update(headless: true)
      mustache_request.face_location = FaceLocation.create
    else
      mustache_request.update(headless: false)
      mustache_request.face_location = FaceLocation.create(mouth_left_x: json_response[:face][0][:position][:mouth_left][:x],
                                          mouth_left_y: json_response[:face][0][:position][:mouth_left][:y],
                                          mouth_right_x: json_response[:face][0][:position][:mouth_right][:x],
                                          mouth_right_y: json_response[:face][0][:position][:mouth_right][:y],
                                          nose_y: json_response[:face][0][:position][:nose][:y])
    end
  end

  def self.parse(response)
    JSON.parse(response, symbolize_names: true)
  end
end
