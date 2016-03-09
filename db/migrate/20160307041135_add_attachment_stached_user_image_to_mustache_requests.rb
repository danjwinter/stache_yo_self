class AddAttachmentStachedUserImageToMustacheRequests < ActiveRecord::Migration
  def self.up
    change_table :mustache_requests do |t|
      t.attachment :stached_user_image
    end
  end

  def self.down
    remove_attachment :mustache_requests, :stached_user_image
  end
end
