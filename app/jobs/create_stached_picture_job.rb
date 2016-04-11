class CreateStachedPictureJob
  include SuckerPunch::Job
  workers 4

  def perform(mustache_request_id)
    ActiveRecord::Base.connection_pool.with_connection do
      mustache_request = MustacheRequest.find(mustache_request_id)
      StacheThatPic.create_image(mustache_request)
    end
  end
end
