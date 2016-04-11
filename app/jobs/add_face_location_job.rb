class AddFaceLocationJob
  include SuckerPunch::Job
  workers 3

  def perform(mustache_request_id)
    ActiveRecord::Base.connection_pool.with_connection do
      mustache_request = MustacheRequest.find(mustache_request_id)
      FacePlusPlusService.add_face_location(mustache_request)
    end
  end
end
