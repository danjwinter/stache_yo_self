class FacePlusPlusService

  def self.add_face_location(mustache_request)
    request = Typhoeus::Request.new("https://api-us.faceplusplus.com/facepp/v3/detect",
                                     params: {return_landmark: 1,
                                              api_key: ENV['FACE_KEY'],
                                              api_secret: ENV['FACE_SECRET'],
                                              image_url: mustache_request.original_user_image.url(:medium)})
# original request below
    # request = Typhoeus::Request.new("http://apius.faceplusplus.com/detection/detect",
    #                                  params: {mode: "oneface",
    #                                           api_key: ENV['FACE_KEY'],
    #                                           api_secret: ENV['FACE_SECRET'],
    #                                           url: mustache_request.original_user_image.url(:medium)})
    request.on_complete do |response|
      json_response = parse(response.options[:response_body])
      save_face_location_info(mustache_request, json_response)
      MustacheRequestJob.perform_async(mustache_request.id)
    end
    hydra = Typhoeus::Hydra.hydra
    hydra.queue(request)
    hydra.queue(SlackService.update_user(mustache_request))
    hydra.run
  end

  private

  def self.save_face_location_info(mustache_request, json_response)
    puts "This is the JSON response:"
    puts json_response
    if json_response[:error] || json_response[:faces].empty?
      mustache_request.update(headless: true)
      mustache_request.face_location = FaceLocation.create
    else
      mustache_request.update(headless: false)
# original api face location below
      # mustache_request.face_location = FaceLocation.create(mouth_left_x: json_response[:face][0][:position][:mouth_left][:x],
      #                                     mouth_left_y: json_response[:face][0][:position][:mouth_left][:y],
      #                                     mouth_right_x: json_response[:face][0][:position][:mouth_right][:x],
      #                                     mouth_right_y: json_response[:face][0][:position][:mouth_right][:y],
      #                                     nose_y: json_response[:face][0][:position][:nose][:y])
      mustache_request.face_location = FaceLocation.create(mouth_left_x: json_response[:faces][0][:landmark][:mouth_left_corner][:x],
                                          mouth_left_y: json_response[:faces][0][:landmark][:mouth_left_corner][:y],
                                          mouth_right_x: json_response[:faces][0][:landmark][:mouth_right_corner][:x],
                                          mouth_right_y: json_response[:faces][0][:landmark][:mouth_right_corner][:y],
                                          nose_y: json_response[:faces][0][:landmark][:nose_tip][:y])
    end
  end

  def self.parse(response)
    JSON.parse(response, symbolize_names: true)
  end
end
