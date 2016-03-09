class AddHeadlessToMustacheRequest < ActiveRecord::Migration
  def change
    add_column :mustache_requests, :headless, :boolean
  end
end
