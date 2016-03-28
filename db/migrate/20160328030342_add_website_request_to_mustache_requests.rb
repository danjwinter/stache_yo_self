class AddWebsiteRequestToMustacheRequests < ActiveRecord::Migration
  def change
    add_column :mustache_requests, :website_request, :boolean
  end
end
