class MustacheRequestProcessor

  def self.process(mustache_request)
    # binding.pry
    if !mustache_request.user_info
      SlackService.add_user_info(mustache_request)
      # response =  go get it (User info process has on_complete )

    elsif !mustache_request.face_location
      FacePlusPlusService.add_face_location(mustache_request)
      # go get it
    elsif mustache_request.headless?
      # send headless response
      SlackService.post_headless_response(mustache_request)
    elsif !mustache_request.has_stached_image?
      StacheThatPic.create_image(mustache_request)
      # go stache it
    else
      # binding.pry
      SlackService.post_stached_image(mustache_request)
      # send stache response
    end

    # case mustache_request.last_completed_request
    #
    # when ""
  end
end




    # STEPS
    # user_info = SlackService.new().user_info and update mustache_request
    # send out for facial detection and save
    # if  headless clause
    # image processing logic to create new stached image and save
    # slack service post image to slack




# Each step calls process for mustache request processor
# Process is an if elsif chain that checks to see if a database association exists IE user info OR face detection info OR stached_photo
# if that relation doesn't exist then go do it
#



# WAY 2
# process is defined as a case statement that checks database field called state which

# indicates which step in the process it is and then tells it what to do next.



#
#
#
#     # non-blocking
# request1 = Typhoeus::Request.new("http://stackoverflow.com/") #user info
# request1.on_complete do |response|
#   # UserProcessor.complete_request
#   # FacialDetection.doRequest(mustacheRequest)
# end
#
# # def FacialDetection.doRequest
# #   request = kldjfskldsjfkldsjlk s
# #   request.on_complete do |response|
# #   CallNextlyer and that def has an on_complete
# #end
# #end
# request2 = Typhoeus::Request.new("http://stackoverflow.com/questions")
# request2.on_complete do |response|
#   puts response.body
# end
#   end
# end
