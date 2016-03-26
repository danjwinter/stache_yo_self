class FacePlusPlusService

  def self.add_face_location(mustache_request)
    request = Typhoeus::Request.new("http://apius.faceplusplus.com/detection/detect",
                                     params: {mode: "oneface",
                                              api_key: ENV['FACE_KEY'],
                                              api_secret: ENV['FACE_SECRET'],
                                              url: mustache_request.user_info.image_url})
    request.on_complete do |response|
      # byebug
      json_response = parse(response.options[:response_body])
      if json_response.has_key?(:error)

        # image = Magick::Image.read(mustache_request.user_info.image_url).first
        # processed_image = StringIO.open(image.resize_to_fill(400,400))
        pic = URI.parse(mustache_request.user_info.image_url)
        mustache_request.original_user_image = pic
        mustache_request.save
        byebug
        mustache_request.user_info.image_url = mustache_request.original_user_image.url(:medium)
        FacePlusPlusService.add_face_location(mustache_request)
      else
        save_face_location_info(mustache_request, json_response)
        MustacheRequestProcessor.process(mustache_request)
      end
    end
    request.run
  end

  private

  def self.use_resized_binary_for_face_location
    request = Typhoeus::Request.new("http://apius.faceplusplus.com/detection/detect",
                                     params: {mode: "oneface",
                                              api_key: ENV['FACE_KEY'],
                                              api_secret: ENV['FACE_SECRET'],
                                              image: mustache_request.user_info.image_url})

  end

  def save_face_info_and_stache_on(response)

  end

  def self.save_face_location_info(mustache_request, json_response)
    if json_response[:face].empty?
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
