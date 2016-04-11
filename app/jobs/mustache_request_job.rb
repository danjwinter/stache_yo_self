class MustacheRequestJob
  include SuckerPunch::Job

  def perform(mustache_request_id)
    ActiveRecord::Base.connection_pool.with_connection do
      mustache_request = MustacheRequest.find(mustache_request_id)
      MustacheRequestProcessor.process(mustache_request)
    end
  end
end
