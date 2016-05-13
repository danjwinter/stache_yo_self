class MustacheRequestProcessor

  def self.process(mustache_request)
    if mustache_request.has_no_user_info?
      SlackService.add_user_info(mustache_request)
    elsif mustache_request.has_no_original_image?
      StacheThatPic.save_original_image(mustache_request)
    elsif mustache_request.has_no_face_location_data?
      puts "made it to no face location"
      AddFaceLocationJob.perform_async(mustache_request.id)
    elsif mustache_request.headless?
      SlackService.post_headless_response(mustache_request)
    elsif mustache_request.has_no_stached_image?
      CreateStachedPictureJob.perform_async(mustache_request.id)
    else
      SlackService.post_stached_image(mustache_request)
    end
  end
end
