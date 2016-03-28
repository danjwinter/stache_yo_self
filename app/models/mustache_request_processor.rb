class MustacheRequestProcessor

  def self.process(mustache_request)
    if !mustache_request.user_info
      SlackService.add_user_info(mustache_request)
    elsif mustache_request.has_no_original_image?
      StacheThatPic.save_original_image(mustache_request)
    elsif !mustache_request.face_location
      FacePlusPlusService.add_face_location(mustache_request)
    elsif mustache_request.headless?
      SlackService.post_headless_response(mustache_request)
    elsif !mustache_request.has_stached_image?
      StacheThatPic.create_image(mustache_request)
    else
      SlackService.post_stached_image(mustache_request)
    end
  end
end
